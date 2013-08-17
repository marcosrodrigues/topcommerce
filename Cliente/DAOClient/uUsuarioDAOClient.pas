unit uUsuarioDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Generics.Collections, DBXJSONReflect, Usuario;

type
  TUsuarioDAOClient = class(TDSAdminClient)
  private
    FListCommand: TDBXCommand;
    FInsertCommand: TDBXCommand;
    FUpdateCommand: TDBXCommand;
    FDeleteCommand: TDBXCommand;
    FAtualizaAcessoCommand: TDBXCommand;
    FFindByLoginAndSenhaCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function List: TDBXReader;
    function Insert(usuario: TUsuario): Boolean;
    function Update(usuario: TUsuario; oldLogin: string): Boolean;
    function Delete(usuario: TUsuario): Boolean;
    function AtualizaAcesso(usuario: TUsuario): Boolean;
    function FindByLoginAndSenha(Login: string; Senha: string): TUsuario;
  end;

implementation

function TUsuarioDAOClient.List: TDBXReader;
begin
  if FListCommand = nil then
  begin
    FListCommand := FDBXConnection.CreateCommand;
    FListCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FListCommand.Text := 'TUsuarioDAO.List';
    FListCommand.Prepare;
  end;
  FListCommand.ExecuteUpdate;
  Result := FListCommand.Parameters[0].Value.GetDBXReader(FInstanceOwner);
end;

function TUsuarioDAOClient.Insert(usuario: TUsuario): Boolean;
begin
  if FInsertCommand = nil then
  begin
    FInsertCommand := FDBXConnection.CreateCommand;
    FInsertCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FInsertCommand.Text := 'TUsuarioDAO.Insert';
    FInsertCommand.Prepare;
  end;
  if not Assigned(usuario) then
    FInsertCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FInsertCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FInsertCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(usuario), True);
      if FInstanceOwner then
        usuario.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FInsertCommand.ExecuteUpdate;
  Result := FInsertCommand.Parameters[1].Value.GetBoolean;
end;

function TUsuarioDAOClient.Update(usuario: TUsuario; oldLogin: string): Boolean;
begin
  if FUpdateCommand = nil then
  begin
    FUpdateCommand := FDBXConnection.CreateCommand;
    FUpdateCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateCommand.Text := 'TUsuarioDAO.Update';
    FUpdateCommand.Prepare;
  end;
  if not Assigned(usuario) then
    FUpdateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FUpdateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FUpdateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(usuario), True);
      if FInstanceOwner then
        usuario.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FUpdateCommand.Parameters[1].Value.SetWideString(oldLogin);
  FUpdateCommand.ExecuteUpdate;
  Result := FUpdateCommand.Parameters[2].Value.GetBoolean;
end;

function TUsuarioDAOClient.Delete(usuario: TUsuario): Boolean;
begin
  if FDeleteCommand = nil then
  begin
    FDeleteCommand := FDBXConnection.CreateCommand;
    FDeleteCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FDeleteCommand.Text := 'TUsuarioDAO.Delete';
    FDeleteCommand.Prepare;
  end;
  if not Assigned(usuario) then
    FDeleteCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FDeleteCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDeleteCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(usuario), True);
      if FInstanceOwner then
        usuario.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDeleteCommand.ExecuteUpdate;
  Result := FDeleteCommand.Parameters[1].Value.GetBoolean;
end;

function TUsuarioDAOClient.AtualizaAcesso(usuario: TUsuario): Boolean;
begin
  if FAtualizaAcessoCommand = nil then
  begin
    FAtualizaAcessoCommand := FDBXConnection.CreateCommand;
    FAtualizaAcessoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAtualizaAcessoCommand.Text := 'TUsuarioDAO.AtualizaAcesso';
    FAtualizaAcessoCommand.Prepare;
  end;
  if not Assigned(usuario) then
    FAtualizaAcessoCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FAtualizaAcessoCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FAtualizaAcessoCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(usuario), True);
      if FInstanceOwner then
        usuario.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FAtualizaAcessoCommand.ExecuteUpdate;
  Result := FAtualizaAcessoCommand.Parameters[1].Value.GetBoolean;
end;

function TUsuarioDAOClient.FindByLoginAndSenha(Login: string; Senha: string): TUsuario;
begin
  if FFindByLoginAndSenhaCommand = nil then
  begin
    FFindByLoginAndSenhaCommand := FDBXConnection.CreateCommand;
    FFindByLoginAndSenhaCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFindByLoginAndSenhaCommand.Text := 'TUsuarioDAO.FindByLoginAndSenha';
    FFindByLoginAndSenhaCommand.Prepare;
  end;
  FFindByLoginAndSenhaCommand.Parameters[0].Value.SetWideString(Login);
  FFindByLoginAndSenhaCommand.Parameters[1].Value.SetWideString(Senha);
  FFindByLoginAndSenhaCommand.ExecuteUpdate;
  if not FFindByLoginAndSenhaCommand.Parameters[2].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FFindByLoginAndSenhaCommand.Parameters[2].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TUsuario(FUnMarshal.UnMarshal(FFindByLoginAndSenhaCommand.Parameters[2].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FFindByLoginAndSenhaCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;


constructor TUsuarioDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;


constructor TUsuarioDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;


destructor TUsuarioDAOClient.Destroy;
begin
  FreeAndNil(FListCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FAtualizaAcessoCommand);
  FreeAndNil(FFindByLoginAndSenhaCommand);
  inherited;
end;


end.

