unit uFrmDadosFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, Mask, Fornecedor,
  uFornecedorDAOClient, DBClient;

type
  TFrmDadosFornecedor = class(TFrmDadosBase)
    Label1: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    mkdTelefone: TMaskEdit;
  private
    { Private declarations }
    DAOClient: TFornecedorDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    Fornecedor: TFornecedor;
  end;

var
  FrmDadosFornecedor: TFrmDadosFornecedor;

implementation

uses MensagensUtils, TypesUtils;

{$R *.dfm}

{ TFrmDadosFornecedor }

procedure TFrmDadosFornecedor.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([edtNome]);
  DAOClient := TFornecedorDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosFornecedor.OnDestroy;
begin
  inherited;
  DAOClient.Free;
end;

procedure TFrmDadosFornecedor.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    edtCodigo.Text := DAOClient.NextCodigo;
    if not(DAOClient.Insert(TFornecedor.Create(edtCodigo.Text, edtNome.Text, mkdTelefone.Text))) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('CODIGO').AsString   := edtCodigo.Text;
    cds.FieldByName('NOME').AsString     := edtNome.Text;
    cds.FieldByName('TELEFONE').AsString := mkdTelefone.Text;
    cds.Post;
  end
  else
  begin
    if not(DAOClient.Update(TFornecedor.Create(edtCodigo.Text, edtNome.Text, mkdTelefone.Text))) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('CODIGO').AsString   := edtCodigo.Text;
    cds.FieldByName('NOME').AsString     := edtNome.Text;
    cds.FieldByName('TELEFONE').AsString := mkdTelefone.Text;
    cds.Post;
  end;
  if (chbContinuarIncluindo.Checked) then
    LimparControles
  else
    Self.Close;
end;

procedure TFrmDadosFornecedor.OnShow;
begin
  inherited;
  if (Assigned(Fornecedor)) then
  begin
    edtCodigo.Text   := Fornecedor.Codigo;
    edtNome.Text     := Fornecedor.Nome;
    mkdTelefone.Text := Fornecedor.Telefone;
  end;
end;

end.
