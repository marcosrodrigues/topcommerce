unit uFrmWarning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, pngimage, ExtCtrls;

type
  TFrmWarning = class(TForm)
    Shape1: TShape;
    Image1: TImage;
    btnOk: TBitBtn;
    mmMensagem: TMemo;
    procedure btnOkClick(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Mensagem: string;
  end;

var
  FrmWarning: TFrmWarning;

implementation

{$R *.dfm}

procedure TFrmWarning.btnOkClick(Sender: TObject);
begin
  CloseModal;
end;

procedure TFrmWarning.FormShow(Sender: TObject);
begin
  mmMensagem.Text := Mensagem;
end;

procedure TFrmWarning.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Self.Handle, WM_SYSCOMMAND, 61458, 0);
end;

end.
