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
    FBaixarContaCommand: TDBXCommand;
    FRelatorioCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function List: TDBXReader;
    function Insert(ContaReceber: TContaReceber): Boolean;
    function Update(ContaReceber: TContaReceber): Boolean;
    function Delete(ContaReceber: TContaReceber): Boolean;
    function BaixarConta(ContaReceber: TContaReceber): Boolean;
    function Relatorio(DataInicial, DataFinal: TDateTime; ClienteCodigo: string; Situacao: Integer): TDBXReader;
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

function TContaReceberDAOClient.Relatorio(DataInicial, DataFinal: TDateTime; ClienteCodigo: string; Situacao: Integer): TDBXReader;
begin
  if FRelatorioCommand = nil then
  begin
    FRelatorioCommand := FDBXConnection.CreateCommand;
    FRelatorioCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FRelatorioCommand.Text := 'TContaReceberDAO.Relatorio';
    FRelatorioCommand.Prepare;
  end;
  FRelatorioCommand.Parameters[0].Value.AsDateTime := DataInicial;
  FRelatorioCommand.Parameters[1].Value.AsDateTime := DataFinal;
  FRelatorioCommand.Parameters[2].Value.AsString   := ClienteCodigo;
  FRelatorioCommand.Parameters[3].Value.AsInt32    := Situacao;
  FRelatorioCommand.ExecuteUpdate;
  Result := FRelatorioCommand.Parameters[4].Value.GetDBXReader(FInstanceOwner);
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

function TContaReceberDAOClient.BaixarConta(ContaReceber: TContaReceber): Boolean;
begin
  if FBaixarContaCommand = nil then
  begin
    FBaixarContaCommand := FDBXConnection.CreateCommand;
    FBaixarContaCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FBaixarContaCommand.Text := 'TContaReceberDAO.BaixarConta';
    FBaixarContaCommand.Prepare;
  end;
  if not Assigned(ContaReceber) then
    FBaixarContaCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FBaixarContaCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FBaixarContaCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(ContaReceber), True);
      if FInstanceOwner then
        ContaReceber.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FBaixarContaCommand.ExecuteUpdate;
  Result := FBaixarContaCommand.Parameters[1].Value.GetBoolean;
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
  FreeAndNil(FBaixarContaCommand);
  FreeAndNil(FRelatorioCommand);
  inherited;
end;

end.

