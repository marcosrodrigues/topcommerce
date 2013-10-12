unit uFrmRelContasReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, RLFilters, RLPDFFilter, DB, DBClient, jpeg, RLReport, StrUtils;

type
  TFrmRelContasReceber = class(TFrmRelBase)
    RLBand2: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    cdsRelatorioID: TIntegerField;
    cdsRelatorioCLIENTE_CODIGO: TStringField;
    cdsRelatorioNOME: TStringField;
    cdsRelatorioNOME_CLIENTE_AVULSO: TStringField;
    cdsRelatorioVENCIMENTO: TDateTimeField;
    cdsRelatorioVALOR: TCurrencyField;
    cdsRelatorioOBSERVACOES: TStringField;
    cdsRelatorioBAIXADA: TBooleanField;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLBand4: TRLBand;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLLabel9: TRLLabel;
    procedure cdsRelatorioNOMEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsRelatorioBAIXADAGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
  protected
    procedure OnBeforePrint; override;
  public
    { Public declarations }
    DataInicial, DataFinal: TDateTime;
    ClienteCodigo: string;
    Situacao: Integer;
  end;

var
  FrmRelContasReceber: TFrmRelContasReceber;

implementation

uses uContaReceberDAOClient, DataUtils;

{$R *.dfm}

procedure TFrmRelContasReceber.cdsRelatorioBAIXADAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := IfThen(cdsRelatorioBAIXADA.AsBoolean, 'Sim', 'Não');
end;

procedure TFrmRelContasReceber.cdsRelatorioNOMEGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  inherited;
  if cdsRelatorioNOME_CLIENTE_AVULSO.AsString = '' then
    Text := cdsRelatorioCLIENTE_CODIGO.AsString + ' - ' + cdsRelatorioNOME.AsString
  else
    Text := cdsRelatorioNOME_CLIENTE_AVULSO.AsString;
end;

procedure TFrmRelContasReceber.OnBeforePrint;
var
  DAOClient: TContaReceberDAOClient;
begin
  inherited;
  DAOClient := TContaReceberDAOClient.Create(DBXConnection);
  try
    CopyReaderToClientDataSet(DAOClient.Relatorio(DataInicial, DataFinal, ClienteCodigo, Situacao), cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

end.
