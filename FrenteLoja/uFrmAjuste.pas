unit uFrmAjuste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask;

type
  TFrmAjuste = class(TForm)
    Panel1: TPanel;
    lblDescricaoProduto: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtQuantidade: TEdit;
    Label4: TLabel;
    Panel2: TPanel;
    edtPrecoUnitario: TEdit;
    Panel3: TPanel;
    edtPrecoTotal: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAjuste: TFrmAjuste;

implementation

{$R *.dfm}

procedure TFrmAjuste.edtQuantidadeChange(Sender: TObject);
begin
  if (edtQuantidade.Text <> '') then
    edtPrecoTotal.Text := FormatCurr(',0.00', StrToInt(edtQuantidade.Text) * StrToCurr(edtPrecoUnitario.Text));
end;

procedure TFrmAjuste.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
    Self.Close;
end;

procedure TFrmAjuste.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
  end;
end;

end.
