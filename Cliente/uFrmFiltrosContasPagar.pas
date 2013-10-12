unit uFrmFiltrosContasPagar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFiltrosBase, Buttons, ExtCtrls, uFramePeriodo,
  uFramePesquisaFornecedor, StdCtrls;

type
  TFrmFiltrosContasPagar = class(TFrmFiltrosBase)
    FramePeriodo: TFramePeriodo;
    FramePesquisaFornecedor: TFramePesquisaFornecedor;
    Label1: TLabel;
    cbSituacao: TComboBox;
  private
    { Private declarations }
  protected
    procedure OnVisualizar; override;
    procedure OnImprimir; override;
  public
    { Public declarations }
  end;

var
  FrmFiltrosContasPagar: TFrmFiltrosContasPagar;

implementation

uses uFrmRelContasPagar;

{$R *.dfm}

{ TFrmFiltrosContasPagar }

procedure TFrmFiltrosContasPagar.OnImprimir;
begin
  inherited;

end;

procedure TFrmFiltrosContasPagar.OnVisualizar;
var
  r: TFrmRelContasPagar;
begin
  inherited;
  r := TFrmRelContasPagar.Create(Self);
  try
    r.DataInicial := FramePeriodo.deDataInicial.Date;
    r.DataFinal   := FramePeriodo.deDataFinal.Date;
    r.FornecedorCodigo := FramePesquisaFornecedor.edtCodigoFornecedor.Text;
    r.Situacao := cbSituacao.ItemIndex;
    r.RLReport.Preview;
  finally
    r.Free;
  end;
end;

end.
