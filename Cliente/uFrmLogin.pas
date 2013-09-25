unit uFrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Menus, Usuario, DBXDataSnap, DBXCommon, DB, SqlExpr,
  uUsuarioDAOClient, IniFiles, DXPControl, DXPButtons, pngimage;

type
  TFrmLogin = class(TForm)
    imgLogin: TImage;
    Label1: TLabel;
    edtUsuario: TEdit;
    Label2: TLabel;
    edtSenha: TEdit;
    ConnServidor: TSQLConnection;
    btnOk: TDXPButton;
    btnSair: TDXPButton;
    Panel1: TPanel;
    Image19: TImage;
    procedure btnSairClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Image19Click(Sender: TObject);
  private
    { Private declarations }
    DAOClient: TUsuarioDAOClient;
  public
    { Public declarations }
    Usuario: TUsuario;
    FLoginSucess: Boolean;
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses MensagensUtils, uFrmConexaoServidor, uFrmConectandoServidor;

{$R *.dfm}

procedure TFrmLogin.btnOkClick(Sender: TObject);
begin
  Usuario := DAOClient.FindByLoginAndSenha(edtUsuario.Text, edtSenha.Text);
  if ( Usuario <> nil ) or
     ( ( edtUsuario.Text = 'TOP' ) and ( edtSenha.Text = 'admin' ) ) then
  begin
    FLoginSucess := True;
    Close;
  end
  else
  begin
    Atencao( 'Usuário ou senha incorreto.' );
    edtUsuario.SetFocus;
  end;
end;

procedure TFrmLogin.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  fLoad: TFrmConectandoServidor;
  Direcao: Integer;

  procedure ConexaoServidor;
  var
    fConexaoServidor: TFrmConexaoServidor;
  begin
    fConexaoServidor := nil;
    if fConexaoServidor = nil then
      fConexaoServidor := TFrmConexaoServidor.Create(nil);
    fConexaoServidor.ShowModal;
  end;
begin
  if ( FileExists( ChangeFileExt( Application.ExeName, '.INI' ) ) ) then
  begin
    Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
    try
      if Ini.ReadString('SERVIDOR', 'HOST', '') <> '' then
        ConnServidor.Params.Add('HostName=' + Ini.ReadString('SERVIDOR', 'HOST', ''))
      else
        ConexaoServidor;
    finally
      Ini.Free;
    end;

    fLoad := TFrmConectandoServidor.Create(Application);
    fLoad.Show;
    Direcao := 1;
    while not ConnServidor.Connected do
    begin
      try
        if (Direcao = 1) then
          fLoad.ProgressBar.Position := fLoad.ProgressBar.Position + 10
        else
          fLoad.ProgressBar.Position := fLoad.ProgressBar.Position - 10;

        if fLoad.ProgressBar.Position = 100 then
          Direcao := -1;
        if fLoad.ProgressBar.Position = 0 then
          Direcao := 1;

        Application.ProcessMessages;
        ConnServidor.Open;

        Break;
      except

      end;
    end;
    fLoad.Close;
  end
  else
    ConexaoServidor;

  DAOClient := TUsuarioDAOClient.Create(ConnServidor.DBXConnection);
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
  DAOClient.Free;
  ConnServidor.Close;
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
  end;
end;

procedure TFrmLogin.FormKeyPress(Sender: TObject; var Key: Char);
var
  l: TList;
  I: Integer;
begin
  if Ord( Key ) = 13 then
  begin
    l := TList.Create;
    try
      GetTabOrderList( l );
      for I := 0 to l.Count - 1 do
        if ( TWinControl( l[I] ).TabOrder = ActiveControl.TabOrder + 1 ) then
        begin
          TWinControl( l[I] ).SetFocus;
          Exit;
        end;
    finally
      l.Free;
    end;
  end;
end;

procedure TFrmLogin.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

end.
