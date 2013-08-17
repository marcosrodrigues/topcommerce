unit uFrmConsultaFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmConsultaBase, DB, DBClient, Grids, DBGrids, StdCtrls, ExtCtrls,
  uFornecedorDAOClient, DBXDBReaders, Fornecedor;

type
  TFrmConsultaFornecedor = class(TFrmConsultaBase)
    cdsConsultaCODIGO: TStringField;
    cdsConsultaNOME: TStringField;
    cdsConsultaTELEFONE: TStringField;
  private
    { Private declarations }
    DAOClient: TFornecedorDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnListar; override;
    procedure OnConsultar; override;
    procedure OnSelecionar; override;
  public
    { Public declarations }
    Fornecedor: TFornecedor;
  end;

var
  FrmConsultaFornecedor: TFrmConsultaFornecedor;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmConsultaFornecedor }

procedure TFrmConsultaFornecedor.OnCreate;
begin
  inherited;
  DAOClient := TFornecedorDAOClient.Create(DBXConnection);
end;

procedure TFrmConsultaFornecedor.OnDestroy;
begin
  inherited;
  DAOClient.Free;
end;

procedure TFrmConsultaFornecedor.OnListar;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsConsulta);
end;

procedure TFrmConsultaFornecedor.OnConsultar;
begin
  inherited;
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%');
  cdsConsulta.Filtered := True;
end;

procedure TFrmConsultaFornecedor.OnSelecionar;
begin
  inherited;
  Fornecedor := TFornecedor.Create(cdsConsultaCODIGO.AsString,
                                   cdsConsultaNOME.AsString,
                                   cdsConsultaTELEFONE.AsString);
  Self.Close;
end;

end.
