unit PedidoVendaDAO;

interface

uses
  Classes, DBXCommon, PedidoVenda, ItemPedidoVenda, SqlExpr, SysUtils,
  EstoqueDAO;

type
  {$MethodInfo ON}
  TPedidoVendaDAO = class(TPersistent)
  private
    FComm: TDBXCommand;
    EstoqueDAO: TEstoqueDAO;

    procedure PrepareCommand;
  public
    function NextCodigo: string;
    function Insert(PedidoVenda: TPedidoVenda): Boolean;
    function Delete(CodigoPedidoVenda: string): Boolean;
    function InsertItemNoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
    function DeleteItemDoPedido(CodigoProduto, CodigoPedidoVenda: string): Boolean;
    function RelatorioPedidosVenda(DataInicial, DataFinal: TDateTime): TDBXReader;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses uSCPrincipal, StringUtils;

{ TPedidoVendaDAO }

constructor TPedidoVendaDAO.Create;
begin
  EstoqueDAO := TEstoqueDAO.Create;
end;

destructor TPedidoVendaDAO.Destroy;
begin
  EstoqueDAO.Free;
  inherited;
end;

procedure TPedidoVendaDAO.PrepareCommand;
begin
  if not(Assigned(FComm)) then
  begin
    if not(SCPrincipal.ConnTopCommerce.Connected) then
      SCPrincipal.ConnTopCommerce.Open;
    FComm := SCPrincipal.ConnTopCommerce.DBXConnection.CreateCommand;
    FComm.CommandType := TDBXCommandTypes.DbxSQL;
    if not(FComm.IsPrepared) then
      FComm.Prepare;
  end;
end;

