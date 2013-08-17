unit uFrmDadosUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, Usuario,
  uUsuarioDAOClient, DBClient, TypesUtils;

type
  TFrmDadosUsuario = class(TFrmDadosBase)
    Label1: TLabel;
    edtUsuario: TEdit;
    Label2: TLabel;
    edtSenha: TEdit;
  private
    { Private declarations }
    DAOClient: TUsuarioDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    Usuario: TUsuario;
    OldLogin: string;
  end;

var
  FrmDadosUsuario: TFrmDadosUsuario;

implementation

uses MensagensUtils;

{$R *.dfm}

{ TFrmDadosUsuario }

procedure TFrmDadosUsuario.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([edtUsuario, edtSenha]);
  Usuario   := TUsuario.Create;
  DAOClient := TUsuarioDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosUsuario.OnDestroy;
begin
  inherited;
  Usuario.Free;
  DAOClient.Free;
end;

procedure TFrmDadosUsuario.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    if not(DAOClient.Insert(TUsuario.Create(edtUsuario.Text, edtSenha.Text))) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('LOGIN').AsString := edtUsuario.Text;
    cds.FieldByName('SENHA').AsString := edtSenha.Text;
    cds.Post;
  end
  else
  begin
    if not(DAOClient.Update(TUsuario.Create(edtUsuario.Text, edtSenha.Text), OldLogin)) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('LOGIN').AsString := edtUsuario.Text;
    cds.FieldByName('SENHA').AsString := edtSenha.Text;
    cds.Post;
  end;
  if (chbContinuarIncluindo.Checked) then
    LimparControles
  else
    Self.Close;
end;

procedure TFrmDadosUsuario.OnShow;
begin
  inherited;
  edtUsuario.Text := Usuario.Login;
  edtSenha.Text   := Usuario.Senha;
end;

end.
