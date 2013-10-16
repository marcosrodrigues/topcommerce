unit uFrmConsultaFuncionarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, pngimage, ExtCtrls, Grids, DBGrids, StdCtrls, uFuncionarioDAOClient,
  Funcionario, Cargo;

type
  TFrmConsultaFuncionarios = class(TForm)
    pnlParametros: TPanel;
    Label1: TLabel;
    edtConsultar: TEdit;
    grdConsulta: TDBGrid;
    Panel1: TPanel;
    Image19: TImage;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    cdsConsultaCODIGO: TStringField;
    cdsConsultaNOME: TStringField;
    cdsConsultaCARGO_ID: TIntegerField;
    cdsConsultaCARGO_DESCRICAO: TStringField;
    procedure edtConsultarChange(Sender: TObject);
    procedure edtConsultarKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure grdConsultaDblClick(Sender: TObject);
    procedure grdConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure Image19Click(Sender: TObject);
  private
    { Private declarations }
    DAOClient: TFuncionarioDAOClient;

    procedure Selecionar;
  public
    { Public declarations }
    Funcionario: TFuncionario;
  end;

var
  FrmConsultaFuncionarios: TFrmConsultaFuncionarios;

implementation

uses DataUtils, uFrmPrincipal;

{$R *.dfm}

procedure TFrmConsultaFuncionarios.edtConsultarChange(Sender: TObject);
begin
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'UPPER(NOME) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%');
  cdsConsulta.Filtered := True;
end;

procedure TFrmConsultaFuncionarios.edtConsultarKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Ord(Key) = 13) then
    Selecionar;
end;

procedure TFrmConsultaFuncionarios.FormCreate(Sender: TObject);
begin
  DAOClient := TFuncionarioDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
end;

procedure TFrmConsultaFuncionarios.FormDestroy(Sender: TObject);
begin
  DAOClient.Free;
end;

procedure TFrmConsultaFuncionarios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
    VK_DOWN: grdConsulta.SetFocus;
  end;
end;

procedure TFrmConsultaFuncionarios.FormShow(Sender: TObject);
begin
  CopyReaderToClientDataSet(DAOClient.List, cdsConsulta);
end;

procedure TFrmConsultaFuncionarios.grdConsultaDblClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TFrmConsultaFuncionarios.grdConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Ord(Key) = 13) then
    Selecionar;
end;

procedure TFrmConsultaFuncionarios.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmConsultaFuncionarios.Selecionar;
begin
  Funcionario          := TFuncionario.Create;
  Funcionario.Codigo   := cdsConsultaCODIGO.AsString;
  Funcionario.Nome     := cdsConsultaNOME.AsString;
  Funcionario.Cargo    := TCargo.Create(cdsConsultaCARGO_ID.AsInteger, cdsConsultaCARGO_DESCRICAO.AsString);
  Self.Close;
end;

end.
