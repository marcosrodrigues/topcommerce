unit PedidoVendaDAO;

interface

uses
  Classes, DBXCommon, PedidoVenda, ItemPedidoVenda, SqlExpr, SysUtils,
  EstoqueDAO, ClienteDAO, ProdutoDAO, Generics.Collections;

type
  {$MethodInfo ON}
  TPedidoVendaDAO = class(TPersistent)
  private
    FComm: TDBXCommand;
    EstoqueDAO: TEstoqueDAO;
    ClienteDAO: TClienteDAO;
    ProdutoDAO: TProdutoDAO;

    procedure PrepareCommand;
  public
    function NextCodigo: string;
    function Insert(PedidoVenda: TPedidoVenda): Boolean;
    function Delete(CodigoPedidoVenda: string): Boolean;
    function Update(PedidoVenda: TPedidoVenda): Boolean;
    function InsertItemNoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
    function DeleteItemDoPedido(CodigoProduto, CodigoPedidoVenda: string): Boolean;
    function AtualizaItemDoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
    function RelatorioPedidosVenda(DataInicial, DataFinal: TDateTime; TipoPagamento: Integer; ClienteCodigo: string): TDBXReader;
    function VendasFechadas: TDBXReader;
    function VendasAbertas: TDBXReader;
    function Recibo(CodigoPedidoVenda: string): TDBXReader;
    function FindByCodigo(Codigo: string): TPedidoVenda;
    function CancelarVenda(CodigoPedidoVenda: string): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses uSCPrincipal, StringUtils, CaixaDAO;

{ TPedidoVendaDAO }

function TPedidoVendaDAO.AtualizaItemDoPedido(CodigoPedidoVenda: string; Item: TItemPedidoVenda): Boolean;
var
  query: TSQLQuery;
  QuantidadeAnterior: Integer;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'SELECT QUANTIDADE FROM ITENS_PEDIDO_VENDA WHERE CODIGO_PEDIDO = :CODIGO_PEDIDO AND CODIGO_PRODUTO = :CODIGO_PRODUTO';
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.ParamByName('CODIGO_PRODUTO').AsString := Item.Produto.Codigo;
      query.Open;
      QuantidadeAnterior := query.FieldByName('QUANTIDADE').AsInteger;

      query.Close;
      query.SQL.Text := 'UPDATE ITENS_PEDIDO_VENDA SET QUANTIDADE = :QUANTIDADE '+
                        'WHERE CODIGO_PEDIDO = :CODIGO_PEDIDO AND CODIGO_PRODUTO = :CODIGO_PRODUTO';
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.ParamByName('CODIGO_PRODUTO').AsString := Item.Produto.Codigo;
      query.ParamByName('QUANTIDADE').AsInteger    := Item.Quantidade;
      query.ExecSQL;

      if QuantidadeAnterior > Item.Quantidade then
        EstoqueDAO.AtualizaQuantidade(Item.Produto.Codigo, 'C', QuantidadeAnterior - Item.Quantidade)
      else if QuantidadeAnterior < Item.Quantidade then
        EstoqueDAO.AtualizaQuantidade(Item.Produto.Codigo, 'D', Item.Quantidade - QuantidadeAnterior);

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TPedidoVendaDAO.CancelarVenda(CodigoPedidoVenda: string): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'SELECT * FROM ITENS_PEDIDO_VENDA WHERE CODIGO_PEDIDO = :CODIGO_PEDIDO';
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.Open;
      while not query.Eof do
      begin
        EstoqueDAO.AtualizaQuantidade(query.FieldByName('CODIGO_PRODUTO').AsString, 'C', query.FieldByName('QUANTIDADE').AsInteger);
        query.Next;
      end;

      query.SQL.Text := 'UPDATE PEDIDOS_VENDA SET CANCELADA = 1 WHERE CODIGO = :CODIGO';
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

constructor TPedidoVendaDAO.Create;
begin
  EstoqueDAO := TEstoqueDAO.Create;
  ClienteDAO := TClienteDAO.Create;
  ProdutoDAO := TProdutoDAO.Create;
end;

