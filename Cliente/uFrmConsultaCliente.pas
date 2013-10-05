unit uFrmConsultaCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmConsultaBase, DB, DBClient, Grids, DBGrids, StdCtrls, ExtCtrls,
  uClienteDAOClient, Cliente;

type
  TFrmConsultaCliente = class(TFrmConsultaBase)
    cdsConsultaCODIGO: TStringField;
    cdsConsultaNOME: TStringField;
    cdsConsultaTELEFONE: TStringField;
  private
    { Private declarations }
    DAOClient: TClienteDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnListar; override;
    procedure OnConsultar; override;
    procedure OnSelecionar; override;
  public
    { Public declarations }
    Cliente: TCliente;
  end;

var
  FrmConsultaCliente: TFrmConsultaCliente;

implementation

uses DataUtils;

{$R *.dfm}

{ TFrmConsultaBase1 }

procedure TFrmConsultaCliente.OnConsultar;
begin
  inherited;
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%');
  cdsConsulta.Filtered := True;
end;

procedure TFrmConsultaCliente.OnCreate;
begin
  inherited;
  DAOClient := TClienteDAOClient.Create(DBXConnection);
end;

procedure TFrmConsultaCliente.OnDestroy;
begin
  inherited;
  DAOClient.Free;
end;

procedure TFrmConsultaCliente.OnListar;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsConsulta);
end;

procedure TFrmConsultaCliente.OnSelecionar;
begin
  inherited;
  Cliente := TCliente.Create(cdsConsultaCODIGO.AsString,
                             cdsConsultaNOME.AsString,
                             cdsConsultaTELEFONE.AsString);
  Self.Close;
end;

end.
