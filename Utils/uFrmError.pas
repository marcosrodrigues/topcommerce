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

end.
