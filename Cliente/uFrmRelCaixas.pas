unit uFrmRelCaixas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, RLFilters, RLPDFFilter, DB, DBClient, pngimage, RLReport;

type
  TFrmRelCaixas = class(TFrmRelBase)
    cdsRelatorioID: TIntegerField;
    cdsRelatorioDATA: TDateTimeField;
    cdsRelatorioFECHADO: TBooleanField;
    cdsRelatorioVALOR_ABERTURA: TCurrencyField;
    cdsRelatorioORIGEM: TIntegerField;
    cdsRelatorioVALOR: TCurrencyField;
    cdsRelatorioOPERACAO: TIntegerField;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel5: TRLLabel;
    RLDBText4: TRLDBText;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLBand4: TRLBand;
    rlbTotal: TRLLabel;
    RLLabel10: TRLLabel;
    procedure cdsRelatorioORIGEMGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsRelatorioOPERACAOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure RLGroup1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
    TotalCaixa: Currency;
  protected
    procedure OnBeforePrint; override;
  public
    { Public declarations }
    DataInicial, DataFinal: TDateTime;
  end;

var
  FrmRelCaixas: TFrmRelCaixas;

implementation

uses uCaixaDAOClient, DataUtils;

{$R *.dfm}

{ TFrmRelCaixas }

procedure TFrmRelCaixas.cdsRelatorioOPERACAOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  case Sender.AsInteger of
    1: Text := 'Entrada';
  end;
end;

procedure TFrmRelCaixas.cdsRelatorioORIGEMGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  case Sender.AsInteger of
    1: Text := 'Caixa';
  end;
end;

procedure TFrmRelCaixas.OnBeforePrint;
var
  DAOClient: TCaixaDAOClient;
begin
  inherited;
  DAOClient := TCaixaDAOClient.Create(DBXConnection);
  try
    CopyReaderToClientDataSet(DAOClient.Relatorio(DataInicial, DataFinal), cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

procedure TFrmRelCaixas.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  TotalCaixa := TotalCaixa + cdsRelatorioVALOR.AsCurrency;
end;

procedure TFrmRelCaixas.RLBand4BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  rlbTotal.Caption := FormatCurr(',0.00', TotalCaixa);
end;

procedure TFrmRelCaixas.RLGroup1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  TotalCaixa := 0;
end;

end.
