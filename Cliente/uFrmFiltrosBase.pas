unit uFrmFiltrosBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmBase, Buttons, ExtCtrls;

type
  TFrmFiltrosBase = class(TFrmBase)
    pnlBotoes: TPanel;
    sbtVisualizar: TSpeedButton;
    sbtImprimir: TSpeedButton;
    sbtFechar: TSpeedButton;
    pnlFiltros: TPanel;
    procedure sbtVisualizarClick(Sender: TObject);
    procedure sbtImprimirClick(Sender: TObject);
    procedure sbtFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure OnVisualizar; virtual; abstract;
    procedure OnImprimir; virtual; abstract;
  public
    { Public declarations }
  end;

var
  FrmFiltrosBase: TFrmFiltrosBase;

implementation

{$R *.dfm}

procedure TFrmFiltrosBase.sbtVisualizarClick(Sender: TObject);
begin
  inherited;
  OnVisualizar;
end;

procedure TFrmFiltrosBase.sbtImprimirClick(Sender: TObject);
begin
  inherited;
  OnImprimir;
end;

procedure TFrmFiltrosBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F8: sbtVisualizar.Click;
    VK_F9: sbtImprimir.Click;
  end;
end;

procedure TFrmFiltrosBase.sbtFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
