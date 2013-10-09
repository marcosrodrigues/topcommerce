unit uFrmInformarCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, DXPControl, DXPButtons, StdCtrls, Cliente;

type
  TFrmInformarCliente = class(TForm)
    Panel1: TPanel;
    Image19: TImage;
    Label5: TLabel;
    edCliente: TEdit;
    btnPesquisarCliente: TDXPButton;
    btnLimpar: TDXPButton;
    btnFechar: TDXPButton;
    procedure btnPesquisarClienteClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Cliente: TCliente;
    NomeCliente: string;
    Salvar: Boolean;
  end;

var
  FrmInformarCliente: TFrmInformarCliente;

implementation

uses uFrmConsultaClientes, MensagensUtils;

{$R *.dfm}

procedure TFrmInformarCliente.btnFecharClick(Sender: TObject);
begin
  if edCliente.Text = '' then
  begin
    Atencao('Informe o cliente da venda. '+#13#10+
            'Um cliente cadastrado ou apenas o nome do cliente.');
    edCliente.SetFocus;
    Exit;
  end;

  NomeCliente := edCliente.Text;
  Salvar := True;
  Close;
end;

procedure TFrmInformarCliente.btnLimparClick(Sender: TObject);
begin
  edCliente.Clear;
  Cliente := nil;
end;

procedure TFrmInformarCliente.btnPesquisarClienteClick(Sender: TObject);
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

procedure TFrmInformarCliente.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if edCliente.Text = '' then
  begin
    Atencao('Informe o cliente da venda. '+#13#10+
            'Um cliente cadastrado ou apenas o nome do cliente.');
    edCliente.SetFocus;
    CanClose := False;
  end;
end;

procedure TFrmInformarCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
  begin
    if (Self.ActiveControl = edCliente) then
      btnFechar.SetFocus;
  end;
end;

procedure TFrmInformarCliente.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

end.
