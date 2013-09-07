unit uFrmRelPedidoVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, DB, DBClient, ExtCtrls, uPedidoVendaDAOClient,
  DBXDBReaders, RLReport, pngimage, RLFilters, RLPDFFilter;

type
  TFrmRelPedidoVenda = class(TFrmRelBase)
    cdsRelatorioCODIGO: TStringField;
    cdsRelatorioCODIGO_PRODUTO: TStringField;
    cdsRelatorioQUANTIDADE: TIntegerField;
    cdsRelatorioDESCRICAO: TStringField;
    cdsRelatorioPRECO_VENDA: TCurrencyField;
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

end.
