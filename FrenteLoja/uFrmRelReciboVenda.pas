unit uFrmRelReciboVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, RLFilters, RLPDFFilter, DB, DBClient, pngimage, RLReport,
  uPedidoVendaDAOClient;

type
  TFrmRelReciboVenda = class(TFrmRelBase)
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    cdsRelatorioQUANTIDADE: TIntegerField;
    cdsRelatorioDESCRICAO: TStringField;
    cdsRelatorioPRECO_VENDA: TCurrencyField;
    cdsRelatorioDATA: TDateTimeField;
    cdsRelatorioDESCONTO: TCurrencyField;
    cdsRelatorioTIPO_PAGAMENTO: TIntegerField;
    cdsRelatorioNOME_CLIENTE_AVULSO: TStringField;
    cdsRelatorioNOME: TStringField;
    RLBand3: TRLBand;
    RLDBText2: TRLDBText;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    rlbCliente: TRLLabel;
    RLLabel5: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel7: TRLLabel;
    RLDBText4: TRLDBText;
    RLPanel1: TRLPanel;
    RLPanel2: TRLPanel;
    RLPanel3: TRLPanel;
    RLPanel4: TRLPanel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    rlbTotal: TRLLabel;
    RLBand4: TRLBand;
    RLLabel13: TRLLabel;
    rlbTotalVenda: TRLLabel;
    RLBand5: TRLBand;
    RLLabel12: TRLLabel;
    procedure rlbClienteBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure rlbTotalBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLReportBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
    TotalVenda: Currency;
  protected
    procedure OnBeforePrint; override;
  public
    { Public declarations }
    CodigoVenda: string;
  end;

var
  FrmRelReciboVenda: TFrmRelReciboVenda;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmRelReciboVenda }

procedure TFrmRelReciboVenda.OnBeforePrint;
var
  DAOClient: TPedidoVendaDAOClient;
begin
  inherited;
  DAOClient := TPedidoVendaDAOClient.Create(DBXConnection);
  try
    CopyReaderToClientDataSet(DAOClient.Recibo(CodigoVenda),
                              cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

procedure TFrmRelReciboVenda.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  TotalVenda := TotalVenda + (cdsRelatorioPRECO_VENDA.AsCurrency * cdsRelatorioQUANTIDADE.AsInteger);
end;

procedure TFrmRelReciboVenda.RLBand4BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  rlbTotalVenda.Caption := FormatCurr(',0.00', TotalVenda - cdsRelatorioDESCONTO.AsCurrency);
end;

procedure TFrmRelReciboVenda.rlbClienteBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  if cdsRelatorioNOME_CLIENTE_AVULSO.AsString = '' then
    Text := cdsRelatorioNOME.AsString
  else
    Text := cdsRelatorioNOME_CLIENTE_AVULSO.AsString;
end;

procedure TFrmRelReciboVenda.RLDBText3BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  case cdsRelatorioTIPO_PAGAMENTO.AsInteger of
    0: Text := 'Dinheiro';
    1: Text := 'Crediário';
    2: Text := 'Cartão de Crédito';
    3: Text := 'Cartão de Débito';
    4: Text := 'Cheque';
  end;
end;

procedure TFrmRelReciboVenda.RLReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  TotalVenda := 0;
end;

procedure TFrmRelReciboVenda.rlbTotalBeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := FormatCurr(',0.00', cdsRelatorioPRECO_VENDA.AsCurrency * cdsRelatorioQUANTIDADE.AsInteger);
end;

end.
