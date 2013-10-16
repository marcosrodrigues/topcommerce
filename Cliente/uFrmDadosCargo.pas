unit uFrmDadosCargo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, uCargoDAOClient, Cargo,
  DBClient, TypesUtils;

type
  TFrmDadosCargo = class(TFrmDadosBase)
    Label1: TLabel;
    Label2: TLabel;
    edtId: TEdit;
    edtDescricao: TEdit;
  private
    { Private declarations }
    DAOClient: TCargoDAOClient;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    Cargo: TCargo;
  end;

var
  FrmDadosCargo: TFrmDadosCargo;

implementation

uses MensagensUtils;

{$R *.dfm}

{ TFrmDadosCargo }

procedure TFrmDadosCargo.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([edtDescricao]);
  Cargo     := TCargo.Create;
  DAOClient := TCargoDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosCargo.OnDestroy;
begin
  inherited;
  Cargo.Free;
  DAOClient.Free;
end;

procedure TFrmDadosCargo.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));
  if (Operacao = opInsert) then
  begin
    if not(DAOClient.Insert(TCargo.Create(StrToIntDef(edtId.Text,0), edtDescricao.Text))) then
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('DESCRICAO').AsString := edtDescricao.Text;
    cds.Post;
  end
  else
  begin
    if not(DAOClient.Update(TCargo.Create(StrToIntDef(edtId.Text,0), edtDescricao.Text))) then
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('ID').AsInteger       := StrToIntDef(edtId.Text,0);
    cds.FieldByName('DESCRICAO').AsString := edtDescricao.Text;
    cds.Post;
  end;
  if (chbContinuarIncluindo.Checked) then
    LimparControles
  else
    Self.Close;
end;

procedure TFrmDadosCargo.OnShow;
begin
  inherited;
  edtId.Text        := IntToStr(Cargo.Id);
  edtDescricao.Text := Cargo.Descricao;
end;

end.
