unit CargoDAO;

interface

uses
  DBXCommon, SqlExpr, BaseDAO, Cargo;

type
  TCargoDAO = class(TBaseDAO)
  public
    function List: TDBXReader;
    function Insert(Cargo: TCargo): Boolean;
    function Update(Cargo: TCargo): Boolean;
    function Delete(Cargo: TCargo): Boolean;
    function FindById(Id: Integer): TCargo;
  end;


implementation

uses uSCPrincipal, StringUtils;

{ TClienteDAO }

function TCargoDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT * FROM CARGOS';
  Result := FComm.ExecuteQuery;
end;

function TCargoDAO.Insert(Cargo: TCargo): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'INSERT INTO CARGOS (DESCRICAO) VALUES (:DESCRICAO)';
    //
    query.ParamByName('DESCRICAO').AsString := Cargo.Descricao;
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

function TCargoDAO.Update(Cargo: TCargo): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'UPDATE CARGOS SET DESCRICAO = :DESCRICAO '+
                      'WHERE ID = :ID';
    //
    query.ParamByName('DESCRICAO').AsString := Cargo.Descricao;
    query.ParamByName('ID').AsInteger       := Cargo.Id;
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

function TCargoDAO.Delete(Cargo: TCargo): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'DELETE FROM CARGOS WHERE ID = :ID';
    //
    query.ParamByName('ID').AsInteger := Cargo.Id;
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

function TCargoDAO.FindById(Id: Integer): TCargo;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    //
    query.SQL.Text := 'SELECT * FROM CARGOS WHERE ID = :ID';
    //
    query.ParamByName('ID').AsInteger := Id;
    //
    query.Open;
    //
    Result := TCargo.Create(query.FieldByName('ID').AsInteger,
                            query.FieldByName('DESCRICAO').AsString);
  finally
    query.Free;
  end;
end;

end.
