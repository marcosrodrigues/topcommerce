unit uFuncionarioDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Generics.Collections, DBXJSONReflect, Funcionario;

type
  TFuncionarioDAOClient = class(TDSAdminClient)
  private
    FListCommand: TDBXCommand;
    FNextCodigoCommand: TDBXCommand;
    FInsertCommand: TDBXCommand;
    FUpdateCommand: TDBXCommand;
    FDeleteCommand: TDBXCommand;
    FFindByCodigoCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function List: TDBXReader;
    function NextCodigo: string;
    function Insert(Funcionario: TFuncionario): Boolean;
    function Update(Funcionario: TFuncionario): Boolean;
    function Delete(Funcionario: TFuncionario): Boolean;
    function FindByCodigo(Codigo: string): TFuncionario;
  end;

implementation

function TFuncionarioDAOClient.List: TDBXReader;
begin
  if FListCommand = nil then
  begin
    FListCommand := FDBXConnection.CreateCommand;
    FListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListCommand.Text := 'TFuncionarioDAO.List';
    FListCommand.Prepare;
  end;
  FListCommand.ExecuteUpdate;
  Result := FListCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TFuncionarioDAOClient.NextCodigo: string;
begin
  if FNextCodigoCommand = nil then
  begin
    FNextCodigoCommand := FDBXConnection.CreateCommand;
    FNextCodigoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FNextCodigoCommand.Text := 'TFuncionarioDAO.NextCodigo';
    FNextCodigoCommand.Prepare;
  end;
  FNextCodigoCommand.ExecuteUpdate;
  Result := FNextCodigoCommand.Parameters[0].Value.GetWideString;
end;

function TFuncionarioDAOClient.Insert(Funcionario: TFuncionario): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TFuncionarioDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(Funcionario) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Funcionario), True);
      if FInstanceOwner then
        Funcionario.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TFuncionarioDAOClient.Update(Funcionario: TFuncionario): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TFuncionarioDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(Funcionario) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Funcionario), True);
      if FInstanceOwner then
        Funcionario.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[1].Value.GetBoolean;
end;

function TFuncionarioDAOClient.Delete(Funcionario: TFuncionario): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TFuncionarioDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  if not Assigned(Funcionario) then
    FDeleteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDeleteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDeleteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Funcionario), True);
      if FInstanceOwner then
        Funcionario.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

function TFuncionarioDAOClient.FindByCodigo(Codigo: string): TFuncionario;
begin
  if FFindByCodigoCommand = nil then
  begin
    FFindByCodigoCommand := FDBXConnection.CreateCommand;
    FFindByCodigoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFindByCodigoCommand.Text := 'TFuncionarioDAO.FindByCodigo';
    FFindByCodigoCommand.Prepare;
  end;
  FFindByCodigoCommand.Parameters[0].Value.SetWideString(Codigo);
  FFindByCodigoCommand.ExecuteUpdate;
  if not FFindByCodigoCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FFindByCodigoCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TFuncionario(FUnMarshal.UnMarshal(FFindByCodigoCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FFindByCodigoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;


constructor TFuncionarioDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TFuncionarioDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TFuncionarioDAOClient.Destroy;
begin
  FreeAndNil(FListCommand);
  FreeAndNil(FNextCodigoCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FFindByCodigoCommand);
  inherited;
end;

end.

