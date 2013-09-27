unit uCaixaDAOClient;

interface

uses DBXCommon, DBXClient, DBXJSON, DSProxy, Classes, SysUtils, DB, SqlExpr, DBXDBReaders, Generics.Collections, DBXJSONReflect, Caixa;

type
  TCaixaDAOClient = class(TDSAdminClient)
  private
    FAbrirCommand: TDBXCommand;
    FFecharCommand: TDBXCommand;
    FCaixaAbertoCommand: TDBXCommand;
    FRelatorioCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function Abrir(Caixa: TCaixa): Boolean;
    function Fechar: Boolean;
    function CaixaAberto: TCaixa;
    function Relatorio(DataInicial, DataFinal: TDateTime): TDBXReader;
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

function TCaixaDAOClient.CaixaAberto: TCaixa;
begin
  if FCaixaAbertoCommand = nil then
  begin
    FCaixaAbertoCommand := FDBXConnection.CreateCommand;
    FCaixaAbertoCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FCaixaAbertoCommand.Text := 'TCaixaDAO.CaixaAberto';
    FCaixaAbertoCommand.Prepare;
  end;
  FCaixaAbertoCommand.ExecuteUpdate;
  if not FCaixaAbertoCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FCaixaAbertoCommand.Parameters[0].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TCaixa(FUnMarshal.UnMarshal(FCaixaAbertoCommand.Parameters[0].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCaixaAbertoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

constructor TCaixaDAOClient.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TCaixaDAOClient.Destroy;
begin
  FreeAndNil(FAbrirCommand);
  FreeAndNil(FFecharCommand);
  FreeAndNil(FCaixaAbertoCommand);
  FreeAndNil(FRelatorioCommand);
  inherited;
end;

function TCaixaDAOClient.Fechar: Boolean;
begin
  if FFecharCommand = nil then
  begin
    FFecharCommand := FDBXConnection.CreateCommand;
    FFecharCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FFecharCommand.Text := 'TCaixaDAO.Fechar';
    FFecharCommand.Prepare;
  end;
  FFecharCommand.ExecuteUpdate;
  Result := FFecharCommand.Parameters[0].Value.GetBoolean;
end;

function TCaixaDAOClient.Relatorio(DataInicial, DataFinal: TDateTime): TDBXReader;
begin
  if FRelatorioCommand = nil then
  begin
    FRelatorioCommand := FDBXConnection.CreateCommand;
    FRelatorioCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FRelatorioCommand.Text := 'TCaixaDAO.Relatorio';
    FRelatorioCommand.Prepare;
  end;
  FRelatorioCommand.Parameters[0].Value.AsDateTime := DataInicial;
  FRelatorioCommand.Parameters[1].Value.AsDateTime := DataFinal;
  FRelatorioCommand.ExecuteUpdate;
  Result := FRelatorioCommand.Parameters[2].Value.GetDBXReader(FInstanceOwner);
end;

end.

