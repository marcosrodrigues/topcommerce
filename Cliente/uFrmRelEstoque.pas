unit uFrmRelEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, QRPDFFilt, DB, DBClient, QRCtrls, QuickRpt, ExtCtrls,
  uEstoqueDAOClient, DBXDBReaders;

type
  TFrmRelEstoque = class(TFrmRelBase)
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape2: TQRShape;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    cdsRelatorioCODIGO_PRODUTO: TStringField;
    cdsRelatorioDESCRICAO_PRODUTO: TStringField;
    cdsRelatorioQUANTIDADE: TIntegerField;
    cdsRelatorioPRECO_COMPRA: TCurrencyField;
    QRLabel4: TQRLabel;
    QRDBText4: TQRDBText;
    QRLabel5: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand3: TQRBand;
    QRShape3: TQRShape;
    QRExpr2: TQRExpr;
    QRExpr3: TQRExpr;
    QRExpr4: TQRExpr;
    QRLabel6: TQRLabel;
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
