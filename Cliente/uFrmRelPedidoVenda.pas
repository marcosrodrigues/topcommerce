unit uFrmRelPedidoVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, DB, DBClient, ExtCtrls, uPedidoVendaDAOClient,
  DBXDBReaders, RLReport, pngimage, RLFilters, RLPDFFilter, jpeg;

type
  TFrmRelPedidoVenda = class(TFrmRelBase)
    cdsRelatorioCODIGO: TStringField;
    cdsRelatorioCODIGO_PRODUTO: TStringField;
    cdsRelatorioQUANTIDADE: TIntegerField;
    cdsRelatorioDESCRICAO: TStringField;
    cdsRelatorioVALOR: TCurrencyField;
    cdsRelatorioDATA: TSQLTimeStampField;
    cdsRelatorioDESCONTO: TCurrencyField;
    cdsRelatorioTIPO_PAGAMENTO: TIntegerField;
    cdsRelatorioCODIGO_CLIENTE: TStringField;
    cdsRelatorioNOME_CLIENTE_AVULSO: TStringField;
    cdsRelatorioNOME: TStringField;
    RLGroup1: TRLGroup;
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    RLBand3: TRLBand;
    RLDBText2: TRLDBText;
    RLLabel3: TRLLabel;
    RLDBText3: TRLDBText;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel8: TRLLabel;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLLabel10: TRLLabel;
    RLDBText7: TRLDBText;
    RLLabel11: TRLLabel;
    RLDBText8: TRLDBText;
    cdsRelatorioVENDA_DESCONTO_PERCENTUAL: TCurrencyField;
    cdsRelatorioTOTAL: TCurrencyField;
    cdsRelatorioRECEBIDO: TCurrencyField;
    cdsRelatorioTROCO: TCurrencyField;
    cdsRelatorioLOGIN_USUARIO: TStringField;
    cdsRelatorioITEM_DESCONTO_VALOR: TCurrencyField;
    cdsRelatorioITEM_DESCONTO_PERCENTUAL: TCurrencyField;
    RLLabel12: TRLLabel;
    RLDBText9: TRLDBText;
    RLLabel13: TRLLabel;
    RLDBText10: TRLDBText;
    RLLabel14: TRLLabel;
    RLDBText11: TRLDBText;
    RLLabel15: TRLLabel;
    RLDBText12: TRLDBText;
    RLLabel16: TRLLabel;
    RLDBText13: TRLDBText;
    RLBand4: TRLBand;
    cdsRelatorioPRECO_VENDA: TCurrencyField;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLPanel1: TRLPanel;
    RLDBText14: TRLDBText;
    RLBand6: TRLBand;
    rlbTotalVendas: TRLLabel;
    procedure cdsRelatorioTIPO_PAGAMENTOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsRelatorioNOMEGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure RLDBText7BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText8BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLDBText10BeforePrint(Sender: TObject; var Text: string;
      var PrintIt: Boolean);
    procedure RLReportBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand6BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBand2BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
    TotalVendas: Currency;
  protected
    procedure OnBeforePrint; override;
  public
    { Public declarations }
    DataInicial, DataFinal: TDateTime;
    TipoPagamento: Integer;
    ClienteCodigo: string;
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
    1: Text := 'Cart�o de Cr�dito';
    2: Text := 'Cart�o de D�bito';
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
    CopyReaderToClientDataSet(DAOClient.RelatorioPedidosVenda(DataInicial, DataFinal, TipoPagamento, ClienteCodigo), cdsRelatorio);
  finally
    DAOClient.Free;
  end;
end;

procedure TFrmRelPedidoVenda.RLBand2BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  TotalVendas := TotalVendas + cdsRelatorioTOTAL.AsCurrency;
end;

procedure TFrmRelPedidoVenda.RLBand6BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  rlbTotalVendas.Caption := 'R$ '+FormatCurr(',0.00', TotalVendas);
end;

procedure TFrmRelPedidoVenda.RLDBText10BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  Text := Text + ' %';
end;

procedure TFrmRelPedidoVenda.RLDBText7BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  if cdsRelatorioNOME.IsNull then
    Text := cdsRelatorioNOME_CLIENTE_AVULSO.AsString
  else
    Text := cdsRelatorioNOME.AsString;
end;

procedure TFrmRelPedidoVenda.RLDBText8BeforePrint(Sender: TObject;
  var Text: string; var PrintIt: Boolean);
begin
  inherited;
  case cdsRelatorioTIPO_PAGAMENTO.AsInteger of
    0: Text := 'Dinheiro';
    1: Text := 'Credi�rio';
    2: Text := 'Cart�o de Cr�dito';
    3: Text := 'Cart�o de D�bito';
    4: Text := 'Cheque';
  end;
end;

procedure TFrmRelPedidoVenda.RLReportBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;
  TotalVendas := 0;
end;

end.
