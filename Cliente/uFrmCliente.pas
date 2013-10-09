unit uFrmCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls,
  uClienteDAOClient, Cliente;

type
  TFrmCliente = class(TFrmCrudBase)
    cdsCrudCODIGO: TStringField;
    cdsCrudNOME: TStringField;
    cdsCrudTELEFONE: TStringField;
  private
    { Private declarations }
    DAOClient: TClienteDAOClient;
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
  FrmCliente: TFrmCliente;

implementation

uses DataUtils, TypesUtils, MensagensUtils, uFrmDadosCliente;

{$R *.dfm}

{ TFrmCliente }

procedure TFrmCliente.CreateDAOClient;
begin
  inherited;
  DAOClient := TClienteDAOClient.Create(DBXConnection);
end;

procedure TFrmCliente.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmCliente.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

procedure TFrmCliente.OnInsert;
var
  f: TFrmDadosCliente;
begin
  inherited;
  f := TFrmDadosCliente.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmCliente.OnEdit;
var
  f: TFrmDadosCliente;
begin
  inherited;
  f := TFrmDadosCliente.Create(Self);
  try
    f.Cliente.Codigo := cdsCrudCODIGO.AsString;
    f.Cliente.Nome   := cdsCrudNOME.AsString;
    f.Cliente.Telefone := cdsCrudTELEFONE.AsString;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmCliente.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir este cliente?')) then
    if (DAOClient.Delete(TCliente.Create(cdsCrudCODIGO.AsString))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

procedure TFrmCliente.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

end.
