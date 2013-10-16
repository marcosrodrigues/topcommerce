unit uCargoDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Generics.Collections, DBXJSONReflect, Cargo;

type
  TCargoDAOClient = class(TDSAdminClient)
  private
    FListCommand: TDBXCommand;
    FInsertCommand: TDBXCommand;
    FUpdateCommand: TDBXCommand;
    FDeleteCommand: TDBXCommand;
    FFindByIdCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function List: TDBXReader;
    function Insert(Cargo: TCargo): Boolean;
    function Update(Cargo: TCargo): Boolean;
    function Delete(Cargo: TCargo): Boolean;
    function FindById(Id: Integer): TCargo;
  end;

implementation

function TCargoDAOClient.List: TDBXReader;
begin
  if FListCommand = nil then
  begin
    FListCommand := FDBXConnection.CreateCommand;
    FListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListCommand.Text := 'TCargoDAO.List';
    FListCommand.Prepare;
  end;
  FListCommand.ExecuteUpdate;
  Result := FListCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TCargoDAOClient.Insert(Cargo: TCargo): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TCargoDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(Cargo) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Cargo), True);
      if FInstanceOwner then
        Cargo.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TCargoDAOClient.Update(Cargo: TCargo): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TCargoDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(Cargo) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Cargo), True);
      if FInstanceOwner then
        Cargo.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[1].Value.GetBoolean;
end;

function TCargoDAOClient.Delete(Cargo: TCargo): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TCargoDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  if not Assigned(Cargo) then
    FDeleteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDeleteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDeleteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Cargo), True);
      if FInstanceOwner then
        Cargo.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

function TCargoDAOClient.FindById(Id: Integer): TCargo;
begin
  if FFindByIdCommand = nil then
  begin
    FFindByIdCommand := FDBXConnection.CreateCommand;
    FFindByIdCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFindByIdCommand.Text := 'TCargoDAO.FindById';
    FFindByIdCommand.Prepare;
  end;
  FFindByIdCommand.Parameters[0].Value.SetInt32(Id);
  FFindByIdCommand.ExecuteUpdate;
  if not FFindByIdCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FFindByIdCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TCargo(FUnMarshal.UnMarshal(FFindByIdCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FFindByIdCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;


constructor TCargoDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TCargoDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TCargoDAOClient.Destroy;
begin
  FreeAndNil(FListCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FFindByIdCommand);
  inherited;
end;

end.

