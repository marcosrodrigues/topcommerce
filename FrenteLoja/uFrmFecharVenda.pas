unit uFrmFecharVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Mask, DXPControl,
  DXPButtons, Cliente;

type
  TFrmFecharVenda = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    edtTotal: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    cbFormaPagamento: TComboBox;
    Label5: TLabel;
    edCliente: TEdit;
    btnPesquisarCliente: TDXPButton;
    btnLimpar: TDXPButton;
    btnFechar: TDXPButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cedDescontoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure cbFormaPagamentoChange(Sender: TObject);
  private
    { Private declarations }
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

uses uFrmConsultaClientes;

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
    end;
  finally
    fConsultaClientes.Free;
  end;
end;

procedure TFrmFecharVenda.cbFormaPagamentoChange(Sender: TObject);
begin
  edCliente.Enabled := cbFormaPagamento.ItemIndex <> 1;
end;

procedure TFrmFecharVenda.cedDescontoExit(Sender: TObject);
begin
  if (0{ TODO : cedDesconto.Value } = 0) then
    edtTotal.Text := FormatCurr(',0.00', Total)
  else
    edtTotal.Text := FormatCurr(',0.00', Total - 0{ TODO : cedDesconto.Value });
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
    if (Self.ActiveControl = nil{ TODO : cedDesconto }) then
      cbFormaPagamento.SetFocus
    else if (Self.ActiveControl = cbFormaPagamento) then
      btnPesquisarCliente.SetFocus;
  end;
end;

end.
