unit uFrmRelFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmRelBase, ExtCtrls, uFornecedorDAOClient, DB, DBClient,
  DBXDBReaders, RLReport, RLFilters, RLPDFFilter, pngimage;

type
  TFrmRelFornecedor = class(TFrmRelBase)
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
