unit uFrmConsultaBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmBase, Grids, DBGrids, ExtCtrls, StdCtrls, DB, DBClient, DBXCommon;

type
  TFrmConsultaBase = class(TFrmBase)
    pnlParametros: TPanel;
    pnlResultado: TPanel;
    grdConsulta: TDBGrid;
    Label1: TLabel;
    edtConsultar: TEdit;
    Label2: TLabel;
    lblTotalRegistros: TLabel;
    dsConsulta: TDataSource;
    cdsConsulta: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtConsultarChange(Sender: TObject);
    procedure grdConsultaDblClick(Sender: TObject);
    procedure grdConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure edtConsultarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    DBXConnection: TDBXConnection;

    procedure OnCreate; virtual; abstract;
    procedure OnDestroy; virtual; abstract;
    procedure OnListar; virtual; abstract;
    procedure OnConsultar; virtual; abstract;
    procedure OnSelecionar; virtual; abstract;
  public
    { Public declarations }
  end;

var
  FrmConsultaBase: TFrmConsultaBase;

implementation

uses uFrmPrincipal;

{$R *.dfm}

procedure TFrmConsultaBase.edtConsultarChange(Sender: TObject);
begin
  inherited;
  OnConsultar;
  lblTotalRegistros.Caption := IntToStr(cdsConsulta.RecordCount);
end;

procedure TFrmConsultaBase.edtConsultarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_DOWN: grdConsulta.SetFocus;
  end;
end;

procedure TFrmConsultaBase.FormCreate(Sender: TObject);
begin
  inherited;
  DBXConnection := FrmPrincipal.ConnServidor.DBXConnection;
  OnCreate;
end;

procedure TFrmConsultaBase.FormDestroy(Sender: TObject);
begin
  inherited;
  OnDestroy;
end;

procedure TFrmConsultaBase.FormShow(Sender: TObject);
begin
  inherited;
  OnListar;
  lblTotalRegistros.Caption := IntToStr(cdsConsulta.RecordCount);
end;

procedure TFrmConsultaBase.grdConsultaDblClick(Sender: TObject);
begin
  inherited;
  OnSelecionar;
end;

procedure TFrmConsultaBase.grdConsultaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Ord(Key) = 13) then
    OnSelecionar;
end;

end.
