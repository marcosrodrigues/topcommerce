unit uFrmDadosEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, Spin, Estoque, uEstoqueDAOClient,
  DBClient, uFramePesquisaProduto;

type
  TFrmDadosEstoque = class(TFrmDadosBase)
    Label1: TLabel;
    FramePesquisaProduto: TFramePesquisaProduto;
    sedQuantidade: TSpinEdit;
    procedure FramePesquisaProdutoedtCodigoProdutoExit(Sender: TObject);
  private
    { Private declarations }
    DAOClient: TEstoqueDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    Estoque: TEstoque;
  end;

var
  FrmDadosEstoque: TFrmDadosEstoque;

implementation

uses Produto, MensagensUtils, TypesUtils, StringUtils;

{$R *.dfm}

{ TFrmDadosEstoque }

procedure TFrmDadosEstoque.FramePesquisaProdutoedtCodigoProdutoExit(Sender: TObject);
var
  cds: TClientDataSet;
begin
  inherited;
  FramePesquisaProduto.edtCodigoProdutoExit(Sender);
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if ( Operacao = opInsert ) and (cds.FindKey([FramePesquisaProduto.edtCodigoProduto.Text])) then
  begin
    Atencao('Este produto já foi lançado no estoque.');
    FramePesquisaProduto.edtCodigoProduto.SetFocus;
    Exit;
  end;
end;

procedure TFrmDadosEstoque.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([FramePesquisaProduto.edtCodigoProduto]);
  DAOClient := TEstoqueDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosEstoque.OnDestroy;
begin
  inherited;
  DAOClient.Free;
end;

procedure TFrmDadosEstoque.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    if not(DAOClient.Insert(TEstoque.Create(TProduto.Create(FramePesquisaProduto.edtCodigoProduto.Text,
                                                            nil,
                                                            FramePesquisaProduto.edtDescricaoProduto.Text,
                                                            '',
                                                            0,
                                                            0,
                                                            nil,
                                                            nil,
                                                            ''),
                                         sedQuantidade.Value))) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('CODIGO_PRODUTO').AsString    := FramePesquisaProduto.edtCodigoProduto.Text;
    cds.FieldByName('DESCRICAO_PRODUTO').AsString := FramePesquisaProduto.edtDescricaoProduto.Text;
    cds.FieldByName('QUANTIDADE').AsInteger       := sedQuantidade.Value;
    cds.Post;
  end
  else
  begin
    if not(DAOClient.Update(TEstoque.Create(TProduto.Create(FramePesquisaProduto.edtCodigoProduto.Text,
                                                            nil,
                                                            FramePesquisaProduto.edtDescricaoProduto.Text,
                                                            '',
                                                            0,
                                                            0,
                                                            nil,
                                                            nil,
                                                            ''),
                                         sedQuantidade.Value))) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('CODIGO_PRODUTO').AsString    := FramePesquisaProduto.edtCodigoProduto.Text;
    cds.FieldByName('DESCRICAO_PRODUTO').AsString := FramePesquisaProduto.edtDescricaoProduto.Text;
    cds.FieldByName('QUANTIDADE').AsInteger       := sedQuantidade.Value;
    cds.Post;
  end;
end;

procedure TFrmDadosEstoque.OnShow;
begin
  inherited;
  if (Assigned(Estoque)) then
  begin
    try
      FramePesquisaProduto.edtCodigoProduto.Text    := Estoque.Produto.Codigo;
      FramePesquisaProduto.edtDescricaoProduto.Text := Estoque.Produto.Descricao;
      sedQuantidade.Value      := Estoque.Quantidade;
    finally
      Estoque.Free;
    end;
  end;
end;

end.
