unit uContaPagarDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Generics.Collections, DBXJSONReflect, ContaPagar;

type
  TContaPagarDAOClient = class(TDSAdminClient)
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
    function Insert(ContaPagar: TContaPagar): Boolean;
    function Update(ContaPagar: TContaPagar): Boolean;
    function Delete(ContaPagar: TContaPagar): Boolean;
  end;

implementation

function TContaPagarDAOClient.List: TDBXReader;
begin
  if FListCommand = nil then
  begin
    FListCommand := FDBXConnection.CreateCommand;
    FListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListCommand.Text := 'TContaPagarDAO.List';
    FListCommand.Prepare;
  end;
  FListCommand.ExecuteUpdate;
  Result := FListCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TContaPagarDAOClient.Insert(ContaPagar: TContaPagar): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TContaPagarDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(ContaPagar) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ContaPagar), True);
      if FInstanceOwner then
        ContaPagar.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TContaPagarDAOClient.Update(ContaPagar: TContaPagar): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TContaPagarDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(ContaPagar) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ContaPagar), True);
      if FInstanceOwner then
        ContaPagar.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[1].Value.GetBoolean;
end;

function TContaPagarDAOClient.Delete(ContaPagar: TContaPagar): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TContaPagarDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  if not Assigned(ContaPagar) then
    FDeleteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDeleteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDeleteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ContaPagar), True);
      if FInstanceOwner then
        ContaPagar.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

constructor TContaPagarDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TContaPagarDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TContaPagarDAOClient.Destroy;
begin
  FreeAndNil(FListCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FDeleteCommand);
  inherited;
end;

end.

