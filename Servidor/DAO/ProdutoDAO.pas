unit ProdutoDAO;

interface

uses
  Classes, DBXCommon, SqlExpr, Produto, SysUtils, FornecedorProduto,
  Generics.Collections, Fornecedor, Validade;

type
  {$MethodInfo ON}
  TProdutoDAO = class(TPersistent)
  private
    FComm: TDBXCommand;

    procedure PrepareCommand;
  public
    function List: TDBXReader;
    function NextCodigo: string;
    function NextCodigoBarras: string;
    function Insert(produto: TProduto): Boolean;
    function Update(produto: TProduto): Boolean;
    function Delete(produto: TProduto): Boolean;
    function FindByCodigo(Codigo: string): TProduto;
    function ListFornecedoresByProduto(Codigo: string): TList<TFornecedorProduto>;
    function ListValidadesByProduto(Codigo: string): TList<TValidade>;
    function ListagemProdutos(CodigoTipoProduto, CodigoFornecedor: string; Estoque: Integer): TDBXReader;
    function ExisteCodigoBarras(CodigoBarras: string): Boolean;
    function ListProdutosPertoVencimento: TDBXReader;
  end;

implementation

uses uSCPrincipal, StringUtils, TipoProduto;

const
  TABELA: String = 'PRODUTOS';

{ TProdutoDAO }

procedure TProdutoDAO.PrepareCommand;
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

function TProdutoDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT P.CODIGO, P.DESCRICAO, P.CODIGO_TIPO_PRODUTO, T.DESCRICAO AS DESCRICAO_TIPO_PRODUTO, '+
                '       P.PRECO_VENDA, P.CODIGO_BARRAS, E.QUANTIDADE '+
                'FROM PRODUTOS P '+
                'INNER JOIN TIPOS_PRODUTO T ON T.CODIGO = P.CODIGO_TIPO_PRODUTO '+
                'LEFT JOIN ESTOQUE E ON E.CODIGO_PRODUTO = P.CODIGO';
  Result := FComm.ExecuteQuery;
end;

