unit ClienteDAO;

interface

uses
  DBXCommon, SqlExpr, BaseDAO, Cliente;

type
  TClienteDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function NextCodigo: string;
    function Insert(Cliente: TCliente): Boolean;
    function Update(Cliente: TCliente): Boolean;
    function Delete(Cliente: TCliente): Boolean;
    function FindByCodigo(Codigo: string): TCliente;
  end;


implementation

uses uSCPrincipal, StringUtils;

{ TClienteDAO }

function TClienteDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT * FROM CLIENTES';
  Result := FComm.ExecuteQuery;
end;

function TClienteDAO.NextCodigo: string;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'SELECT MAX(CODIGO) AS MAX_CODIGO FROM CLIENTES';
    query.Open;
    //
    if query.FieldByName('MAX_CODIGO').IsNull then
      Result := StrZero(1, 6)
    else
      Result := StrZero(query.FieldByName('MAX_CODIGO').AsInteger + 1, 6);
  finally
    query.Free;
  end;
end;

function TClienteDAO.Insert(Cliente: TCliente): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO CLIENTES (CODIGO, NOME, TELEFONE) VALUES (:CODIGO, :NOME, :TELEFONE)';
    //
    query.ParamByName('CODIGO').AsString   := Cliente.Codigo;
    query.ParamByName('NOME').AsString     := Cliente.Nome;
    query.ParamByName('TELEFONE').AsString := Cliente.Telefone;
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

function TClienteDAO.Update(Cliente: TCliente): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE CLIENTES SET NOME = :NOME, TELEFONE = :TELEFONE '+
                      'WHERE CODIGO = :CODIGO';
    //
    query.ParamByName('NOME').AsString     := Cliente.Nome;
    query.ParamByName('CODIGO').AsString   := Cliente.Codigo;
    query.ParamByName('TELEFONE').AsString := Cliente.Telefone;
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

function TClienteDAO.Delete(Cliente: TCliente): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'DELETE FROM CLIENTES WHERE CODIGO = :CODIGO';
    //
    query.ParamByName('CODIGO').AsString := Cliente.Codigo;
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

function TClienteDAO.FindByCodigo(Codigo: string): TCliente;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'SELECT * FROM CLIENTES WHERE CODIGO = ''' + Codigo + '''';
    query.Open;
    //
    Result := TCliente.Create(query.FieldByName('CODIGO').AsString,
                              query.FieldByName('NOME').AsString,
                              query.FieldByName('TELEFONE').AsString);
  finally
    query.Free;
  end;
end;

end.
