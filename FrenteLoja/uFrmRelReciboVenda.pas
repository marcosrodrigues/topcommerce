unit uFrmRelReciboVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, RLFilters, RLPDFFilter, DB, DBClient, pngimage, RLReport,
  uPedidoVendaDAOClient, jpeg;

type
  TFrmRelReciboVenda = class(TFrmRelBase)
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    cdsRelatorioCODIGO: TStringField;
    cdsRelatorioDATA: TSQLTimeStampField;
    cdsRelatorioDESCONTO: TCurrencyField;
    cdsRelatorioCODIGO_CLIENTE: TStringField;
    cdsRelatorioNOME_CLIENTE_AVULSO: TStringField;
    cdsRelatorioCODIGO_PRODUTO: TStringField;
    cdsRelatorioQUANTIDADE: TIntegerField;
    cdsRelatorioDESCRICAO: TStringField;
    cdsRelatorioVALOR: TCurrencyField;
    cdsRelatorioVENDA_DESCONTO_PERCENTUAL: TCurrencyField;
    cdsRelatorioTOTAL: TCurrencyField;
    cdsRelatorioRECEBIDO: TCurrencyField;
    cdsRelatorioTROCO: TCurrencyField;
    cdsRelatorioLOGIN_USUARIO: TStringField;
    cdsRelatorioITEM_DESCONTO_VALOR: TCurrencyField;
    cdsRelatorioITEM_DESCONTO_PERCENTUAL: TCurrencyField;
    cdsRelatorioTIPO_PAGAMENTO: TIntegerField;
    cdsRelatorioNOME: TStringField;
    cdsRelatorioPRECO_VENDA: TCurrencyField;
    RLLabel3: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel4: TRLLabel;
    RLDBText1: TRLDBText;
    RLLabel12: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText10: TRLDBText;
    RLDBText13: TRLDBText;
    RLLabel16: TRLLabel;
    RLDBText12: TRLDBText;
    RLLabel15: TRLLabel;
    RLDBText4: TRLDBText;
    RLLabel5: TRLLabel;
    RLDBText11: TRLDBText;
    RLLabel7: TRLLabel;
    RLLabel14: TRLLabel;
    RLDBText14: TRLDBText;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel19: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText8: TRLDBText;
    rlbTotalVenda: TRLLabel;
    procedure rlbClienteBeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText3BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText9BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText4BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText10BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLBand4BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
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

procedure TFrmRelReciboVenda.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  TotalVenda := cdsRelatorioTOTAL.AsCurrency;
end;

procedure TFrmRelReciboVenda.RLBand4BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  rlbTotalVenda.Caption := 'R$ '+FormatCurr(',0.00', TotalVenda);
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

procedure TFrmRelReciboVenda.RLDBText10BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := Text + ' %';
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

procedure TFrmRelReciboVenda.RLDBText4BeforePrint(Sender: TObject;
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

procedure TFrmRelReciboVenda.RLDBText9BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  if cdsRelatorioNOME.IsNull then
    Text := cdsRelatorioNOME_CLIENTE_AVULSO.AsString
  else
    Text := cdsRelatorioNOME.AsString;
end;

end.
