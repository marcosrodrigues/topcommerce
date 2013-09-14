unit uFrmEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, Grids, DBGrids, Buttons, ExtCtrls,
  uEstoqueDAOClient, DBXDBReaders, StdCtrls;

type
  TFrmEstoque = class(TFrmCrudBase)
    cdsCrudCODIGO_PRODUTO: TStringField;
    cdsCrudDESCRICAO_PRODUTO: TStringField;
    cdsCrudQUANTIDADE: TIntegerField;
  private
    { Private declarations }
    DAOClient: TEstoqueDAOClient;
  public
    { Public declarations }
    procedure CreateDAOClient; override;
    procedure DestroyDAOClient; override;
    procedure OnShow; override;
    procedure OnInsert; override;
    procedure OnEdit; override;
    procedure OnDelete; override;
    procedure OnPesquisar; override;
  end;

var
  FrmEstoque: TFrmEstoque;

implementation

uses uFrmDadosEstoque, TypesUtils, Estoque, Produto, MensagensUtils, DataUtils;

{$R *.dfm}

{ TFrmEstoque }

procedure TFrmEstoque.CreateDAOClient;
begin
  inherited;
  DAOClient := TEstoqueDAOClient.Create(DBXConnection);
end;

procedure TFrmEstoque.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmEstoque.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

procedure TFrmEstoque.OnInsert;
var
  f: TFrmDadosEstoque;
begin
  inherited;
  f := TFrmDadosEstoque.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmEstoque.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(DESCRICAO_PRODUTO) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

procedure TFrmEstoque.OnEdit;
var
  f: TFrmDadosEstoque;
begin
  inherited;
  f := TFrmDadosEstoque.Create(Self);
  try
    f.Estoque         := TEstoque.Create;
    f.Estoque.Produto := TProduto.Create(cdsCrudCODIGO_PRODUTO.AsString,
                                         nil,
                                         cdsCrudDESCRICAO_PRODUTO.AsString,
                                         '',
                                         0,
                                         0,
                                         nil,
                                         nil);
    f.Estoque.Quantidade := cdsCrudQUANTIDADE.AsInteger;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;end;

procedure TFrmEstoque.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir este Produto?')) then
    if (DAOClient.Delete(TEstoque.Create(TProduto.Create(cdsCrudCODIGO_PRODUTO.AsString)))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

end.
