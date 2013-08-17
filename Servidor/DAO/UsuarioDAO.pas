unit UsuarioDAO;

interface

uses
  Classes, DBXCommon, SqlExpr, Usuario, SysUtils;

type
  {$MethodInfo ON}
  TUsuarioDAO = class(TPersistent)
  private
    FComm: TDBXCommand;

    procedure PrepareCommand;
  public
    function List: TDBXReader;
    function Insert(usuario: TUsuario): Boolean;
    function Update(usuario: TUsuario; oldLogin: string): Boolean;
    function Delete(usuario: TUsuario): Boolean;
    function AtualizaAcesso(usuario: TUsuario): Boolean;
    function FindByLoginAndSenha(Login, Senha: string): TUsuario;
  end;


implementation

uses uSCPrincipal, StringUtils;

{ TUsuarioDAO }

procedure TUsuarioDAO.PrepareCommand;
begin
  if not(Assigned(FComm)) then
  begin
    if not(SCPrincipal.ConnTopCommerce.Connected) then
      SCPrincipal.ConnTopCommerce.Open;
    FComm := SCPrincipal.ConnTopCommerce.DBXConnection.CreateCommand;
    FComm.CommandType := TDBXCommandTypes.DbxSQL;
    if not(FComm.IsPrepared) then
      FComm.Prepare;
  end;
end;

function TUsuarioDAO.List: TDBXReader;
begin
  PrepareCommand;
  FComm.Text := 'SELECT * FROM USUARIOS';
  Result := FComm.ExecuteQuery;
end;

function TUsuarioDAO.Insert(usuario: TUsuario): Boolean;
begin
  PrepareCommand;
  FComm.Text := 'INSERT INTO USUARIOS (LOGIN, SENHA) VALUES ('''+usuario.Login+''','''+usuario.Senha+''')';
  try
    FComm.ExecuteUpdate;
    Result := True;
  except
    Result := False;
  end;
end;

function TUsuarioDAO.Update(usuario: TUsuario; oldLogin: string): Boolean;
begin
  PrepareCommand;
  FComm.Text := 'UPDATE USUARIOS SET LOGIN = '''+usuario.Login+''', SENHA = '''+usuario.Senha+''''+
                ' WHERE LOGIN = '''+oldLogin+'''';
  try
    FComm.ExecuteUpdate;
    Result := True;
  except
    Result := False;
  end;
end;

function TUsuarioDAO.Delete(usuario: TUsuario): Boolean;
begin
  PrepareCommand;
  FComm.Text := 'DELETE FROM USUARIOS WHERE LOGIN = '''+usuario.Login+'''';
  try
    FComm.ExecuteUpdate;
    Result := True;
  except
    Result := False;
  end;
end;

function TUsuarioDAO.AtualizaAcesso(usuario: TUsuario): Boolean;
var
  query: TSQLQuery;
begin
  query := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    try
      query.SQL.Text := 'UPDATE USUARIOS SET ULTIMO_ACESSO = :ULTIMOACESSO'+
                        ' WHERE LOGIN = :LOGIN';
      query.ParamByName('ULTIMOACESSO').AsDateTime := Now;
      query.ParamByName('LOGIN').AsString          := usuario.Login;
      query.ExecSQL;

      Result := True;
    except
      Result := False;
    end;
  finally
    query.Free;
  end;
end;

function TUsuarioDAO.FindByLoginAndSenha(Login, Senha: string): TUsuario;
var
  query: TSQLQuery;
begin
  Result := Default(TUsuario);
  query  := TSQLQuery.Create(nil);
  try
    query.SQLConnection := SCPrincipal.ConnTopCommerce;
    query.SQL.Text := 'SELECT * FROM USUARIOS WHERE LOGIN = ''' + Login + ''' AND SENHA = ''' + Senha + '''';
    query.Open;
    if not( query.IsEmpty ) then
    begin
      Result := TUsuario.Create(query.FieldByName('LOGIN').AsString,
                                query.FieldByName('SENHA').AsString);

      AtualizaAcesso( Result );
    end;
  finally
    query.Free;
  end;
end;

end.
