unit uFrmAjuste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, DXPCurrencyEdit;

type
  TFrmAjuste = class(TForm)
    Panel1: TPanel;
    lblDescricaoProduto: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtQuantidade: TEdit;
    Label4: TLabel;
    cedPrecoUnitario: TDXPCurrencyEdit;
    Label3: TLabel;
    cedDescValor: TDXPCurrencyEdit;
    Label5: TLabel;
    cedDescPercentual: TDXPCurrencyEdit;
    cedPrecoTotal: TDXPCurrencyEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure cedDescValorExit(Sender: TObject);
    procedure cedDescPercentualExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure CalcularValor;
  public
    { Public declarations }
    DescontoMaximoValor, DescontoMaximoPercentual: Currency;
  end;

var
  FrmAjuste: TFrmAjuste;

implementation

uses MensagensUtils;

{$R *.dfm}

procedure TFrmAjuste.CalcularValor;

  function Total: Currency;
  begin
    Result := cedPrecoUnitario.Value * StrToInt(edtQuantidade.Text);
  end;

begin
  if (cedDescValor.Value = 0) then
    cedPrecoTotal.Value := Total
  else
    cedPrecoTotal.Value := Total - cedDescValor.Value;

  if (cedDescPercentual.Value <> 0) then
    cedPrecoTotal.Value := cedPrecoTotal.Value - (cedPrecoTotal.Value * (cedDescPercentual.Value / 100));
end;

procedure TFrmAjuste.cedDescPercentualExit(Sender: TObject);
begin
  if cedDescPercentual.Value > DescontoMaximoPercentual then
  begin
    Atencao('Desconto máximo permitido: '+FormatCurr(',0.00', DescontoMaximoPercentual));
    cedDescPercentual.Value := DescontoMaximoPercentual;
  end;

  CalcularValor;
end;

procedure TFrmAjuste.cedDescValorExit(Sender: TObject);
begin
  if cedDescValor.Value > DescontoMaximoValor * StrToIntDef(edtQuantidade.Text, 1) then
  begin
    Atencao('Desconto máximo permitido: '+FormatCurr(',0.00', DescontoMaximoValor * StrToIntDef(edtQuantidade.Text, 1)));
    cedDescValor.Value := DescontoMaximoValor;
  end;

  CalcularValor;
end;

procedure TFrmAjuste.edtQuantidadeChange(Sender: TObject);
begin
  if (edtQuantidade.Text <> '') then
    cedPrecoTotal.Value := StrToInt(edtQuantidade.Text) * cedPrecoUnitario.Value;
end;

procedure TFrmAjuste.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
  end;
end;

procedure TFrmAjuste.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
  begin
    if (Self.ActiveControl = edtQuantidade) then
      cedDescValor.SetFocus
    else if (Self.ActiveControl = cedDescValor) then
      cedDescPercentual.SetFocus
    else if (Self.ActiveControl = cedDescPercentual) then
      cedPrecoTotal.SetFocus
    else if (Self.ActiveControl = cedPrecoTotal) then
      Self.Close;
  end;
end;

end.
