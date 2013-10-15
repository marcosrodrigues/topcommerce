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
    Shape1: TShape;
    lbParcelamento: TListBox;
    lblParcelamento: TLabel;
    lblRestante: TLabel;
    cedRestante: TCurrencyEdit;
    lblValorParcela: TLabel;
    cedValorParcela: TCurrencyEdit;
    lblPrimeiroVencimento: TLabel;
    dePrimeiroVencimento: TDateEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cedDescontoValorExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure cedDescontoPercentualExit(Sender: TObject);
    procedure cedValorRecebidoExit(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure lbFormaPagamentoEnter(Sender: TObject);
    procedure lbFormaPagamentoClick(Sender: TObject);
    procedure lbParcelamentoClick(Sender: TObject);
    procedure lbFormaPagamentoExit(Sender: TObject);
  private
    { Private declarations }
    procedure CalcularTotal;
    procedure CalculaValorRestante;
    procedure CalculaValorParcela;
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
  if (lbFormaPagamento.ItemIndex in [0,3,4]) and (cedValorRecebido.Value = 0) then
  begin
    Atencao('Informe o valor recebido.');
    cedValorRecebido.SetFocus;
    Exit;
  end;

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

procedure TFrmFecharVenda.CalculaValorParcela;
begin
  if lbParcelamento.ItemIndex > -1 then
    cedValorParcela.Value := cedRestante.Value / (lbParcelamento.ItemIndex + 1);
end;

procedure TFrmFecharVenda.CalculaValorRestante;
begin
  if cedValorRecebido.Value < cedTotal.Value then
    cedRestante.Value := cedTotal.Value - cedValorRecebido.Value
  else
    cedRestante.Value := 0;
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
  if cedValorRecebido.Value > cedTotal.Value then
  begin
    cedTroco.Value := cedValorRecebido.Value - cedTotal.Value;
    cedRestante.Value := 0;
  end
  else if cedValorRecebido.Value < cedTotal.Value then
  begin
    cedRestante.Value := cedTotal.Value - cedValorRecebido.Value;
    CalculaValorParcela;
  end;
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
    else if (Self.ActiveControl = lbFormaPagamento) and (lbFormaPagamento.ItemIndex in [1, 2]) then
      lbParcelamento.SetFocus
    else if (Self.ActiveControl = lbParcelamento) and (lbFormaPagamento.ItemIndex = 1) then
      dePrimeiroVencimento.SetFocus
    else if (Self.ActiveControl = lbParcelamento) then
      btnFechar.SetFocus
    else if (Self.ActiveControl = dePrimeiroVencimento) then
      btnFechar.SetFocus
    else if (Self.ActiveControl = lbFormaPagamento) then
      btnFechar.SetFocus;
  end;
end;

procedure TFrmFecharVenda.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmFecharVenda.lbFormaPagamentoClick(Sender: TObject);
begin
  if lbFormaPagamento.ItemIndex = 1 then
  begin
    lblParcelamento.Show;
    lbParcelamento.Show;
    lblRestante.Show;
    cedRestante.Show;
    lblValorParcela.Show;
    cedValorParcela.Show;
    lblPrimeiroVencimento.Show;
    dePrimeiroVencimento.Show;

    if lbParcelamento.ItemIndex = -1 then
      lbParcelamento.Selected[0] := True;

    CalculaValorRestante;
    CalculaValorParcela;
    dePrimeiroVencimento.Date := IncMonth(Now);
  end
  else if lbFormaPagamento.ItemIndex = 2 then
  begin
    lblParcelamento.Show;
    lbParcelamento.Show;
    lblRestante.Show;
    cedRestante.Show;
    lblValorParcela.Show;
    cedValorParcela.Show;
    lblPrimeiroVencimento.Hide;
    dePrimeiroVencimento.Hide;

    if lbParcelamento.ItemIndex = -1 then
      lbParcelamento.Selected[0] := True;

    CalculaValorRestante;
    CalculaValorParcela;
  end
  else
  begin
    lblParcelamento.Hide;
    lbParcelamento.Hide;
    lblRestante.Hide;
    cedRestante.Hide;
    lblValorParcela.Hide;
    cedValorParcela.Hide;
    lblPrimeiroVencimento.Hide;
    dePrimeiroVencimento.Hide;
  end
end;

procedure TFrmFecharVenda.lbFormaPagamentoEnter(Sender: TObject);
begin
  if (Sender as TListBox).ItemIndex = -1  then
    (Sender as TListBox).Selected[0] := True;
  (Sender as TListBox).Color := clMoneyGreen;
end;

procedure TFrmFecharVenda.lbFormaPagamentoExit(Sender: TObject);
begin
  (Sender as TListBox).Color := clWindow;
end;

procedure TFrmFecharVenda.lbParcelamentoClick(Sender: TObject);
begin
  CalculaValorParcela;
end;

end.
