unit uFrmConfirm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, Buttons;

type
  TFrmConfirm = class(TForm)
    Shape1: TShape;
    Image1: TImage;
    btnSim: TBitBtn;
    btnNao: TBitBtn;
    mmMensagem: TMemo;
    procedure btnSimClick(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
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
  FrmConfirm: TFrmConfirm;

implementation

{$R *.dfm}

procedure TFrmConfirm.btnNaoClick(Sender: TObject);
begin
  ModalResult := mrNo;
  CloseModal;
end;

procedure TFrmConfirm.btnSimClick(Sender: TObject);
begin
  ModalResult := mrYes;
  CloseModal;
end;

procedure TFrmConfirm.FormShow(Sender: TObject);
begin
  btnSim.SetFocus;
  mmMensagem.Text := Mensagem;
end;

procedure TFrmConfirm.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  SendMessage(Self.Handle, WM_SYSCOMMAND, 61458, 0);
end;

end.
