unit uFrmRelEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, DB, DBClient, ExtCtrls,
  uEstoqueDAOClient, DBXDBReaders, RLReport, pngimage, RLFilters, RLPDFFilter;

type
  TFrmRelEstoque = class(TFrmRelBase)
    cdsRelatorioCODIGO_PRODUTO: TStringField;
    cdsRelatorioDESCRICAO_PRODUTO: TStringField;
    cdsRelatorioQUANTIDADE: TIntegerField;
    cdsRelatorioPRECO_COMPRA: TCurrencyField;
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
