unit uFrmTipoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, Grids, DBGrids, Buttons, ExtCtrls, DB, DBClient,
  uTipoProdutoDAOClient, DBXDBReaders, StdCtrls;

type
  TFrmTipoProduto = class(TFrmCrudBase)
    cdsCrudCODIGO: TStringField;
    cdsCrudDESCRICAO: TStringField;
  private
    { Private declarations }
    DAOClient: TTipoProdutoDAOClient;
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
  FrmTipoProduto: TFrmTipoProduto;

implementation

uses uFrmDadosTipoProduto, TypesUtils, MensagensUtils, TipoProduto, DataUtils;

{$R *.dfm}

{ TFrmTipoProduto }

procedure TFrmTipoProduto.CreateDAOClient;
begin
  inherited;
  DAOClient := TTipoProdutoDAOClient.Create(DBXConnection);
end;

procedure TFrmTipoProduto.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmTipoProduto.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

procedure TFrmTipoProduto.OnInsert;
var
  f: TFrmDadosTipoProduto;
begin
  inherited;
  f := TFrmDadosTipoProduto.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmTipoProduto.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

procedure TFrmTipoProduto.OnEdit;
var
  f: TFrmDadosTipoProduto;
begin
  inherited;
  f := TFrmDadosTipoProduto.Create(Self);
  try
    f.TipoProduto.Codigo    := cdsCrudCODIGO.AsString;
    f.TipoProduto.Descricao := cdsCrudDESCRICAO.AsString;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmTipoProduto.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir este Tipo de Produto?')) then
    if (DAOClient.Delete(TTipoProduto.Create(cdsCrudCODIGO.AsString))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

end.
