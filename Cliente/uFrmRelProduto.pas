unit uFrmRelProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, ExtCtrls, DB, DBClient, uProdutoDAOClient,
  DBXDBReaders, RLReport, pngimage, RLFilters, RLPDFFilter, jpeg;

type
  TFrmRelProduto = class(TFrmRelBase)
    cdsRelatorioCODIGO: TStringField;
    cdsRelatorioCODIGO_TIPO_PRODUTO: TStringField;
    cdsRelatorioDESCRICAO: TStringField;
    cdsRelatorioCODIGO_BARRAS: TStringField;
    cdsRelatorioPRECO_VENDA: TCurrencyField;
    cdsRelatorioDESCRICAO_TIPO_PRODUTO: TStringField;
    cdsRelatorioPRECO_COMPRA: TCurrencyField;
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