destructor TPedidoVendaDAO.Destroy;
begin
  ProdutoDAO.Free;
  ClienteDAO.Free;
  EstoqueDAO.Free;
  inherited;
end;

function TPedidoVendaDAO.FindByCodigo(Codigo: string): TPedidoVenda;
var
  query: TSQLQuery;
  pedido: TPedidoVenda;
  item: TItemPedidoVenda;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT * FROM PEDIDOS_VENDA '+
                      'WHERE CODIGO = ''' + Codigo + '''';
    query.Open;

    pedido := TPedidoVenda.Create;
    pedido.Codigo   := query.FieldByName('CODIGO').AsString;
    pedido.Data     := query.FieldByName('DATA').AsDateTime;
    pedido.Desconto := query.FieldByName('DESCONTO').AsCurrency;
    pedido.DescontoPercentual := query.FieldByName('DESCONTO_PERCENTUAL').AsCurrency;
    pedido.TipoPagamento := query.FieldByName('TIPO_PAGAMENTO').AsInteger;

    if not query.FieldByName('CODIGO_CLIENTE').IsNull then
      pedido.Cliente := ClienteDAO.FindByCodigo(query.FieldByName('CODIGO_CLIENTE').AsString);

    pedido.NomeClienteAvulso := query.FieldByName('NOME_CLIENTE_AVULSO').AsString;
    pedido.Fechada := query.FieldByName('FECHADA').AsBoolean;
    pedido.Total := query.FieldByName('TOTAL').AsCurrency;
    pedido.Recebido := query.FieldByName('RECEBIDO').AsCurrency;
    pedido.Troco := query.FieldByName('TROCO').AsCurrency;
    pedido.Cancelada := query.FieldByName('CANCELADA').AsBoolean;

    query.Close;
    query.SQL.Text := 'SELECT * FROM ITENS_PEDIDO_VENDA WHERE CODIGO_PEDIDO = ''' + Codigo + '''';
    query.Open;

    pedido.Itens := TList<TItemPedidoVenda>.Create;
    while not query.Eof do
    begin
      item := TItemPedidoVenda.Create;
      item.Produto := ProdutoDAO.FindByCodigo(query.FieldByName('CODIGO_PRODUTO').AsString);
      item.Quantidade := query.FieldByName('QUANTIDADE').AsInteger;
      item.DescontoValor := query.FieldByName('DESCONTO_VALOR').AsCurrency;
      item.DescontoPercentual := query.FieldByName('DESCONTO_PERCENTUAL').AsCurrency;
      item.Valor := query.FieldByName('VALOR').AsCurrency;

      pedido.Itens.Add(item);

      query.Next;
    end;

    Result := pedido;
  finally
    query.Free;
  end;
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

function TPedidoVendaDAO.Recibo(CodigoPedidoVenda: string): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT V.CODIGO, V.DATA, V.DESCONTO, V.TIPO_PAGAMENTO, V.CODIGO_CLIENTE, '+
                       'V.NOME_CLIENTE_AVULSO, I.CODIGO_PRODUTO, I.QUANTIDADE, P.DESCRICAO, I.VALOR, C.NOME, '+
                       'V.DESCONTO_PERCENTUAL AS VENDA_DESCONTO_PERCENTUAL, V.TOTAL, V.RECEBIDO, V.TROCO, V.LOGIN_USUARIO, I.DESCONTO_VALOR AS ITEM_DESCONTO_VALOR, '+
                       'I.DESCONTO_PERCENTUAL AS ITEM_DESCONTO_PERCENTUAL, P.PRECO_VENDA '+
                'FROM ITENS_PEDIDO_VENDA I '+
                'INNER JOIN PRODUTOS P ON P.CODIGO = I.CODIGO_PRODUTO '+
                'INNER JOIN PEDIDOS_VENDA V ON V.CODIGO = I.CODIGO_PEDIDO '+
                'LEFT JOIN CLIENTES C ON C.CODIGO = V.CODIGO_CLIENTE '+
                'WHERE V.CODIGO = '''+CodigoPedidoVenda+'''';
  Result := FComm.ExecuteQuery;
end;

function TPedidoVendaDAO.RelatorioPedidosVenda(DataInicial, DataFinal: TDateTime; TipoPagamento: Integer; ClienteCodigo: string): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT V.CODIGO, V.DATA, V.DESCONTO, V.TIPO_PAGAMENTO, V.CODIGO_CLIENTE, '+
                       'V.NOME_CLIENTE_AVULSO, I.CODIGO_PRODUTO, I.QUANTIDADE, P.DESCRICAO, I.VALOR, C.NOME, '+
                       'V.DESCONTO_PERCENTUAL AS VENDA_DESCONTO_PERCENTUAL, V.TOTAL, V.RECEBIDO, V.TROCO, V.LOGIN_USUARIO, I.DESCONTO_VALOR AS ITEM_DESCONTO_VALOR, '+
                       'I.DESCONTO_PERCENTUAL AS ITEM_DESCONTO_PERCENTUAL, P.PRECO_VENDA '+
                'FROM PEDIDOS_VENDA V '+
                'INNER JOIN ITENS_PEDIDO_VENDA I ON I.CODIGO_PEDIDO = V.CODIGO '+
                'INNER JOIN PRODUTOS P ON P.CODIGO = I.CODIGO_PRODUTO '+
                'LEFT JOIN CLIENTES C ON C.CODIGO = V.CODIGO_CLIENTE '+
                'WHERE P.CODIGO <> '''' AND V.CANCELADA = 0 ';
  if (DataInicial <> 0) then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), DATA, 112) >= '+FormatDateTime('yyyymmdd', DataInicial)+' ';
  if (DataFinal <> 0) then
    FComm.Text := FComm.Text + 'AND CONVERT(CHAR(8), DATA, 112) <= '+FormatDateTime('yyyymmdd', DataFinal)+' ';
  if (TipoPagamento > 0) then
    FComm.Text := FComm.Text + 'AND TIPO_PAGAMENTO = '+IntToStr(TipoPagamento-1); //TODO - Melhorar esse codigo
  if (Trim(ClienteCodigo) <> '') then
    FComm.Text := FComm.Text + 'AND CODIGO_CLIENTE = '''+ClienteCodigo+'''';
  Result := FComm.ExecuteQuery;
end;

function TPedidoVendaDAO.Update(PedidoVenda: TPedidoVenda): Boolean;
var
  query: TSQLQuery;
  CaixaDao: TCaixaDAO;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'UPDATE PEDIDOS_VENDA SET DESCONTO = :DESCONTO, TIPO_PAGAMENTO = :TIPO_PAGAMENTO, FECHADA = :FECHADA, DESCONTO_PERCENTUAL = :DESCONTO_PERCENTUAL, TOTAL = :TOTAL, CANCELADA = :CANCELADA, RECEBIDO = :RECEBIDO, TROCO = :TROCO WHERE CODIGO = :CODIGO';

      query.ParamByName('CODIGO').AsString          := PedidoVenda.Codigo;
      query.ParamByName('DESCONTO').AsCurrency      := PedidoVenda.Desconto;
      query.ParamByName('TIPO_PAGAMENTO').AsInteger := PedidoVenda.TipoPagamento;
      query.ParamByName('FECHADA').AsBoolean        := PedidoVenda.Fechada;
      query.ParamByName('DESCONTO_PERCENTUAL').AsCurrency := PedidoVenda.DescontoPercentual;
      query.ParamByName('TOTAL').AsCurrency := PedidoVenda.Total;
      query.ParamByName('CANCELADA').AsBoolean := PedidoVenda.Cancelada;
      query.ParamByName('RECEBIDO').AsCurrency := PedidoVenda.Recebido;
      query.ParamByName('TROCO').AsCurrency := PedidoVenda.Troco;

      query.ExecSQL;

      if PedidoVenda.Fechada then
      begin
        CaixaDao := TCaixaDAO.Create;
        try
          CaixaDao.RegistrarMovimentacao(1, PedidoVenda.Total, 1);
        finally
          CaixaDao.Free;
        end;
      end;

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TPedidoVendaDAO.VendasAbertas: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT V.CODIGO, V.DATA, C.NOME, V.NOME_CLIENTE_AVULSO, V.TOTAL '+
                'FROM PEDIDOS_VENDA V '+
                'LEFT JOIN CLIENTES C ON C.CODIGO = V.CODIGO_CLIENTE '+
                'WHERE V.FECHADA = 0 AND V.CANCELADA = 0 '+
                'ORDER BY V.DATA DESC';
  Result := FComm.ExecuteQuery;
end;

function TPedidoVendaDAO.VendasFechadas: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT V.CODIGO, V.DATA, C.NOME, V.NOME_CLIENTE_AVULSO, V.TOTAL '+
                'FROM PEDIDOS_VENDA V '+
                'LEFT JOIN CLIENTES C ON C.CODIGO = V.CODIGO_CLIENTE '+
                'WHERE V.FECHADA = 1 AND V.CANCELADA = 0 '+
                'ORDER BY V.DATA DESC';
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
      query.SQL.Text := 'INSERT INTO PEDIDOS_VENDA (CODIGO, DATA, DESCONTO, TIPO_PAGAMENTO, FECHADA, DESCONTO_PERCENTUAL, TOTAL, CANCELADA, LOGIN_USUARIO';

      if PedidoVenda.Cliente <> nil then
        query.SQL.Text := query.SQL.Text + ', CODIGO_CLIENTE, NOME_CLIENTE_AVULSO) VALUES (:CODIGO, :DATA, :DESCONTO, :TIPO_PAGAMENTO, :FECHADA, :DESCONTO_PERCENTUAL, :TOTAL, :CANCELADA, :LOGIN_USUARIO, :CODIGO_CLIENTE, :NOME_CLIENTE_AVULSO)'
      else
        query.SQL.Text := query.SQL.Text + ', NOME_CLIENTE_AVULSO) VALUES (:CODIGO, :DATA, :DESCONTO, :TIPO_PAGAMENTO, :FECHADA, :DESCONTO_PERCENTUAL, :TOTAL, :CANCELADA, :LOGIN_USUARIO, :NOME_CLIENTE_AVULSO)';

      query.ParamByName('CODIGO').AsString          := PedidoVenda.Codigo;
      query.ParamByName('DATA').AsDateTime          := PedidoVenda.Data;
      query.ParamByName('DESCONTO').AsCurrency      := PedidoVenda.Desconto;
      query.ParamByName('TIPO_PAGAMENTO').AsInteger := PedidoVenda.TipoPagamento;
      query.ParamByName('FECHADA').AsBoolean        := PedidoVenda.Fechada;
      query.ParamByName('DESCONTO_PERCENTUAL').AsCurrency := PedidoVenda.DescontoPercentual;
      query.ParamByName('TOTAL').AsCurrency := PedidoVenda.Total;
      query.ParamByName('CANCELADA').AsBoolean := PedidoVenda.Cancelada;
      query.ParamByName('LOGIN_USUARIO').AsString := PedidoVenda.LoginUsuario;

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
      query.SQL.Text := 'INSERT INTO ITENS_PEDIDO_VENDA (CODIGO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, DESCONTO_VALOR, DESCONTO_PERCENTUAL, VALOR) '+
                        'VALUES (:CODIGO_PEDIDO, :CODIGO_PRODUTO, :QUANTIDADE, :DESCONTO_VALOR, :DESCONTO_PERCENTUAL, :VALOR)';
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.ParamByName('CODIGO_PRODUTO').AsString := Item.Produto.Codigo;
      query.ParamByName('QUANTIDADE').AsInteger    := Item.Quantidade;
      query.ParamByName('DESCONTO_VALOR').AsCurrency := Item.DescontoValor;
      query.ParamByName('DESCONTO_PERCENTUAl').AsCurrency := Item.DescontoPercentual;
      query.ParamByName('VALOR').AsCurrency := Item.Valor;
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
      query.ParamByName('CODIGO_PEDIDO').AsString  := CodigoPedidoVenda;
      query.ParamByName('CODIGO_PRODUTO').AsString := CodigoProduto;
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