function TProdutoDAO.ListagemProdutos(CodigoTipoProduto, CodigoFornecedor: string; Estoque: Integer): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT P.CODIGO, P.CODIGO_TIPO_PRODUTO, P.DESCRICAO, P.CODIGO_BARRAS, P.PRECO_VENDA, '+
                       'T.DESCRICAO AS DESCRICAO_TIPO_PRODUTO, FP.PRECO_COMPRA, F.NOME AS NOME_FORNECEDOR '+
                'FROM PRODUTOS P '+
                'INNER JOIN TIPOS_PRODUTO T ON T.CODIGO = P.CODIGO_TIPO_PRODUTO '+
                'LEFT JOIN FORNECEDORES_PRODUTO FP ON FP.CODIGO_PRODUTO = P.CODIGO '+
                'LEFT JOIN FORNECEDORES F ON F.CODIGO = FP.CODIGO_FORNECEDOR '+
                'WHERE P.CODIGO IS NOT NULL ';

  if (CodigoTipoProduto <> '') then
    FComm.Text := FComm.Text + 'AND P.CODIGO_TIPO_PRODUTO = '''+CodigoTipoProduto+'''';

  if (CodigoFornecedor <> '') then
    FComm.Text := FComm.Text + 'AND FP.CODIGO_FORNECEDOR = '''+CodigoFornecedor+'''';

  case Estoque of
    1: FComm.Text := FComm.Text + 'AND (SELECT QUANTIDADE FROM ESTOQUE E WHERE E.CODIGO_PRODUTO = P.CODIGO) > 0';
    2: FComm.Text := FComm.Text + 'AND (SELECT QUANTIDADE FROM ESTOQUE E WHERE E.CODIGO_PRODUTO = P.CODIGO) = 0';
  end;

  Result := FComm.ExecuteQuery;
end;

function TProdutoDAO.ListFornecedoresByProduto(Codigo: string): TList<TFornecedorProduto>;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT P.*, F.NOME FROM FORNECEDORES_PRODUTO P '+
                      'INNER JOIN FORNECEDORES F ON F.CODIGO = P.CODIGO_FORNECEDOR '+
                      'WHERE P.CODIGO_PRODUTO = :CODIGO_PRODUTO';
    query.ParamByName('CODIGO_PRODUTO').AsString := Codigo;
    query.Open;
    query.First;
    Result := TList<TFornecedorProduto>.Create;
    while not(query.Eof) do
    begin
      Result.Add(TFornecedorProduto.Create(TFornecedor.Create(query.FieldByName('CODIGO_FORNECEDOR').AsString,
                                                              query.FieldByName('NOME').AsString,
                                                              ''),
                                           query.FieldByName('PRECO_COMPRA').AsCurrency));

      query.Next;
    end;
  finally
    query.Free;
  end;
end;

function TProdutoDAO.ListValidadesByProduto(Codigo: string): TList<TValidade>;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT * FROM VALIDADES '+
                      'WHERE CODIGO_PRODUTO = :CODIGO_PRODUTO';
    query.ParamByName('CODIGO_PRODUTO').AsString := Codigo;
    query.Open;
    query.First;
    Result := TList<TValidade>.Create;
    while not(query.Eof) do
    begin
      Result.Add(TValidade.Create(query.FieldByName('DATA').AsDateTime));

      query.Next;
    end;
  finally
    query.Free;
  end;
end;

function TProdutoDAO.NextCodigo: string;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT MAX(CODIGO) AS MAX_CODIGO FROM ' + TABELA;
    query.Open;
    if query.FieldByName('max_codigo').IsNull then
      Result := StrZero(1, 6)
    else
      Result := StrZero(query.FieldByName('max_codigo').AsInteger + 1, 6);
  finally
    query.Free;
  end;
end;

function TProdutoDAO.NextCodigoBarras: string;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT MAX(CODIGO) AS MAX_CODIGO FROM ' + TABELA;
    query.Open;
    if query.FieldByName('max_codigo').IsNull then
      Result := StrZero(1, 20)
    else
      Result := StrZero(query.FieldByName('max_codigo').AsInteger + 1, 20);
  finally
    query.Free;
  end;
end;

function TProdutoDAO.Insert(produto: TProduto): Boolean;
var
  query: TSQLQuery;
  Fornecedor: TFornecedorProduto;
  Validade: TValidade;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'INSERT INTO ' + TABELA +' (CODIGO, CODIGO_TIPO_PRODUTO, DESCRICAO, CODIGO_BARRAS, PRECO_VENDA) VALUES (:CODIGO, :CODIGO_TIPO_PRODUTO, :DESCRICAO, :CODIGO_BARRAS, :PRECO_VENDA)';
      query.ParamByName('CODIGO').AsString              := produto.Codigo;
      query.ParamByName('CODIGO_TIPO_PRODUTO').AsString := produto.TipoProduto.Codigo;
      query.ParamByName('DESCRICAO').AsString           := produto.Descricao;
      query.ParamByName('CODIGO_BARRAS').AsString       := produto.CodigoBarras;
      query.ParamByName('PRECO_VENDA').AsCurrency       := produto.PrecoVenda;
      query.ExecSQL;

      query.SQL.Text := 'INSERT INTO FORNECEDORES_PRODUTO (CODIGO_PRODUTO, CODIGO_FORNECEDOR, PRECO_COMPRA) '+
                        'VALUES (:CODIGO_PRODUTO, :CODIGO_FORNECEDOR, :PRECO_COMPRA)';
      for Fornecedor in produto.Fornecedores do
      begin
        query.ParamByName('CODIGO_PRODUTO').AsString    := produto.Codigo;
        query.ParamByName('CODIGO_FORNECEDOR').AsString := Fornecedor.Fornecedor.Codigo;
        query.ParamByName('PRECO_COMPRA').AsCurrency    := Fornecedor.PrecoCompra;

        query.ExecSQL;
      end;

      query.SQL.Text := 'INSERT INTO VALIDADES (CODIGO_PRODUTO, DATA) '+
                        'VALUES (:CODIGO_PRODUTO, :DATA)';
      for Validade in produto.Validades do
      begin
        query.ParamByName('CODIGO_PRODUTO').AsString := produto.Codigo;
        query.ParamByName('DATA').AsDateTime         := Validade.Data;

        query.ExecSQL;
      end;

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TProdutoDAO.Update(produto: TProduto): Boolean;
var
  query: TSQLQuery;
  Fornecedor: TFornecedorProduto;
  Validade: TValidade;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'UPDATE ' + TABELA + ' SET                    '+
                      ' CODIGO_TIPO_PRODUTO = :CODIGO_TIPO_PRODUTO, '+
                      ' DESCRICAO = :DESCRICAO,                     '+
                      ' CODIGO_BARRAS = :CODIGO_BARRAS,             '+
                      ' PRECO_VENDA = :PRECO_VENDA                  '+
                      'WHERE CODIGO = :CODIGO                       ';
    query.ParamByName('CODIGO_TIPO_PRODUTO').AsString := produto.TipoProduto.Codigo;
    query.ParamByName('DESCRICAO').AsString           := produto.Descricao;
    query.ParamByName('CODIGO_BARRAS').AsString       := produto.CodigoBarras;
    query.ParamByName('PRECO_VENDA').AsCurrency       := produto.PrecoVenda;
    query.ParamByName('CODIGO').AsString              := produto.Codigo;
    try
      query.ExecSQL;

      query.SQL.Text := 'DELETE FROM FORNECEDORES_PRODUTO WHERE CODIGO_PRODUTO = '''+produto.Codigo+'''';
      query.ExecSQL;

      query.SQL.Text := 'INSERT INTO FORNECEDORES_PRODUTO (CODIGO_PRODUTO, CODIGO_FORNECEDOR, PRECO_COMPRA) '+
                        'VALUES (:CODIGO_PRODUTO, :CODIGO_FORNECEDOR, :PRECO_COMPRA)';
      for Fornecedor in produto.Fornecedores do
      begin
        query.ParamByName('CODIGO_PRODUTO').AsString    := produto.Codigo;
        query.ParamByName('CODIGO_FORNECEDOR').AsString := Fornecedor.Fornecedor.Codigo;
        query.ParamByName('PRECO_COMPRA').AsCurrency    := Fornecedor.PrecoCompra;

        query.ExecSQL;
      end;
      
      query.SQL.Text := 'DELETE FROM VALIDADES WHERE CODIGO_PRODUTO = '''+produto.Codigo+'''';
      query.ExecSQL;

      query.SQL.Text := 'INSERT INTO VALIDADES (CODIGO_PRODUTO, DATA) '+
                        'VALUES (:CODIGO_PRODUTO, :DATA)';
      for Validade in produto.Validades do
      begin
        query.ParamByName('CODIGO_PRODUTO').AsString := produto.Codigo;
        query.ParamByName('DATA').AsDateTime         := Validade.Data;

        query.ExecSQL;
      end;

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TProdutoDAO.Delete(produto: TProduto): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    try
      query.SQLConnection := SCPrincipal.ConnTopCommerce;
      query.SQL.Text := 'DELETE FROM ESTOQUE WHERE CODIGO_PRODUTO = '''+produto.Codigo+'''';
      query.ExecSQL;

      query.SQL.Text := 'DELETE FROM FORNECEDORES_PRODUTO WHERE CODIGO_PRODUTO = '''+produto.Codigo+'''';
      query.ExecSQL;

      query.SQL.Text := 'DELETE FROM VALIDADES WHERE CODIGO_PRODUTO = '''+produto.Codigo+'''';
      query.ExecSQL;

      query.SQL.Text := 'DELETE FROM ' + TABELA + ' WHERE CODIGO = '''+produto.Codigo+'''';
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TProdutoDAO.FindByCodigo(Codigo: string): TProduto;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT P.*, T.DESCRICAO AS DESCRICAO_TIPO_PRODUTO FROM PRODUTOS P '+
                      'INNER JOIN TIPOS_PRODUTO T ON T.CODIGO = P.CODIGO_TIPO_PRODUTO '+
                      'WHERE P.CODIGO = ''' + Codigo + '''';
    query.Open;
    Result := TProduto.Create(query.FieldByName('CODIGO').AsString,
                              TTipoProduto.Create(query.FieldByName('CODIGO_TIPO_PRODUTO').AsString,
                                                  query.FieldByName('DESCRICAO_TIPO_PRODUTO').AsString),
                              query.FieldByName('DESCRICAO').AsString,
                              query.FieldByName('CODIGO_BARRAS').AsString,
                              query.FieldByName('PRECO_VENDA').AsCurrency,
                              nil,
                              nil);
  finally
    query.Free;
  end;
end;

function TProdutoDAO.ExisteCodigoBarras(CodigoBarras: string): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT COUNT(*) QTD FROM PRODUTOS WHERE CODIGO_BARRAS = :CODIGO_BARRAS';
    query.ParamByName('CODIGO_BARRAS').AsString := CodigoBarras;
    query.Open;
    Result := query.FieldByName('QTD').AsInteger > 0;
  finally
    query.Free;
  end;
end;

function TProdutoDAO.ListProdutosPertoVencimento: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT V.CODIGO_PRODUTO, P.DESCRICAO, V.DATA '+
                'FROM VALIDADES V '+
                'INNER JOIN PRODUTOS P ON P.CODIGO = V.CODIGO_PRODUTO '+
                'INNER JOIN ESTOQUE E ON E.CODIGO_PRODUTO = V.CODIGO_PRODUTO '+
                                    'AND E.QUANTIDADE > 0 '+
                'WHERE DATEDIFF(DAY,GETDATE(),DATA) >= 0 AND '+
                      'DATEDIFF(MONTH,GETDATE(),DATA) <= 5';
  Result := FComm.ExecuteQuery;
end;

end.
