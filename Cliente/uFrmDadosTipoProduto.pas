unit uFrmDadosTipoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, TipoProduto,
  uTipoProdutoDAOClient, DBClient, TypesUtils;

type
  TFrmDadosTipoProduto = class(TFrmDadosBase)
    Label1: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtDescricao: TEdit;
  private
    { Private declarations }
    DAOClient: TTipoProdutoDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    TipoProduto: TTipoProduto;
  end;

var
  FrmDadosTipoProduto: TFrmDadosTipoProduto;

implementation

uses MensagensUtils;

{$R *.dfm}

procedure TFrmDadosTipoProduto.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([edtDescricao]);
  TipoProduto        := TTipoProduto.Create;
  DAOClient          := TTipoProdutoDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosTipoProduto.OnDestroy;
begin
  inherited;
  TipoProduto.Free;
  DAOClient.Free;
end;

procedure TFrmDadosTipoProduto.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    edtCodigo.Text := DAOClient.NextCodigo;
    if not(DAOClient.Insert(TTipoProduto.Create(edtCodigo.Text, edtDescricao.Text))) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('CODIGO').AsString    := edtCodigo.Text;
    cds.FieldByName('DESCRICAO').AsString := edtDescricao.Text;
    cds.Post;
  end
  else
  begin
    if not(DAOClient.Update(TTipoProduto.Create(edtCodigo.Text, edtDescricao.Text))) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('CODIGO').AsString    := edtCodigo.Text;
    cds.FieldByName('DESCRICAO').AsString := edtDescricao.Text;
    cds.Post;
  end;
  if (chbContinuarIncluindo.Checked) then
    LimparControles
  else
    Self.Close;
end;

procedure TFrmDadosTipoProduto.OnShow;
begin
  inherited;
  edtCodigo.Text    := TipoProduto.Codigo;
  edtDescricao.Text := TipoProduto.Descricao;
end;

end.
