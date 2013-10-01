unit uFrmRelEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, DB, DBClient, ExtCtrls,
  uEstoqueDAOClient, DBXDBReaders, RLReport, pngimage, RLFilters, RLPDFFilter,
  jpeg;

type
  TFrmRelEstoque = class(TFrmRelBase)
    cdsRelatorioCODIGO_PRODUTO: TStringField;
    cdsRelatorioDESCRICAO_PRODUTO: TStringField;
    cdsRelatorioQUANTIDADE: TIntegerField;
    cdsRelatorioPRECO_COMPRA: TCurrencyField;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    cdsRelatorioESTOQUE_MINIMO: TIntegerField;
    RLLabel8: TRLLabel;
    RLDBText5: TRLDBText;
    RLBand4: TRLBand;
    RLLabel9: TRLLabel;
  private
    { Private declarations }
  protected
    procedure OnBeforePrint; override;
  public
    { Public declarations }
    Estoque: Integer;
  end;

var
  FrmRelEstoque: TFrmRelEstoque;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmRelEstoque }

procedure TFrmRelEstoque.OnBeforePrint;
var
  DAOClient: TEstoqueDAOClient;
begin
  inherited;
  DAOClient := TEstoqueDAOClient.Create(DBXConnection);
  try
    CopyReaderToClientDataSet(DAOClient.RelatorioEstoque(Estoque), cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

end.
