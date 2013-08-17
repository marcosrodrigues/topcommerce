unit FornecedorDAO;

interface

uses
  DBXCommon, SqlExpr, Fornecedor, BaseDAO;

type
  TFornecedorDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function NextCodigo: string;
    function Insert(Fornecedor: TFornecedor): Boolean;
    function Update(Fornecedor: TFornecedor): Boolean;
    function Delete(Fornecedor: TFornecedor): Boolean;
    function FindByCodigo(Codigo: string): TFornecedor;
    function ListagemFornecedores(CodigoProduto: string): TDBXReader;
  end;

implementation

uses uSCPrincipal, StringUtils;

{ TFornecedorDAO }

function TFornecedorDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT * FROM FORNECEDORES';
  Result := FComm.ExecuteQuery;
end;

function TFornecedorDAO.NextCodigo: string;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT MAX(CODIGO) AS MAX_CODIGO FROM FORNECEDORES';
    query.Open;
    if query.FieldByName('max_codigo').IsNull then
      Result := StrZero(1, 3)
    else
      Result := StrZero(query.FieldByName('max_codigo').AsInteger + 1, 3);
  finally
    query.Free;
  end;
end;

function TFornecedorDAO.Insert(Fornecedor: TFornecedor): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO FORNECEDORES (CODIGO, NOME, TELEFONE) VALUES (:CODIGO, :NOME, :TELEFONE)';
    //
    query.ParamByName('CODIGO').AsString   := Fornecedor.Codigo;
    query.ParamByName('NOME').AsString     := Fornecedor.Nome;
    query.ParamByName('TELEFONE').AsString := Fornecedor.Telefone;
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

function TFornecedorDAO.Update(Fornecedor: TFornecedor): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE FORNECEDORES SET NOME = :NOME, TELEFONE = :TELEFONE '+
                      'WHERE CODIGO = :CODIGO';
    //
    query.ParamByName('NOME').AsString     := Fornecedor.Nome;
    query.ParamByName('TELEFONE').AsString := Fornecedor.Telefone;
    query.ParamByName('CODIGO').AsString   := Fornecedor.Codigo;
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

function TFornecedorDAO.Delete(Fornecedor: TFornecedor): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    FComm.Text := 'DELETE FROM FORNECEDORES WHERE CODIGO = :CODIGO';
    //
    query.ParamByName('CODIGO').AsString   := Fornecedor.Codigo;
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

function TFornecedorDAO.FindByCodigo(Codigo: string): TFornecedor;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'SELECT * FROM FORNECEDORES WHERE CODIGO = ''' + Codigo + '''';
    query.Open;
    //
    Result := TFornecedor.Create(query.FieldByName('CODIGO').AsString,
                                 query.FieldByName('NOME').AsString,
                                 query.FieldByName('TELEFONE').AsString);
  finally
    query.Free;
  end;
end;

function TFornecedorDAO.ListagemFornecedores(CodigoProduto: string): TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT F.* FROM FORNECEDORES F '+
                'WHERE F.CODIGO IS NOT NULL ';

  if (CodigoProduto <> '') then
    FComm.Text := FComm.Text + 'AND F.CODIGO IN (SELECT CODIGO_FORNECEDOR '+
                                                'FROM FORNECEDORES_PRODUTO P '+
                                                'WHERE P.CODIGO_PRODUTO = '''+CodigoProduto+''')';

  Result := FComm.ExecuteQuery;
end;

end.
