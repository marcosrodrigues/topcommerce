unit uFrmUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmCrudBase, DB, DBClient, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls,
  uUsuarioDAOClient, Usuario;

type
  TFrmUsuario = class(TFrmCrudBase)
    cdsCrudLOGIN: TStringField;
    cdsCrudSENHA: TStringField;
    cdsCrudULTIMOACESSO: TDateTimeField;
    procedure cdsCrudULTIMOACESSOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
    DAOClient: TUsuarioDAOClient;
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
  FrmUsuario: TFrmUsuario;

implementation

uses DataUtils, MensagensUtils, uFrmDadosUsuario, TypesUtils;

{$R *.dfm}

{ TFrmUsuario }

procedure TFrmUsuario.cdsCrudULTIMOACESSOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  if Sender.AsDateTime = 0 then
    Text := ''
  else
    Text := FormatDateTime( 'dd/mm/yyyy hh:mm', Sender.AsDateTime );
end;

procedure TFrmUsuario.CreateDAOClient;
begin
  inherited;
  DAOClient := TUsuarioDAOClient.Create(DBXConnection);
end;

procedure TFrmUsuario.DestroyDAOClient;
begin
  DAOClient.Free;
  inherited;
end;

procedure TFrmUsuario.OnShow;
begin
  inherited;
  CopyReaderToClientDataSet(DAOClient.List, cdsCrud);
end;

procedure TFrmUsuario.OnInsert;
var
  f: TFrmDadosUsuario;
begin
  inherited;
  f := TFrmDadosUsuario.Create(Self);
  try
    f.Operacao := opInsert;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmUsuario.OnEdit;
var
  f: TFrmDadosUsuario;
begin
  inherited;
  f := TFrmDadosUsuario.Create(Self);
  try
    f.Usuario.Login        := cdsCrudLOGIN.AsString;
    f.Usuario.Senha        := cdsCrudSENHA.AsString;
    f.Usuario.UltimoAcesso := cdsCrudULTIMOACESSO.AsDateTime;
    f.OldLogin             := cdsCrudLOGIN.AsString;

    f.Operacao := opEdit;
    f.ShowModal;
  finally
    f.Free;
  end;
end;

procedure TFrmUsuario.OnDelete;
begin
  inherited;
  if (Confirma('Deseja excluir este usuário?')) then
    if (DAOClient.Delete(TUsuario.Create(cdsCrudLOGIN.AsString, cdsCrudSENHA.AsString))) then
      cdsCrud.Delete
    else
      Erro('Ocorreu algum erro durante a exlusão.');
end;

procedure TFrmUsuario.OnPesquisar;
begin
  inherited;
  cdsCrud.Filtered := False;
  cdsCrud.Filter   := 'UPPER(LOGIN) LIKE ' + QuotedStr('%'+UpperCase(edtPesquisar.Text)+'%');
  cdsCrud.Filtered := True;
end;

end.
