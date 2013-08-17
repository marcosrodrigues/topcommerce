unit uFrmRelProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, QRCtrls, QuickRpt, ExtCtrls, DB, DBClient, uProdutoDAOClient,
  DBXDBReaders, QRPDFFilt;

type
  TFrmRelProduto = class(TFrmRelBase)
    cdsRelatorioCODIGO: TStringField;
    cdsRelatorioCODIGO_TIPO_PRODUTO: TStringField;
    cdsRelatorioDESCRICAO: TStringField;
    cdsRelatorioCODIGO_BARRAS: TStringField;
    cdsRelatorioPRECO_VENDA: TCurrencyField;
    cdsRelatorioDESCRICAO_TIPO_PRODUTO: TStringField;
    cdsRelatorioPRECO_COMPRA: TCurrencyField;
    QRGroup1: TQRGroup;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel4: TQRLabel;
    QRShape2: TQRShape;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRDBText6: TQRDBText;
    cdsRelatorioNOME_FORNECEDOR: TStringField;
  private
    { Private declarations }
  protected
    procedure OnBeforePrint; override;
  public
    { Public declarations }
    CodigoTipoProduto,
    CodigoFornecedor: string;
    Estoque: Integer;
  end;

var
  FrmRelProduto: TFrmRelProduto;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmRelProduto }

procedure TFrmRelProduto.OnBeforePrint;
var
  DAOClient: TProdutoDAOClient;
begin
  inherited;
  DAOClient := TProdutoDAOClient.Create(DBXConnection);
  try
    CopyReaderToClientDataSet(DAOClient.ListagemProdutos(CodigoTipoProduto,
                                                         CodigoFornecedor,
                                                         Estoque),
                              cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

end.
