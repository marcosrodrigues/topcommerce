{TODO -oMarcos -cServidor : Implementar iniciar banco de dados ao ininciar servidor}
unit uFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles, WinSvc;

type
  TFrmPrincipal = class(TForm)
    lblEstado: TLabel;
    bbtIniciarParar: TBitBtn;
    gbBancoDados: TGroupBox;
    Label1: TLabel;
    edtServidor: TEdit;
    Label2: TLabel;
    edtBancoDados: TEdit;
    Label3: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Label4: TLabel;
    bbtConectar: TBitBtn;
    lblStatusBanco: TLabel;
    chbConectarIniciar: TCheckBox;
    procedure bbtIniciarPararClick(Sender: TObject);
    procedure bbtConectarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure ConectarBancoDados;
    function ServiceGetStatus(sMachine, sService: PChar): DWORD;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses uSCPrincipal, MensagensUtils;

{$R *.dfm}

procedure TFrmPrincipal.bbtConectarClick(Sender: TObject);
var
  Ini: TIniFile;
begin
  if bbtConectar.Caption = 'Conectar' then
  begin
    Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
    try
      Ini.WriteString('BANCODADOS', 'HOSTNAME', edtServidor.Text);
      Ini.WriteString('BANCODADOS', 'DATABASE', edtBancoDados.Text);
      Ini.WriteString('BANCODADOS', 'USER_NAME', edtUsuario.Text);
      Ini.WriteString('BANCODADOS', 'PASSWORD', edtSenha.Text);
      Ini.WriteBool('BANCODADOS', 'CONECTAR', chbConectarIniciar.Checked);
    finally
      Ini.Free;
    end;
    ConectarBancoDados;
  end
  else
  begin
    SCPrincipal.ConnTopCommerce.Close;

    bbtConectar.Caption       := 'Conectar';
    lblStatusBanco.Caption    := 'Desconectado';
    lblStatusBanco.Font.Color := clRed;
  end;
end;

procedure TFrmPrincipal.bbtIniciarPararClick(Sender: TObject);
begin
  if not SCPrincipal.ConnTopCommerce.Connected then
  begin
    Atencao('Só é possível ativar o servidor após conectar com o banco de dados.');
    Exit;
  end;

  if (SCPrincipal.DSServer.Started) then
  begin
    SCPrincipal.DSServer.Stop;
    lblEstado.Caption       := 'Parado';
    lblEstado.Font.Color    := clRed;
    bbtIniciarParar.Kind    := bkOK;
    bbtIniciarParar.Caption := 'Iniciar';
  end
  else
  begin
    SCPrincipal.DSServer.Start;
    lblEstado.Caption       := 'Executando...';
    lblEstado.Font.Color    := clGreen;
    bbtIniciarParar.Kind    := bkCancel;
    bbtIniciarParar.Caption := 'Parar';
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    edtServidor.Text           := Ini.ReadString('BANCODADOS', 'HOSTNAME', 'DEV');
    edtBancoDados.Text         := Ini.ReadString('BANCODADOS', 'DATABASE', 'TopCommerce');
    edtUsuario.Text            := Ini.ReadString('BANCODADOS', 'USER_NAME', 'sa');
    edtSenha.Text              := Ini.ReadString('BANCODADOS', 'PASSWORD', 'sa');
    chbConectarIniciar.Checked := Ini.ReadBool('BANCODADOS', 'CONECTAR', False);

    if (chbConectarIniciar.Checked) then
      ConectarBancoDados;
  finally
    Ini.Free;
  end;
end;

function TFrmPrincipal.ServiceGetStatus(sMachine, sService: PChar): DWORD;
  {******************************************}
  {*** Parameters: ***}
  {*** sService: specifies the name of the service to open
  {*** sMachine: specifies the name of the target computer
  {*** ***}
  {*** Return Values: ***}
  {*** -1 = Error opening service ***}
  {*** 1 = SERVICE_STOPPED ***}
  {*** 2 = SERVICE_START_PENDING ***}
  {*** 3 = SERVICE_STOP_PENDING ***}
  {*** 4 = SERVICE_RUNNING ***}
  {*** 5 = SERVICE_CONTINUE_PENDING ***}
  {*** 6 = SERVICE_PAUSE_PENDING ***}
  {*** 7 = SERVICE_PAUSED ***}
  {******************************************}
var
  SCManHandle, SvcHandle: SC_Handle;
  SS: TServiceStatus;
  dwStat: DWORD;
begin
  dwStat := 0;
  // Open service manager handle.
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
  begin
    SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
    // if Service installed
    if (SvcHandle > 0) then
    begin
      // SS structure holds the service status (TServiceStatus);
      if (QueryServiceStatus(SvcHandle, SS)) then
        dwStat := ss.dwCurrentState;
      CloseServiceHandle(SvcHandle);
    end;
    CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;
end;

procedure TFrmPrincipal.ConectarBancoDados;
begin
  // Esperar serviço do banco de dados iniciar
  while SERVICE_RUNNING <> ServiceGetStatus(nil, 'MSSQLSERVER') do
  begin

  end;


  SCPrincipal.ConnTopCommerce.Params.Add('HostName=' + edtServidor.Text);
  SCPrincipal.ConnTopCommerce.Params.Add('Database=' + edtBancoDados.Text);
  SCPrincipal.ConnTopCommerce.Params.Add('User_Name=' + edtUsuario.Text);
  SCPrincipal.ConnTopCommerce.Params.Add('Password=' + edtSenha.Text);
  try
    SCPrincipal.ConnTopCommerce.Open;
    bbtConectar.Caption := 'Desconectar';
    lblStatusBanco.Caption := 'Conectado';
    lblStatusBanco.Font.Color := clGreen;
  except
    on e: Exception do
      //Atencao('Ocorreu um erro ao tentar conectar o banco de dados: ' + chr(13) + e.Message);
      Informacao('Provavelmente o serviço do banco de dados ainda não foi iniciado.'+#13+
                 'Tente conectar manualmente em alguns instantes.'+e.Message);
  end;
end;

end.

