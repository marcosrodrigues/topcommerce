unit uContaReceberDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Generics.Collections, DBXJSONReflect, ContaReceber;

type
  TContaReceberDAOClient = class(TDSAdminClient)
  private
    FListCommand: TDBXCommand;
    FInsertCommand: TDBXCommand;
    FUpdateCommand: TDBXCommand;
    FDeleteCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function List: TDBXReader;
    function Insert(ContaReceber: TContaReceber): Boolean;
    function Update(ContaReceber: TContaReceber): Boolean;
    function Delete(ContaReceber: TContaReceber): Boolean;
  end;

implementation

function TContaReceberDAOClient.List: TDBXReader;
begin
  if FListCommand = nil then
  begin
    FListCommand := FDBXConnection.CreateCommand;
    FListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListCommand.Text := 'TContaReceberDAO.List';
    FListCommand.Prepare;
  end;
  FListCommand.ExecuteUpdate;
  Result := FListCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TContaReceberDAOClient.Insert(ContaReceber: TContaReceber): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TContaReceberDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(ContaReceber) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ContaReceber), True);
      if FInstanceOwner then
        ContaReceber.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TContaReceberDAOClient.Update(ContaReceber: TContaReceber): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TContaReceberDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(ContaReceber) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ContaReceber), True);
      if FInstanceOwner then
        ContaReceber.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[1].Value.GetBoolean;
end;

function TContaReceberDAOClient.Delete(ContaReceber: TContaReceber): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TContaReceberDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  if not Assigned(ContaReceber) then
    FDeleteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDeleteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDeleteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ContaReceber), True);
      if FInstanceOwner then
        ContaReceber.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

constructor TContaReceberDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TContaReceberDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TContaReceberDAOClient.Destroy;
begin
  FreeAndNil(FListCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FDeleteCommand);
  inherited;
end;

end.

