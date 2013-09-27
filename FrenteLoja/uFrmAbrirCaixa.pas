unit uFrmAbrirCaixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, ComCtrls, DXPControl, DXPButtons,
  DXPCurrencyEdit;

type
  TFrmAbrirCaixa = class(TForm)
    Panel1: TPanel;
    Image19: TImage;
    Label1: TLabel;
    deData: TDateTimePicker;
    Label2: TLabel;
    cedValorAbertura: TDXPCurrencyEdit;
    btnAbrir: TDXPButton;
    procedure Image19Click(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Abrir: Boolean;
  end;

var
  FrmAbrirCaixa: TFrmAbrirCaixa;

implementation

{$R *.dfm}

procedure TFrmAbrirCaixa.btnAbrirClick(Sender: TObject);
begin
  Abrir := True;
  Self.Close;
end;

procedure TFrmAbrirCaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
  end;
end;

procedure TFrmAbrirCaixa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
  begin
    if (Self.ActiveControl = deData) then
      cedValorAbertura.SetFocus
    else if (Self.ActiveControl = cedValorAbertura) then
      btnAbrir.SetFocus;
  end;
end;

procedure TFrmAbrirCaixa.FormShow(Sender: TObject);
begin
  deData.DateTime := Now;
end;

procedure TFrmAbrirCaixa.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

end.
