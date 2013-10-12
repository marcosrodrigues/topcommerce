unit uFrmRelContasPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, RLFilters, RLPDFFilter, DB, DBClient, jpeg, RLReport, StrUtils;

type
  TFrmRelContasPagar = class(TFrmRelBase)
    cdsRelatorioID: TIntegerField;
    cdsRelatorioFORNECEDOR_CODIGO: TStringField;
    cdsRelatorioNOME: TStringField;
    cdsRelatorioVENCIMENTO: TDateTimeField;
    cdsRelatorioVALOR: TCurrencyField;
    cdsRelatorioOBSERVACOES: TStringField;
    cdsRelatorioBAIXADA: TBooleanField;
    RLBand2: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
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
    FornecedorCodigo: string;
    Situacao: Integer;
  end;

var
  FrmRelContasPagar: TFrmRelContasPagar;

implementation

uses uContaPagarDAOClient, DataUtils;

{$R *.dfm}

procedure TFrmRelContasPagar.cdsRelatorioBAIXADAGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := IfThen(Sender.AsBoolean, 'Sim', 'Não');
end;

procedure TFrmRelContasPagar.cdsRelatorioNOMEGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  inherited;
  Text := cdsRelatorioFORNECEDOR_CODIGO.AsString + ' - ' + cdsRelatorioNOME.AsString;
end;

procedure TFrmRelContasPagar.OnBeforePrint;
var
  DAOClient: TContaPagarDAOClient;
begin
  inherited;
  DAOClient := TContaPagarDAOClient.Create(DBXConnection);
  try
    CopyReaderToClientDataSet(DAOClient.Relatorio(DataInicial, DataFinal, FornecedorCodigo, Situacao), cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

end.
