unit uFrmConsultaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmConsultaBase, DB, DBClient, Grids, DBGrids, StdCtrls, ExtCtrls,
  uProdutoDAOClient, DBXDBReaders, Produto;

type
  TFrmConsultaProduto = class(TFrmConsultaBase)
    cdsConsultaCODIGO: TStringField;
    cdsConsultaDESCRICAO: TStringField;
    cdsConsultaCODIGO_TIPO_PRODUTO: TStringField;
    cdsConsultaDESCRICAO_TIPO_PRODUTO: TStringField;
    cdsConsultaPRECO_VENDA: TCurrencyField;
    cdsConsultaCODIGO_BARRAS: TStringField;
    cdsConsultaQUANTIDADE: TIntegerField;
    cdsConsultaENDERECO: TStringField;
    cdsConsultaMARGEM_LUCRO: TCurrencyField;
    cdsConsultaDESCONTO_MAXIMO_VALOR: TCurrencyField;
    cdsConsultaDESCONTO_MAXIMO_PERCENTUAL: TCurrencyField;
    cdsConsultaESTOQUE_MINIMO: TIntegerField;
  private
    { Private declarations }
    DAOClient: TProdutoDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnListar; override;
    procedure OnConsultar; override;
    procedure OnSelecionar; override;
  public
    { Public declarations }
    Produto: TProduto;
  end;

var
  FrmConsultaProduto: TFrmConsultaProduto;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmConsultaProduto }

procedure TFrmConsultaProduto.OnCreate;
begin
  inherited;
  DAOClient := TProdutoDAOClient.Create(DBXConnection);
end;

procedure TFrmConsultaProduto.OnDestroy;
begin
  inherited;
  DAOClient.Free;
end;

procedure TFrmConsultaProduto.OnListar;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsConsulta);
end;

procedure TFrmConsultaProduto.OnConsultar;
begin
  inherited;
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%');
  cdsConsulta.Filtered := True;
end;

procedure TFrmConsultaProduto.OnSelecionar;
begin
  inherited;
  Produto := TProduto.Create(cdsConsultaCODIGO.AsString,
                             nil,
                             cdsConsultaDESCRICAO.AsString,
                             '',
                             0,
                             0,
                             nil,
                             nil,
                             '',
                             0,
                             0,
                             0);
  Self.Close;
end;

end.
