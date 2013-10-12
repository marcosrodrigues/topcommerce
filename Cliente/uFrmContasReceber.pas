unit uFrmContasReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFiltrosBase, Buttons, ExtCtrls, uFramePesquisaCliente,
  uFramePeriodo, StdCtrls;

type
  TFrmFiltrosContasReceber = class(TFrmFiltrosBase)
    FramePeriodo: TFramePeriodo;
    FramePesquisaCliente: TFramePesquisaCliente;
    cbSituacao: TComboBox;
    Label1: TLabel;
  private
    { Private declarations }
  protected
    procedure OnVisualizar; override;
    procedure OnImprimir; override;
  public
    { Public declarations }
  end;

var
  FrmFiltrosContasReceber: TFrmFiltrosContasReceber;

implementation

uses uFrmRelContasReceber, MensagensUtils;

{$R *.dfm}

{ TFrmFiltrosContasReceber }

procedure TFrmFiltrosContasReceber.OnImprimir;
begin
  inherited;

end;

procedure TFrmFiltrosContasReceber.OnVisualizar;
var
  r: TFrmRelContasReceber;
begin
  inherited;
  if ( FramePeriodo.deDataInicial.Date = 0 ) then
  begin
    Atencao( 'Informe a data inicial do periodo.' );
    FramePeriodo.deDataInicial.SetFocus;
    Exit;
  end;

  if ( FramePeriodo.deDataFinal.Date = 0 ) then
  begin
    Atencao( 'Informe a data final do periodo.' );
    FramePeriodo.deDataFinal.SetFocus;
    Exit;
  end;

  r := TFrmRelContasReceber.Create(Self);
  try
    r.DataInicial := FramePeriodo.deDataInicial.Date;
    r.DataFinal   := FramePeriodo.deDataFinal.Date;
    r.ClienteCodigo := FramePesquisaCliente.edtCodigoCliente.Text;
    r.Situacao := cbSituacao.ItemIndex;
    r.RLReport.Preview;
  finally
    r.Free;
  end;
end;

end.
