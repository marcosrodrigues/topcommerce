unit FuncionarioDAO;

interface

uses
  DBXCommon, SqlExpr, BaseDAO, Funcionario, Cargo;

type
  TFuncionarioDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function NextCodigo: string;
    function Insert(Funcionario: TFuncionario): Boolean;
    function Update(Funcionario: TFuncionario): Boolean;
    function Delete(Funcionario: TFuncionario): Boolean;
    function FindByCodigo(Codigo: string): TFuncionario;
  end;


implementation

uses uSCPrincipal, StringUtils;

{ TFuncionarioDAO }

function TFuncionarioDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT F.CODIGO, F.NOME, F.CARGO_ID, C.DESCRICAO AS CARGO_DESCRICAO '+
                'FROM FUNCIONARIOS F '+
                'INNER JOIN CARGOS C ON C.ID = F.CARGO_ID';
  Result := FComm.ExecuteQuery;
end;

function TFuncionarioDAO.NextCodigo: string;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'SELECT MAX(CODIGO) AS MAX_CODIGO FROM FUNCIONARIOS';
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

function TFuncionarioDAO.Insert(Funcionario: TFuncionario): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO FUNCIONARIOS (CODIGO, NOME, CARGO_ID) VALUES (:CODIGO, :NOME, :CARGO_ID)';
    //
    query.ParamByName('CODIGO').AsString    := Funcionario.Codigo;
    query.ParamByName('NOME').AsString      := Funcionario.Nome;
    query.ParamByName('CARGO_ID').AsInteger := Funcionario.Cargo.Id;
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

function TFuncionarioDAO.Update(Funcionario: TFuncionario): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE FUNCIONARIOS SET NOME = :NOME, CARGO_ID = :CARGO_ID '+
                      'WHERE CODIGO = :CODIGO';
    //
    query.ParamByName('NOME').AsString      := Funcionario.Nome;
    query.ParamByName('CODIGO').AsString    := Funcionario.Codigo;
    query.ParamByName('CARGO_ID').AsInteger := Funcionario.Cargo.Id;
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

function TFuncionarioDAO.Delete(Funcionario: TFuncionario): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'DELETE FROM FUNCIONARIOS WHERE CODIGO = :CODIGO';
    //
    query.ParamByName('CODIGO').AsString := Funcionario.Codigo;
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

function TFuncionarioDAO.FindByCodigo(Codigo: string): TFuncionario;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'SELECT F.*, C.* '+
                      'FROM FUNCIONARIOS F '+
                      'INNER JOIN CARGOS C ON C.ID = F.CARGO_ID '+
                      'WHERE CODIGO = ''' + Codigo + '''';
    query.Open;
    //
    Result := TFuncionario.Create(query.FieldByName('CODIGO').AsString,
                                  query.FieldByName('NOME').AsString,
                                  TCargo.Create(query.FieldByName('CARGO_ID').AsInteger, query.FieldByName('DESCRICAO').AsString));
  finally
    query.Free;
  end;
end;

end.
