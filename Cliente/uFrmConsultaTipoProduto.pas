unit uFrmConsultaTipoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmConsultaBase, Grids, DBGrids, StdCtrls, ExtCtrls, DB, DBClient,
  uTipoProdutoDAOClient, DBXDBReaders, TipoProduto;

type
  TFrmConsultaTipoProduto = class(TFrmConsultaBase)
    cdsConsultaCODIGO: TStringField;
    cdsConsultaDESCRICAO: TStringField;
  private
    { Private declarations }
    DAOClient: TTipoProdutoDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnListar; override;
    procedure OnConsultar; override;
    procedure OnSelecionar; override;
  public
    { Public declarations }
    TipoProduto: TTipoProduto;
  end;

var
  FrmConsultaTipoProduto: TFrmConsultaTipoProduto;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmConsultaTipoProduto }

procedure TFrmConsultaTipoProduto.OnCreate;
begin
  inherited;
  DAOClient := TTipoProdutoDAOClient.Create(DBXConnection);
end;

procedure TFrmConsultaTipoProduto.OnDestroy;
begin
  inherited;
  DAOClient.Free;
end;

procedure TFrmConsultaTipoProduto.OnListar;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsConsulta);
end;

procedure TFrmConsultaTipoProduto.OnConsultar;
begin
  inherited;
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%');
  cdsConsulta.Filtered := True;
end;

procedure TFrmConsultaTipoProduto.OnSelecionar;
begin
  inherited;
  TipoProduto := TTipoProduto.Create(cdsConsultaCODIGO.AsString,
                                     cdsConsultaDESCRICAO.AsString);
  Self.Close;
end;

end.
