unit uFrmContasReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, uFramePesquisaCliente, DB, DBClient, Grids,
  DBGrids, DXPControl, DXPButtons, uContaReceberDAOClient;

type
  TFrmContasReceber = class(TForm)
    Panel1: TPanel;
    Image19: TImage;
    FramePesquisaCliente: TFramePesquisaCliente;
    grdConsulta: TDBGrid;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    Panel2: TPanel;
    btnPesquisar: TDXPButton;
    btnBaixar: TDXPButton;
    cdsRelatorioID: TIntegerField;
    cdsRelatorioCLIENTE_CODIGO: TStringField;
    cdsConsultaNOME: TStringField;
    cdsRelatorioNOME_CLIENTE_AVULSO: TStringField;
    cdsRelatorioVENCIMENTO: TDateTimeField;
    cdsRelatorioVALOR: TCurrencyField;
    cdsRelatorioOBSERVACOES: TStringField;
    cdsConsultaBAIXADA: TBooleanField;
    cdsConsultaRESTANTE: TCurrencyField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Image19Click(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
  private
    { Private declarations }
    ContaReceberDAO: TContaReceberDAOClient;
  public
    { Public declarations }
  end;

var
  FrmContasReceber: TFrmContasReceber;

implementation

uses uFrmPrincipal, DataUtils, uFrmBaixarContaReceber, MensagensUtils;

{$R *.dfm}

procedure TFrmContasReceber.btnBaixarClick(Sender: TObject);
var
  f: TFrmBaixarContaReceber;
begin
  if cdsConsulta.IsEmpty then
  begin
    Atencao('Nenhum conta a receber selecionado.');
    Exit;
  end;

  f := TFrmBaixarContaReceber.Create(Self);
  try
    f.ContaReceberId := cdsRelatorioID.AsInteger;
    f.ValorRestante  := cdsConsultaRESTANTE.AsCurrency;
    f.ValorTotal     := cdsRelatorioVALOR.AsCurrency;
    f.deData.Date    := Now;
    f.cedValor.Value := cdsConsultaRESTANTE.AsCurrency;
    f.ShowModal;

    if f.Baixou then
    begin
      if f.BaixaTotal then
        cdsConsulta.Delete
      else
      begin
        cdsConsulta.Edit;
        cdsConsultaRESTANTE.AsCurrency := cdsConsultaRESTANTE.AsCurrency - f.cedValor.Value;
        cdsConsulta.Post;
      end;
    end;
  finally
    f.Free;
  end;
end;

procedure TFrmContasReceber.btnPesquisarClick(Sender: TObject);
begin
  if FramePesquisaCliente.edtCodigoCliente.Text = '' then
  begin
    Atencao('Nenhum cliente selecionado.');
    Exit;
  end;

  cdsConsulta.Close;
  CopyReaderToClientDataSet(ContaReceberDAO.Relatorio(0, 0, FramePesquisaCliente.edtCodigoCliente.Text, 1), cdsConsulta);
end;

procedure TFrmContasReceber.FormCreate(Sender: TObject);
begin
  ContaReceberDAO := TContaReceberDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
end;

procedure TFrmContasReceber.FormDestroy(Sender: TObject);
begin
  ContaReceberDAO.Free;
end;

procedure TFrmContasReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
  end;
end;

procedure TFrmContasReceber.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

end.
