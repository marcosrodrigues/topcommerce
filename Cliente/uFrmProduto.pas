unit uFrmProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, Grids, DBGrids, Buttons, ExtCtrls,
  uProdutoDAOClient, DBXDBReaders, StdCtrls;

type
  TFrmProduto = class(TFrmCrudBase)
    cdsCrudCODIGO: TStringField;
    cdsCrudDESCRICAO: TStringField;
    cdsCrudCODIGO_TIPO_PRODUTO: TStringField;
    cdsCrudDESCRICAO_TIPO_PRODUTO: TStringField;
    cdsCrudCODIGO_BARRAS: TStringField;
    cdsCrudPRECO_VENDA: TCurrencyField;
    cdsCrudQUANTIDADE: TIntegerField;
  private
    { Private declarations }
    DAOClient: TProdutoDAOClient;
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
  FrmProduto: TFrmProduto;

implementation

uses uFrmDadosProduto, TypesUtils, TipoProduto, MensagensUtils, Produto,
  DataUtils;

{$R *.dfm}

{ TFrmProduto }

procedure TFrmProduto.CreateDAOClient;
begin
  inherited;
  DAOClient := TProdutoDAOClient.Create(DBXConnection);
end;

procedure TFrmProduto.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmProduto.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

procedure TFrmProduto.OnInsert;
var
  f: TFrmDadosProduto;
begin
  inherited;
  f := TFrmDadosProduto.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmProduto.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

procedure TFrmProduto.OnEdit;
var
  f: TFrmDadosProduto;
begin
  inherited;
  f := TFrmDadosProduto.Create(Self);
  try
    f.Produto              := TProduto.Create;
    f.Produto.Codigo       := cdsCrudCODIGO.AsString;
    f.Produto.Descricao    := cdsCrudDESCRICAO.AsString;
    f.Produto.TipoProduto  := TTipoProduto.Create(cdsCrudCODIGO_TIPO_PRODUTO.AsString,
                                                  cdsCrudDESCRICAO_TIPO_PRODUTO.AsString);
    f.Produto.CodigoBarras      := cdsCrudCODIGO_BARRAS.AsString;
    f.Produto.PrecoVenda        := cdsCrudPRECO_VENDA.AsCurrency;
    f.Produto.QuantidadeEstoque := cdsCrudQUANTIDADE.AsInteger;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmProduto.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir este Produto?')) then
    if (DAOClient.Delete(TProduto.Create(cdsCrudCODIGO.AsString))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

end.

