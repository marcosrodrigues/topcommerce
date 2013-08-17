unit EstoqueDAO;

interface

uses
  DBXCommon, SqlExpr, Estoque, SysUtils, BaseDAO;

type
  TEstoqueDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function Insert(Estoque: TEstoque): Boolean;
    function Update(Estoque: TEstoque): Boolean;
    function Delete(Estoque: TEstoque): Boolean;
    function AtualizaQuantidade(CodigoProduto: string; Operacao: Char; Quantidade: Integer): Boolean;
    function RelatorioEstoque(Estoque: Integer): TDBXReader;
  end;

implementation

uses uSCPrincipal, StringUtils;

{ TEstoqueDAO }

function TEstoqueDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT E.CODIGO_PRODUTO, P.DESCRICAO AS DESCRICAO_PRODUTO, E.QUANTIDADE '+
                'FROM ESTOQUE E '+
                'INNER JOIN PRODUTOS P ON P.CODIGO = E.CODIGO_PRODUTO';
  Result := FComm.ExecuteQuery;
end;

function TEstoqueDAO.Insert(Estoque: TEstoque): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO ESTOQUE (CODIGO_PRODUTO, QUANTIDADE) VALUES (:CODIGO_PRODUTO, :QUANTIDADE)';
    //
    query.ParamByName('CODIGO_PRODUTO').AsString := Estoque.Produto.Codigo;
    query.ParamByName('QUANTIDADE').AsInteger    := Estoque.Quantidade;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TEstoqueDAO.Update(Estoque: TEstoque): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE ESTOQUE SET QUANTIDADE = :QUANTIDADE '+
                      'WHERE CODIGO_PRODUTO = :CODIGO_PRODUTO';
    //
    query.ParamByName('QUANTIDADE').AsInteger    := Estoque.Quantidade;
    query.ParamByName('CODIGO_PRODUTO').AsString := Estoque.Produto.Codigo;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TEstoqueDAO.Delete(Estoque: TEstoque): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'DELETE FROM ESTOQUE WHERE CODIGO_PRODUTO = :CODIGO_PRODUTO';
    //
    query.ParamByName('CODIGO_PRODUTO').AsString := Estoque.Produto.Codigo;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TEstoqueDAO.AtualizaQuantidade(CodigoProduto: string; Operacao: Char; Quantidade: Integer): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    if (Operacao = 'D') then
      Quantidade := Quantidade * -1;
    //
    query.SQL.Text := 'UPDATE ESTOQUE SET QUANTIDADE = QUANTIDADE + :QUANTIDADE '+
                      'WHERE CODIGO_PRODUTO = :CODIGO_PRODUTO';
    //
    query.ParamByName('QUANTIDADE').AsInteger    := Quantidade;
    query.ParamByName('CODIGO_PRODUTO').AsString := CodigoProduto;
    //
    try
      query.ExecSQL;
      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TEstoqueDAO.RelatorioEstoque(Estoque: Integer): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT E.CODIGO_PRODUTO, P.DESCRICAO AS DESCRICAO_PRODUTO, E.QUANTIDADE, '+
                      '(SELECT TOP 1 F.PRECO_COMPRA FROM FORNECEDORES_PRODUTO F '+
                       'WHERE F.CODIGO_PRODUTO = P.CODIGO) PRECO_COMPRA '+
                'FROM ESTOQUE E '+
                'INNER JOIN PRODUTOS P ON P.CODIGO = E.CODIGO_PRODUTO '+
                'WHERE E.CODIGO_PRODUTO IS NOT NULL ';

  case Estoque of
    1: FComm.Text := FComm.Text + 'AND E.QUANTIDADE > 0';
    2: FComm.Text := FComm.Text + 'AND E.QUANTIDADE = 0';
  end;

  Result := FComm.ExecuteQuery;
end;

end.
