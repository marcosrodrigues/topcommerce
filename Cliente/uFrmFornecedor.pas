unit uFrmFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, Grids, DBGrids, Buttons, ExtCtrls,
  uFornecedorDAOClient, DBXDBReaders, StdCtrls;

type
  TFrmFornecedor = class(TFrmCrudBase)
    cdsCrudCODIGO: TStringField;
    cdsCrudNOME: TStringField;
    cdsCrudTELEFONE: TStringField;
  private
    { Private declarations }
    DAOClient: TFornecedorDAOClient;
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
  FrmFornecedor: TFrmFornecedor;

implementation

uses uFrmDadosFornecedor, TypesUtils, Fornecedor, MensagensUtils, DataUtils;

{$R *.dfm}

{ TFrmFornecedor }

procedure TFrmFornecedor.CreateDAOClient;
begin
  inherited;
  DAOClient := TFornecedorDAOClient.Create(DBXConnection);
end;

procedure TFrmFornecedor.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmFornecedor.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

procedure TFrmFornecedor.OnInsert;
var
  f: TFrmDadosFornecedor;
begin
  inherited;
  f := TFrmDadosFornecedor.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmFornecedor.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

procedure TFrmFornecedor.OnEdit;
var
  f: TFrmDadosFornecedor;
begin
  inherited;
  f := TFrmDadosFornecedor.Create(Self);
  try
    f.Fornecedor          := TFornecedor.Create;
    f.Fornecedor.Codigo   := cdsCrudCODIGO.AsString;
    f.Fornecedor.Nome     := cdsCrudNOME.AsString;
    f.Fornecedor.Telefone := cdsCrudTELEFONE.AsString;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmFornecedor.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir este Fornecedor?')) then
    if (DAOClient.Delete(TFornecedor.Create(cdsCrudCODIGO.AsString))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

end.
