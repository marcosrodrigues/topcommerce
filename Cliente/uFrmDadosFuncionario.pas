unit uFrmDadosFuncionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, uFramePesquisaCargo,
  Funcionario, Cargo, uFuncionarioDAOClient, DBClient, TypesUtils;

type
  TFrmDadosFuncionario = class(TFrmDadosBase)
    Label1: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    FramePesquisaCargo: TFramePesquisaCargo;
  private
    { Private declarations }
    DAOClient: TFuncionarioDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    Funcionario: TFuncionario;
  end;

var
  FrmDadosFuncionario: TFrmDadosFuncionario;

implementation

uses MensagensUtils;

{$R *.dfm}

{ TFrmDadosFuncionario }

procedure TFrmDadosFuncionario.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([edtNome, FramePesquisaCargo.edtIdCargo]);
  Funcionario := TFuncionario.Create;
  DAOClient   := TFuncionarioDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosFuncionario.OnDestroy;
begin
  inherited;
  Funcionario.Free;
  DAOClient.Free;
end;

procedure TFrmDadosFuncionario.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    edtCodigo.Text := DAOClient.NextCodigo;
    if not(DAOClient.Insert(TFuncionario.Create(edtCodigo.Text, edtNome.Text, TCargo.Create(StrToIntDef(FramePesquisaCargo.edtIdCargo.Text,0), FramePesquisaCargo.edtDescricaoCargo.Text)))) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('CODIGO').AsString          := edtCodigo.Text;
    cds.FieldByName('NOME').AsString            := edtNome.Text;
    cds.FieldByName('CARGO_ID').AsInteger       := StrToIntDef(FramePesquisaCargo.edtIdCargo.Text,0);
    cds.FieldByName('CARGO_DESCRICAO').AsString := FramePesquisaCargo.edtDescricaoCargo.Text;
    cds.Post;
  end
  else
  begin
    if not(DAOClient.Update(TFuncionario.Create(edtCodigo.Text, edtNome.Text, TCargo.Create(StrToIntDef(FramePesquisaCargo.edtIdCargo.Text,0), FramePesquisaCargo.edtDescricaoCargo.Text)))) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('CODIGO').AsString          := edtCodigo.Text;
    cds.FieldByName('NOME').AsString            := edtNome.Text;
    cds.FieldByName('CARGO_ID').AsInteger       := StrToIntDef(FramePesquisaCargo.edtIdCargo.Text,0);
    cds.FieldByName('CARGO_DESCRICAO').AsString := FramePesquisaCargo.edtDescricaoCargo.Text;
    cds.Post;
  end;
  if (chbContinuarIncluindo.Checked) then
    LimparControles
  else
    Self.Close;
end;

procedure TFrmDadosFuncionario.OnShow;
begin
  inherited;
  edtCodigo.Text := Funcionario.Codigo;
  edtNome.Text := Funcionario.Nome;
  if Funcionario.Cargo.Id > 0 then
    FramePesquisaCargo.edtIdCargo.Text := IntToStr(Funcionario.Cargo.Id);
  FramePesquisaCargo.edtDescricaoCargo.Text := Funcionario.Cargo.Descricao;
end;

end.
