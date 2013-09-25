unit uFrmFecharVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, DXPControl,
  DXPButtons, Cliente, DXPCurrencyEdit, pngimage;

type
  TFrmFecharVenda = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    cbFormaPagamento: TComboBox;
    Label5: TLabel;
    edCliente: TEdit;
    btnPesquisarCliente: TDXPButton;
    btnLimpar: TDXPButton;
    btnFechar: TDXPButton;
    cedDescontoValor: TDXPCurrencyEdit;
    Label6: TLabel;
    cedDescontoPercentual: TDXPCurrencyEdit;
    cedTotal: TDXPCurrencyEdit;
    Label7: TLabel;
    cedValorRecebido: TDXPCurrencyEdit;
    Label8: TLabel;
    cedTroco: TDXPCurrencyEdit;
    Image19: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cedDescontoValorExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure cbFormaPagamentoChange(Sender: TObject);
    procedure cedDescontoPercentualExit(Sender: TObject);
    procedure cedValorRecebidoExit(Sender: TObject);
    procedure Image19Click(Sender: TObject);
  private
    { Private declarations }
    procedure CalcularTotal;
  public
    { Public declarations }
    Total: Currency;
    Fechar: Boolean;
    Cliente: TCliente;
    NomeCliente: string;
  end;

var
  FrmFecharVenda: TFrmFecharVenda;

implementation

uses uFrmConsultaClientes, MensagensUtils;

{$R *.dfm}

procedure TFrmFecharVenda.btnFecharClick(Sender: TObject);
begin
  NomeCliente := edCliente.Text;
  Fechar := True;
  Close;
end;

procedure TFrmFecharVenda.btnLimparClick(Sender: TObject);
begin
  edCliente.Clear;
  Cliente := nil;
end;

procedure TFrmFecharVenda.btnPesquisarClienteClick(Sender: TObject);
var
  fConsultaClientes: TFrmConsultaClientes;
begin
  fConsultaClientes := TFrmConsultaClientes.Create(Self);
  try
    fConsultaClientes.ShowModal;
    if Assigned(fConsultaClientes.Cliente) then
    begin
      Cliente := TCliente.Create(fConsultaClientes.Cliente.Codigo, fConsultaClientes.Cliente.Nome, fConsultaClientes.Cliente.Telefone);

      edCliente.Text := Cliente.Nome;

      btnFechar.SetFocus;
    end;
  finally
    fConsultaClientes.Free;
  end;
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

procedure TFrmFecharVenda.cbFormaPagamentoChange(Sender: TObject);
begin
  edCliente.Enabled := cbFormaPagamento.ItemIndex <> 1;
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
      cbFormaPagamento.SetFocus
    else if (Self.ActiveControl = cbFormaPagamento) then
      btnPesquisarCliente.SetFocus;
  end;
end;

procedure TFrmFecharVenda.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

end.
