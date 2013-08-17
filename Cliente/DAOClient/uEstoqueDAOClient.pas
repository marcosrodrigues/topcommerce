unit uEstoqueDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Estoque, DBXJSONReflect;

type
  TEstoqueDAOClient = class(TDSAdminClient)
  private
    FListCommand: TDBXCommand;
    FInsertCommand: TDBXCommand;
    FUpdateCommand: TDBXCommand;
    FDeleteCommand: TDBXCommand;
    FRelatorioEstoqueCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function List: TDBXReader;
    function Insert(Estoque: TEstoque): Boolean;
    function Update(Estoque: TEstoque): Boolean;
    function Delete(Estoque: TEstoque): Boolean;
    function RelatorioEstoque(Estoque: Integer): TDBXReader;
  end;

implementation

function TEstoqueDAOClient.List: TDBXReader;
begin
  if FListCommand = nil then
  begin
    FListCommand := FDBXConnection.CreateCommand;
    FListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListCommand.Text := 'TEstoqueDAO.List';
    FListCommand.Prepare;
  end;
  FListCommand.ExecuteUpdate;
  Result := FListCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TEstoqueDAOClient.Insert(Estoque: TEstoque): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TEstoqueDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(Estoque) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Estoque), True);
      if FInstanceOwner then
        Estoque.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TEstoqueDAOClient.Update(Estoque: TEstoque): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TEstoqueDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(Estoque) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Estoque), True);
      if FInstanceOwner then
        Estoque.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[1].Value.GetBoolean;
end;

function TEstoqueDAOClient.Delete(Estoque: TEstoque): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TEstoqueDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  if not Assigned(Estoque) then
    FDeleteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDeleteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDeleteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Estoque), True);
      if FInstanceOwner then
        Estoque.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

function TEstoqueDAOClient.RelatorioEstoque(Estoque: Integer): TDBXReader;
begin
  if FRelatorioEstoqueCommand = nil then
  begin
    FRelatorioEstoqueCommand := FDBXConnection.CreateCommand;
    FRelatorioEstoqueCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FRelatorioEstoqueCommand.Text := 'TEstoqueDAO.RelatorioEstoque';
    FRelatorioEstoqueCommand.Prepare;
  end;
  FRelatorioEstoqueCommand.Parameters[0].Value.SetInt32(Estoque);
  FRelatorioEstoqueCommand.ExecuteUpdate;
  Result := FRelatorioEstoqueCommand.Parameters[1].Value.GetDBXReader(FInstanceOwner);
end;

constructor TEstoqueDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TEstoqueDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TEstoqueDAOClient.Destroy;
begin
  FreeAndNil(FListCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FRelatorioEstoqueCommand);
  inherited;
end;

end.

