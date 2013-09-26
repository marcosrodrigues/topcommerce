unit uCaixaDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Generics.Collections, DBXJSONReflect, Caixa;

type
  TCaixaDAOClient = class(TDSAdminClient)
  private
    FAbrirCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function Abrir(Caixa: TCaixa): Boolean;
  end;

implementation

function TCaixaDAOClient.Abrir(Caixa: TCaixa): Boolean;
begin
  if FAbrirCommand = nil then
  begin
    FAbrirCommand := FDBXConnection.CreateCommand;
    FAbrirCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAbrirCommand.Text := 'TCaixaDAO.Abrir';
    FAbrirCommand.Prepare;
  end;
  if not Assigned(Caixa) then
    FAbrirCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDBXClientCommand(FAbrirCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FAbrirCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Caixa), True);
      if FInstanceOwner then
        Caixa.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FAbrirCommand.ExecuteUpdate;
  Result := FAbrirCommand.Parameters[1].Value.GetBoolean;
end;

constructor TCaixaDAOClient.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TCaixaDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TCaixaDAOClient.Destroy;
begin
  FreeAndNil(FAbrirCommand);
  inherited;
end;

end.

