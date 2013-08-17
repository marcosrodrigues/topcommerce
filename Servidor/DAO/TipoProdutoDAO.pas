unit TipoProdutoDAO;

interface

uses
  Classes, DBXCommon, SqlExpr, TipoProduto;

type
  {$MethodInfo ON}
  TTipoProdutoDAO = class(TPersistent)
  private
    FComm: TDBXCommand;

    procedure PrepareCommand;
  public
    function List: TDBXReader;
    function NextCodigo: string;
    function Insert(tipoProduto: TTipoProduto): Boolean;
    function Update(tipoProduto: TTipoProduto): Boolean;
    function Delete(tipoProduto: TTipoProduto): Boolean;
    function FindByCodigo(Codigo: string): TTipoProduto;
  end;

implementation

uses uSCPrincipal, StringUtils;

const
  TABELA: String = 'TIPOS_PRODUTO';

{ TTipoProdutoDAO }

procedure TTipoProdutoDAO.PrepareCommand;
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

function TTipoProdutoDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT * FROM ' + TABELA;
  Result := FComm.ExecuteQuery;
end;

function TTipoProdutoDAO.NextCodigo: string;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT MAX(CODIGO) AS MAX_CODIGO FROM ' + TABELA;
    query.Open;
    if query.FieldByName('max_codigo').IsNull then
      Result := StrZero(1, 3)
    else
      Result := StrZero(query.FieldByName('max_codigo').AsInteger + 1, 3);
  finally
    query.Free;
  end;
end;

function TTipoProdutoDAO.FindByCodigo(Codigo: string): TTipoProduto;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT * FROM ' + TABELA + ' WHERE CODIGO = ''' + Codigo + '''';
    query.Open;
    Result := TTipoProduto.Create(query.FieldByName('CODIGO').AsString,
                                  query.FieldByName('DESCRICAO').AsString);
  finally
    query.Free;
  end;
end;

function TTipoProdutoDAO.Insert(tipoProduto: TTipoProduto): Boolean;
begin
  PrepareCommand;
  FComm.Text := 'INSERT INTO ' + TABELA +' (CODIGO, DESCRICAO) VALUES ('''+tipoProduto.Codigo+''','''+tipoProduto.Descricao+''')';
  try
    FComm.ExecuteUpdate;
    Result := True;
  except
    Result := False;
  end;
end;

function TTipoProdutoDAO.Update(tipoProduto: TTipoProduto): Boolean;
begin
  PrepareCommand;
  FComm.Text := 'UPDATE ' + TABELA + ' SET DESCRICAO = '''+tipoProduto.Descricao+''''+
                ' WHERE CODIGO = '''+tipoProduto.Codigo+'''';
  try
    FComm.ExecuteUpdate;
    Result := True;
  except
    Result := False;
  end;
end;

function TTipoProdutoDAO.Delete(tipoProduto: TTipoProduto): Boolean;
begin
  PrepareCommand;
  FComm.Text := 'DELETE FROM ' + TABELA + ' WHERE CODIGO = '''+tipoProduto.Codigo+'''';
  try
    FComm.ExecuteUpdate;
    Result := True;
  except
    Result := False;
  end;
end;

end.
