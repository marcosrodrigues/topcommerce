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
  private
    { Private declarations }
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

end.
