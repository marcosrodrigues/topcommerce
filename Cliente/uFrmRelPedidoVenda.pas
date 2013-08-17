unit uFrmRelPedidoVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, DB, DBClient, QRCtrls, QuickRpt, ExtCtrls, uPedidoVendaDAOClient,
  DBXDBReaders, QRPDFFilt;

type
  TFrmRelPedidoVenda = class(TFrmRelBase)
    cdsRelatorioCODIGO: TStringField;
    cdsRelatorioCODIGO_PRODUTO: TStringField;
    cdsRelatorioQUANTIDADE: TIntegerField;
    cdsRelatorioDESCRICAO: TStringField;
    cdsRelatorioPRECO_VENDA: TCurrencyField;
    qrbGroup: TQRGroup;
    QRBand2: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    cdsRelatorioDATA: TSQLTimeStampField;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBText3: TQRDBText;
    QRShape2: TQRShape;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRExpr1: TQRExpr;
    QRBand3: TQRBand;
    qrlTotal: TQRLabel;
    QRShape3: TQRShape;
    QRLabel8: TQRLabel;
    QRBand4: TQRBand;
    QRShape4: TQRShape;
    QRLabel9: TQRLabel;
    qrlTotalGeral: TQRLabel;
    cdsRelatorioDESCONTO: TCurrencyField;
    cdsRelatorioTIPO_PAGAMENTO: TIntegerField;
    QRLabel10: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel11: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel12: TQRLabel;
    qrlTotalDesconto: TQRLabel;
    cdsRelatorioCODIGO_CLIENTE: TStringField;
    cdsRelatorioNOME_CLIENTE_AVULSO: TStringField;
    QRLabel13: TQRLabel;
    QRDBText9: TQRDBText;
    cdsRelatorioNOME: TStringField;
    procedure qrbGroupBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure cdsRelatorioTIPO_PAGAMENTOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsRelatorioNOMEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
    Total, TotalGeral, TotalDesconto: Currency;
  protected
    procedure OnBeforePrint; override;
  public
    { Public declarations }
    DataInicial, DataFinal: TDateTime;
  end;

var
  FrmRelPedidoVenda: TFrmRelPedidoVenda;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmRelPedidoVenda }

procedure TFrmRelPedidoVenda.cdsRelatorioNOMEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsString = '' then
    Text := cdsRelatorioNOME_CLIENTE_AVULSO.AsString
  else
    Text := Sender.AsString;
end;

procedure TFrmRelPedidoVenda.cdsRelatorioTIPO_PAGAMENTOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  case Sender.AsInteger of
    0: Text := 'Dinheiro';
    1: Text := 'Cartão de Crédito';
    2: Text := 'Cartão de Débito';
    3: Text := 'Cheque';
  end;
end;

procedure TFrmRelPedidoVenda.OnBeforePrint;
var
  DAOClient: TPedidoVendaDAOClient;
begin
  inherited;
  DAOClient := TPedidoVendaDAOClient.Create(DBXConnection);
  try
    CopyReaderToClientDataSet(DAOClient.RelatorioPedidosVenda(DataInicial, DataFinal), cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

procedure TFrmRelPedidoVenda.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  Total      := Total + (cdsRelatorioQUANTIDADE.AsInteger * cdsRelatorioPRECO_VENDA.AsCurrency);
  TotalGeral := TotalGeral + (cdsRelatorioQUANTIDADE.AsInteger * cdsRelatorioPRECO_VENDA.AsCurrency);
end;

procedure TFrmRelPedidoVenda.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  qrlTotal.Caption := FormatCurr('R$ ,0.00', Total - cdsRelatorioDESCONTO.AsCurrency);
  TotalDesconto    := TotalDesconto + cdsRelatorioDESCONTO.AsCurrency;
end;

procedure TFrmRelPedidoVenda.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  qrlTotalDesconto.Caption := FormatCurr('R$ ,0.00', TotalDesconto);
  qrlTotalGeral.Caption    := FormatCurr('R$ ,0.00', TotalGeral - TotalDesconto);
end;

procedure TFrmRelPedidoVenda.qrbGroupBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  Total := 0;
end;

procedure TFrmRelPedidoVenda.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  TotalDesconto := 0;
  TotalGeral    := 0;
end;

end.
