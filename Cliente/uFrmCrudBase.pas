unit uFrmCrudBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmBase, ExtCtrls, Buttons, Grids, DBGrids, DB, DBClient, DBXCommon, StdCtrls;

type
  TFrmCrudBase = class(TFrmBase)
    pnlBotoes: TPanel;
    sbtNovo: TSpeedButton;
    sbtEditar: TSpeedButton;
    sbtExcluir: TSpeedButton;
    sbtFechar: TSpeedButton;
    grdCrud: TDBGrid;
    dsCrud: TDataSource;
    cdsCrud: TClientDataSet;
    sbtPrimeiro: TSpeedButton;
    sbtUltimo: TSpeedButton;
    pnlPesquisar: TPanel;
    Label1: TLabel;
    edtPesquisar: TEdit;
    procedure sbtFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbtNovoClick(Sender: TObject);
    procedure sbtEditarClick(Sender: TObject);
    procedure sbtExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbtPrimeiroClick(Sender: TObject);
    procedure sbtUltimoClick(Sender: TObject);
    procedure edtPesquisarChange(Sender: TObject);
  private
    { Private declarations }
  protected
    DBXConnection: TDBXConnection;

    procedure CreateDAOClient; virtual; abstract;
    procedure DestroyDAOClient; virtual; abstract;
    procedure OnShow; virtual; abstract;
    procedure OnInsert; virtual; abstract;
    procedure OnEdit; virtual; abstract;
    procedure OnDelete; virtual; abstract;
    procedure OnPesquisar; virtual; abstract;
  public
    { Public declarations }
  end;

var
  FrmCrudBase: TFrmCrudBase;

implementation

uses uFrmPrincipal;

{$R *.dfm}

procedure TFrmCrudBase.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  OnPesquisar;
end;

procedure TFrmCrudBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmCrudBase. FormCreate(Sender: TObject);
begin
  inherited;
  DBXConnection := FrmPrincipal.ConnServidor.DBXConnection;
  CreateDAOClient;
end;

procedure TFrmCrudBase.FormDestroy(Sender: TObject);
begin
  inherited;
  DestroyDAOClient;
  FrmCrudBase := nil;
end;

procedure TFrmCrudBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F2: sbtNovo.Click;
    VK_F3: sbtEditar.Click;
    VK_F4: sbtExcluir.Click;
    VK_F5: edtPesquisar.SetFocus;
    VK_F10: sbtPrimeiro.Click;
    VK_F11: sbtUltimo.Click;
  end;
end;

procedure TFrmCrudBase.FormShow(Sender: TObject);
begin
  inherited;
  OnShow;
  cdsCrud.First;
end;

procedure TFrmCrudBase.sbtFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCrudBase.sbtNovoClick(Sender: TObject);
begin
  inherited;
  OnInsert;
end;

procedure TFrmCrudBase.sbtPrimeiroClick(Sender: TObject);
begin
  inherited;
  cdsCrud.First;
end;

procedure TFrmCrudBase.sbtUltimoClick(Sender: TObject);
begin
  inherited;
  cdsCrud.Last;
end;

procedure TFrmCrudBase.sbtEditarClick(Sender: TObject);
begin
  inherited;
  if cdsCrud.IsEmpty then
    Exit;
  OnEdit;
end;

procedure TFrmCrudBase.sbtExcluirClick(Sender: TObject);
begin
  inherited;
  if cdsCrud.IsEmpty then
    Exit;
  OnDelete;
end;

end.
