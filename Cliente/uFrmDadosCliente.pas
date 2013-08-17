unit uFrmDadosCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, uClienteDAOClient, Cliente,
  DBClient, TypesUtils, Mask;

type
  TFrmDadosCliente = class(TFrmDadosBase)
    Label1: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    mkdTelefone: TMaskEdit;
  private
    { Private declarations }
    DAOClient: TClienteDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    Cliente: TCliente;
  end;

var
  FrmDadosCliente: TFrmDadosCliente;

implementation

uses MensagensUtils;

{$R *.dfm}

{ TFrmDadosCliente }

procedure TFrmDadosCliente.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([edtNome]);
  Cliente   := TCliente.Create;
  DAOClient := TClienteDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosCliente.OnDestroy;
begin
  inherited;
  Cliente.Free;
  DAOClient.Free;
end;

procedure TFrmDadosCliente.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    edtCodigo.Text := DAOClient.NextCodigo;
    if not(DAOClient.Insert(TCliente.Create(edtCodigo.Text, edtNome.Text, mkdTelefone.Text))) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('CODIGO').AsString   := edtCodigo.Text;
    cds.FieldByName('NOME').AsString     := edtNome.Text;
    cds.FieldByName('TELEFONE').AsString := mkdTelefone.Text;
    cds.Post;
  end
  else
  begin
    if not(DAOClient.Update(TCliente.Create(edtCodigo.Text, edtNome.Text, mkdTelefone.Text))) then
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

procedure TFrmDadosCliente.OnShow;
begin
  inherited;
  edtCodigo.Text   := Cliente.Codigo;
  edtNome.Text     := Cliente.Nome;
  mkdTelefone.Text := Cliente.Telefone;
end;

end.
