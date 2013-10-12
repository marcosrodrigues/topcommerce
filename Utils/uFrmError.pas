unit uFrmError;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, pngimage, ExtCtrls;

type
  TFrmError = class(TForm)
    Shape1: TShape;
    Image1: TImage;
    btnOk: TBitBtn;
    mmMensagem: TMemo;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    Mensagem: string;
  end;

var
  FrmError: TFrmError;

implementation

{$R *.dfm}

procedure TFrmError.btnOkClick(Sender: TObject);
begin
  CloseModal;
end;

procedure TFrmError.FormShow(Sender: TObject);
begin
  mmMensagem.Text := Mensagem;
end;

procedure TFrmError.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Self.Handle, WM_SYSCOMMAND, 61458, 0);
end;

end.
