unit uFrmConsultaCargo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmConsultaBase, DB, DBClient, Grids, DBGrids, StdCtrls, ExtCtrls,
  uCargoDAOClient, Cargo;

type
  TFrmConsultaCargo = class(TFrmConsultaBase)
    cdsConsultaID: TIntegerField;
    cdsConsultaDESCRICAO: TStringField;
  private
    { Private declarations }
    DAOClient: TCargoDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnListar; override;
    procedure OnConsultar; override;
    procedure OnSelecionar; override;
  public
    { Public declarations }
    Cargo: TCargo;
  end;

var
  FrmConsultaCargo: TFrmConsultaCargo;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmConsultaCargo }

procedure TFrmConsultaCargo.OnConsultar;
begin
  inherited;
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%');
  cdsConsulta.Filtered := True;
end;

procedure TFrmConsultaCargo.OnCreate;
begin
  inherited;
  DAOClient := TCargoDAOClient.Create(DBXConnection);
end;

procedure TFrmConsultaCargo.OnDestroy;
begin
  inherited;
  DAOClient.Free;
end;

procedure TFrmConsultaCargo.OnListar;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsConsulta);
end;

procedure TFrmConsultaCargo.OnSelecionar;
begin
  inherited;
  Cargo := TCargo.Create(cdsConsultaID.AsInteger,
                         cdsConsultaDESCRICAO.AsString);
  Self.Close;
end;

end.
