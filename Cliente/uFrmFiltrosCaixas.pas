unit uFrmFiltrosCaixas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFiltrosBase, ComCtrls, StdCtrls, Buttons, ExtCtrls, DateUtils;

type
  TFrmFiltrosCaixas = class(TFrmFiltrosBase)
    Label1: TLabel;
    deDataInicial: TDateTimePicker;
    deDataFinal: TDateTimePicker;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure OnVisualizar; override;
    procedure OnImprimir; override;
  public
    { Public declarations }
  end;

var
  FrmFiltrosCaixas: TFrmFiltrosCaixas;

implementation

uses uFrmRelCaixas, MensagensUtils;

{$R *.dfm}

procedure TFrmFiltrosCaixas.FormShow(Sender: TObject);
begin
  inherited;
  deDataInicial.Date := Now;
  deDataFinal.Date   := Now;
end;

procedure TFrmFiltrosCaixas.OnImprimir;
begin
  inherited;

end;

procedure TFrmFiltrosCaixas.OnVisualizar;
var
  r: TFrmRelCaixas;
begin
  inherited;
  if ( deDataInicial.Date = 0 ) then
  begin
    Atencao( 'Informe a data inicial do periodo.' );
    deDataInicial.SetFocus;
    Exit;
  end;

  if ( deDataFinal.Date = 0 ) then
  begin
    Atencao( 'Informe a data final do periodo.' );
    deDataFinal.SetFocus;
    Exit;
  end;

  r := TFrmRelCaixas.Create(Self);
  try
    r.DataInicial := DateOf(deDataInicial.Date);
    r.DataFinal   := DateOf(deDataFinal.Date);
    r.RLReport.Preview;
  finally
    r.Free;
  end;
end;

end.
