unit uFrmFecharVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, DXPControl,
  DXPButtons, Cliente, DXPCurrencyEdit, pngimage, RxToolEdit, RxCurrEdit;

type
  TFrmFecharVenda = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    btnFechar: TDXPButton;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Image19: TImage;
    lbFormaPagamento: TListBox;
    cedDescontoValor: TCurrencyEdit;
    cedDescontoPercentual: TCurrencyEdit;
    cedTotal: TCurrencyEdit;
    cedValorRecebido: TCurrencyEdit;
    cedTroco: TCurrencyEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cedDescontoValorExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure cedDescontoPercentualExit(Sender: TObject);
    procedure cedValorRecebidoExit(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure lbFormaPagamentoEnter(Sender: TObject);
  private
    { Private declarations }
    procedure CalcularTotal;
  public
    { Public declarations }
    Total: Currency;
    Fechar: Boolean;
  end;

var
  FrmFecharVenda: TFrmFecharVenda;

implementation

uses uFrmConsultaClientes, MensagensUtils;

{$R *.dfm}

procedure TFrmFecharVenda.btnFecharClick(Sender: TObject);
begin
  Fechar := True;
  Close;
end;

procedure TFrmFecharVenda.CalcularTotal;
begin
  if (cedDescontoValor.Value = 0) then
    cedTotal.Value := Total
  else
    cedTotal.Value := Total - cedDescontoValor.Value;

  if (cedDescontoPercentual.Value <> 0) then
    cedTotal.Value := cedTotal.Value - (cedTotal.Value * (cedDescontoPercentual.Value / 100));
end;

procedure TFrmFecharVenda.cedDescontoPercentualExit(Sender: TObject);
begin
  CalcularTotal;
end;

procedure TFrmFecharVenda.cedDescontoValorExit(Sender: TObject);
begin
  CalcularTotal;
end;

procedure TFrmFecharVenda.cedValorRecebidoExit(Sender: TObject);
begin
  if cedValorRecebido.Value = 0 then
  begin
    Atencao('Informe o valor recebido.');
    cedValorRecebido.SetFocus;
    Exit;
  end;
  if cedValorRecebido.Value < cedTotal.Value then
  begin
    Atencao('Valor recebido deve ser maior ou igual ao total da venda.');
    cedValorRecebido.SetFocus;
    Exit;
  end;
  cedTroco.Value := cedValorRecebido.Value - cedTotal.Value;
end;

procedure TFrmFecharVenda.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
  end;
end;

procedure TFrmFecharVenda.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
  begin
    if (Self.ActiveControl = cedDescontoValor) then
      cedDescontoPercentual.SetFocus
    else if (Self.ActiveControl = cedDescontoPercentual) then
      cedTotal.SetFocus
    else if (Self.ActiveControl = cedTotal) then
      cedValorRecebido.SetFocus
    else if (Self.ActiveControl = cedValorRecebido) then
      lbFormaPagamento.SetFocus
    else if (Self.ActiveControl = lbFormaPagamento) then
      btnFechar.SetFocus;
  end;
end;

procedure TFrmFecharVenda.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmFecharVenda.lbFormaPagamentoEnter(Sender: TObject);
begin
  lbFormaPagamento.Selected[0] := True;
end;

end.
