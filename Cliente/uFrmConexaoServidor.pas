unit uFrmConexaoServidor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, IniFiles, DXPControl, DXPButtons;

type
  TFrmConexaoServidor = class(TForm)
    Label1: TLabel;
    edtEndereco: TEdit;
    btnConectar: TDXPButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConectarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConexaoServidor: TFrmConexaoServidor;

implementation

{$R *.dfm}

procedure TFrmConexaoServidor.btnConectarClick(Sender: TObject);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    Ini.WriteString('SERVIDOR', 'HOST', edtEndereco.Text);
  finally
    Ini.Free;
  end;
  Close;
end;

procedure TFrmConexaoServidor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Application.Terminate;
  end;
end;

end.
