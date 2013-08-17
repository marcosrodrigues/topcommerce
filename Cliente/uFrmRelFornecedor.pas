unit uFrmRelFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, QRCtrls, QuickRpt, ExtCtrls, uFornecedorDAOClient, DB, DBClient,
  DBXDBReaders, QRPDFFilt;

type
  TFrmRelFornecedor = class(TFrmRelBase)
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRShape2: TQRShape;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    cdsRelatorioCODIGO: TStringField;
    cdsRelatorioNOME: TStringField;
    cdsRelatorioTELEFONE: TStringField;
  private
    { Private declarations }
  protected
    procedure OnBeforePrint; override;
  public
    { Public declarations }
    CodigoProduto: string;
  end;

var
  FrmRelFornecedor: TFrmRelFornecedor;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmRelFornecedor }

procedure TFrmRelFornecedor.OnBeforePrint;
var
  DAOClient: TFornecedorDAOClient;
begin
  inherited;
  DAOClient := TFornecedorDAOClient.Create(DBXConnection);
  try
    CopyReaderToClientDataSet(DAOClient.ListagemFornecedores(CodigoProduto), cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

end.
