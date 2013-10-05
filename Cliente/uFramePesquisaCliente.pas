unit uFramePesquisaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons;

type
  TFramePesquisaCliente = class(TFrame)
    Label3: TLabel;
    edtCodigoCliente: TEdit;
    bbtConsultarCliente: TBitBtn;
    edtNomeCliente: TEdit;
    procedure bbtConsultarClienteClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure ConsultaCliente;
  public
    { Public declarations }
  end;

implementation

uses uClienteDAOClient, uFrmPrincipal, StringUtils, uFrmConsultaCliente;

{$R *.dfm}

procedure TFramePesquisaCliente.bbtConsultarClienteClick(Sender: TObject);
var
  f: TFrmConsultaCliente;
begin
  f := TFrmConsultaCliente.Create(Self);
  try
    f.ShowModal;
    if (Assigned(f.Cliente)) then
    begin
      edtCodigoCliente.Text := f.Cliente.Codigo;
      edtNomeCliente.Text   := f.Cliente.Nome;
    end;
  finally
    f.Free;
  end;
end;

procedure TFramePesquisaCliente.ConsultaCliente;
var
  DAOClient: TClienteDAOClient;
begin
  if (edtCodigoCliente.Text <> '') then
  begin
    DAOClient := TClienteDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
    try
      edtCodigoCliente.Text := StrZero(StrToInt(edtCodigoCliente.Text), 6);
      edtNomeCliente.Text   := DAOClient.FindByCodigo(edtCodigoCliente.Text).Nome;
    finally
      DAOClient.Free;
    end;
  end
  else
    edtNomeCliente.Clear;
end;

procedure TFramePesquisaCliente.edtCodigoClienteExit(Sender: TObject);
begin
  ConsultaCliente;
end;

procedure TFramePesquisaCliente.edtCodigoClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Ord(Key) = 13) then
    ConsultaCliente;
end;

end.
