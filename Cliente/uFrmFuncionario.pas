unit uFrmFuncionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons,
  ExtCtrls, uFuncionarioDAOClient, Funcionario, Cargo;

type
  TFrmFuncionario = class(TFrmCrudBase)
    cdsCrudCODIGO: TStringField;
    cdsCrudNOME: TStringField;
    cdsCrudCARGO_ID: TIntegerField;
    cdsCrudCARGO_DESCRICAO: TStringField;
  private
    { Private declarations }
    DAOClient: TFuncionarioDAOClient;
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
  FrmFuncionario: TFrmFuncionario;

implementation

uses DataUtils, MensagensUtils, uFrmDadosFuncionario, TypesUtils;

{$R *.dfm}

{ TFrmFuncionario }

procedure TFrmFuncionario.CreateDAOClient;
begin
  inherited;
  DAOClient := TFuncionarioDAOClient.Create(DBXConnection);
end;

procedure TFrmFuncionario.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmFuncionario.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir este funcionário?')) then
    if (DAOClient.Delete(TFuncionario.Create(cdsCrudCODIGO.AsString))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

procedure TFrmFuncionario.OnEdit;
var
  f: TFrmDadosFuncionario;
begin
  inherited;
  f := TFrmDadosFuncionario.Create(Self);
  try
    f.Funcionario.Codigo := cdsCrudCODIGO.AsString;
    f.Funcionario.Nome   := cdsCrudNOME.AsString;
    f.Funcionario.Cargo  := TCargo.Create(cdsCrudCARGO_ID.AsInteger,
                                          cdsCrudCARGO_DESCRICAO.AsString);

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmFuncionario.OnInsert;
var
  f: TFrmDadosFuncionario;
begin
  inherited;
  f := TFrmDadosFuncionario.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmFuncionario.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

procedure TFrmFuncionario.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

end.
