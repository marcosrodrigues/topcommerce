unit uFramePesquisaFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons;

type
  TFramePesquisaFornecedor = class(TFrame)
    Label3: TLabel;
    edtCodigoFornecedor: TEdit;
    bbtConsultarFornecedor: TBitBtn;
    edtNomeFornecedor: TEdit;
    procedure edtCodigoFornecedorExit(Sender: TObject);
    procedure edtCodigoFornecedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bbtConsultarFornecedorClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConsultaFornecedor;
  public
    { Public declarations }
  end;

implementation

uses uFornecedorDAOClient, StringUtils, uFrmPrincipal, uFrmConsultaFornecedor;

{$R *.dfm}

{ TFramePesquisaFornecedor }

procedure TFramePesquisaFornecedor.bbtConsultarFornecedorClick(Sender: TObject);
var
  f: TFrmConsultaFornecedor;
begin
  f := TFrmConsultaFornecedor.Create(Self);
  try
    f.ShowModal;
    if (Assigned(f.Fornecedor)) then
    begin
      edtCodigoFornecedor.Text := f.Fornecedor.Codigo;
      edtNomeFornecedor.Text   := f.Fornecedor.Nome;
    end;
  finally
    f.Free;
  end;
end;

procedure TFramePesquisaFornecedor.ConsultaFornecedor;
var
  DAOClient: TFornecedorDAOClient;
begin
  if (edtCodigoFornecedor.Text <> '') then
  begin
    DAOClient := TFornecedorDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
    try
      edtCodigoFornecedor.Text := StrZero(StrToInt(edtCodigoFornecedor.Text), 3);
      edtNomeFornecedor.Text   := DAOClient.FindByCodigo(edtCodigoFornecedor.Text).Nome;
    finally
      DAOClient.Free;
    end;
  end
  else
    edtNomeFornecedor.Clear;
end;

procedure TFramePesquisaFornecedor.edtCodigoFornecedorExit(Sender: TObject);
begin
  ConsultaFornecedor;
end;

procedure TFramePesquisaFornecedor.edtCodigoFornecedorKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Ord(Key) = 13) then
    ConsultaFornecedor;
end;

end.