function TPedidoVendaDAO.RelatorioPedidosVenda(DataInicial, DataFinal: TDateTime): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT V.*, I.CODIGO_PRODUTO, I.QUANTIDADE, P.DESCRICAO, P.PRECO_VENDA, C.NOME '+
                'FROM PEDIDOS_VENDA V '+
                'INNER JOIN ITENS_PEDIDO_VENDA I ON I.CODIGO_PEDIDO = V.CODIGO '+
                'INNER JOIN PRODUTOS P ON P.CODIGO = I.CODIGO_PRODUTO '+
                'LEFT JOIN CLIENTES C ON C.CODIGO = V.CODIGO_CLIENTE '+
                'WHERE P.CODIGO <> '''' ';
  if (DataInicial <> 0) then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), DATA, 112) >= '+FormatDateTime('yyyymmdd', DataInicial)+' ';
  if (DataFinal <> 0) then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), DATA, 112) <= '+FormatDateTime('yyyymmdd', DataFinal)+' ';
  Result := FComm.ExecuteQuery;
end;

function TPedidoVendaDAO.NextCodigo: string;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT MAX(CODIGO) AS MAX_CODIGO FROM PEDIDOS_VENDA';
    query.Open;
    if query.FieldByName('MAX_CODIGO').IsNull then
      Result := StrZero(1, 6)
    else
      Result := StrZero(query.FieldByName('MAX_CODIGO').AsInteger + 1, 6);
  finally
    query.Free;
  end;
end;

function TPedidoVendaDAO.Insert(PedidoVenda: TPedidoVenda): Boolean;
var
  query: TSQLQuery;
  Item: TItemPedidoVenda;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'INSERT INTO PEDIDOS_VENDA (CODIGO, DATA, DESCONTO, TIPO_PAGAMENTO';

      if PedidoVenda.Cliente <> nil then
        query.SQL.Text := query.SQL.Text + ', CODIGO_CLIENTE, NOME_CLIENTE_AVULSO) VALUES (:CODIGO, :DATA, :DESCONTO, :TIPO_PAGAMENTO, :CODIGO_CLIENTE, :NOME_CLIENTE_AVULSO)'
      else
        query.SQL.Text := query.SQL.Text + ', NOME_CLIENTE_AVULSO) VALUES (:CODIGO, :DATA, :DESCONTO, :TIPO_PAGAMENTO, :NOME_CLIENTE_AVULSO)';

      query.ParamByName('CODIGO').AsString          := PedidoVenda.Codigo;
      query.ParamByName('DATA').AsDateTime          := PedidoVenda.Data;
      query.ParamByName('DESCONTO').AsCurrency      := PedidoVenda.Desconto;
      query.ParamByName('TIPO_PAGAMENTO').AsInteger := PedidoVenda.TipoPagamento;

      if PedidoVenda.Cliente <> nil then
        query.ParamByName('CODIGO_CLIENTE').AsString := PedidoVenda.Cliente.Codigo;

      query.ParamByName('NOME_CLIENTE_AVULSO').AsString := PedidoVenda.NomeClienteAvulso;
      query.ExecSQL;

      query.SQL.Text := 'INSERT INTO ITENS_PEDIDO_VENDA (CODIGO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE) '+
                        'VALUES (:CODIGO_PEDIDO, :CODIGO_PRODUTO, :QUANTIDADE)';
      for Item in PedidoVenda.Itens do
      begin
        query.ParamByName('CODIGO_PEDIDO').AsString  := PedidoVenda.Codigo;
        query.ParamByName('CODIGO_PRODUTO').AsString := Item.Produto.Codigo;
        query.ParamByName('QUANTIDADE').AsInteger    := Item.Quantidade;
        query.ExecSQL;

        EstoqueDAO.AtualizaQuantidade(Item.Produto.Codigo, 'D', Item.Quantidade);
      end;

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TPedidoVendaDAO.Delete(CodigoPedidoVenda: string): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'SELECT * ITENS_PEDIDO_VENDA WHERE CODIGO_PEDIDO = :CODIGO_PEDIDO';
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.Open;
      query.First;
      while not(query.Eof) do
      begin
        EstoqueDAO.AtualizaQuantidade(query.FieldByName('CODIGO_PRODUTO').AsString, 'C', query.FieldByName('QUANTIDADE').AsInteger);
        query.Next;
      end;

      query.SQL.Text := 'DELETE FROM ITENS_PEDIDO_VENDA WHERE CODIGO_PEDIDO = :CODIGO_PEDIDO';
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.ExecSQL;

      query.SQL.Text := 'DELETE FROM PEDIDOS_VENDA WHERE CODIGO = :CODIGO';
      query.ParamByName('CODIGO').AsString  := CodigoPedidoVenda;
      query.ExecSQL;

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TPedidoVendaDAO.InsertItemNoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'INSERT INTO ITENS_PEDIDO_VENDA (CODIGO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE) '+
                        'VALUES (:CODIGO_PEDIDO, :CODIGO_PRODUTO, :QUANTIDADE)';
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.ParamByName('CODIGO_PRODUTO').AsString := Item.Produto.Codigo;
      query.ParamByName('QUANTIDADE').AsInteger    := Item.Quantidade;
      query.ExecSQL;

      EstoqueDAO.AtualizaQuantidade(Item.Produto.Codigo, 'D', Item.Quantidade);

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TPedidoVendaDAO.DeleteItemDoPedido(CodigoProduto, CodigoPedidoVenda: string): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'SELECT * FROM ITENS_PEDIDO_VENDA WHERE CODIGO_PEDIDO = :CODIGO_PEDIDO AND CODIGO_PRODUTO = :CODIGO_PRODUTO';
      query.Open;
      query.First;
      EstoqueDAO.AtualizaQuantidade(query.FieldByName('CODIGO_PRODUTO').AsString, 'C', query.FieldByName('QUANTIDADE').AsInteger);

      query.SQL.Text := 'DELETE FROM ITENS_PEDIDO_VENDA WHERE CODIGO_PEDIDO = :CODIGO_PEDIDO AND CODIGO_PRODUTO = :CODIGO_PRODUTO';
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.ParamByName('CODIGO_PRODUTO').AsString := CodigoProduto;
      query.ExecSQL;

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

end.
