unit uFrmCargo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, uCargoDAOClient, Cargo;

type
  TFrmCargo = class(TFrmCrudBase)
    cdsCrudID: TIntegerField;
    cdsCrudDESCRICAO: TStringField;
  private
    { Private declarations }
    DAOClient: TCargoDAOClient;
  protected
    procedure CreateDAOClient; override;
    procedure DestroyDAOClient; override;
    procedure OnShow; override;
    procedure OnInsert; override;
    procedure OnEdit; override;
    procedure OnDelete; override;
    procedure OnPesquisar; override;
  public
    { Public declarations }
  end;

var
  FrmCargo: TFrmCargo;

implementation

uses DataUtils, MensagensUtils, uFrmDadosCargo, TypesUtils;

{$R *.dfm}

{ TFrmCargo }

procedure TFrmCargo.CreateDAOClient;
begin
  inherited;
  DAOClient := TCargoDAOClient.Create(DBXConnection);
end;

procedure TFrmCargo.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmCargo.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir este cargo?')) then
    if (DAOClient.Delete(TCargo.Create(cdsCrudID.AsInteger))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

procedure TFrmCargo.OnEdit;
var
  f: TFrmDadosCargo;
begin
  inherited;
  f := TFrmDadosCargo.Create(Self);
  try
    f.Cargo.Id        := cdsCrudID.AsInteger;
    f.Cargo.Descricao := cdsCrudDESCRICAO.AsString;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmCargo.OnInsert;
var
  f: TFrmDadosCargo;
begin
  inherited;
  f := TFrmDadosCargo.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmCargo.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

procedure TFrmCargo.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

end.
