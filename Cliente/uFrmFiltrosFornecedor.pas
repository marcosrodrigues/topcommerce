unit uFrmFiltrosFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFiltrosBase, Buttons, ExtCtrls, uFramePesquisaProduto;

type
  TFrmFiltrosFornecedor = class(TFrmFiltrosBase)
    FramePesquisaProduto: TFramePesquisaProduto;
  private
    { Private declarations }
  protected
    procedure OnVisualizar; override;
    procedure OnImprimir; override;
  public
    { Public declarations }
  end;

var
  FrmFiltrosFornecedor: TFrmFiltrosFornecedor;

implementation

uses uFrmRelFornecedor;

{$R *.dfm}

{ TFrmFiltrosFornecedor }

procedure TFrmFiltrosFornecedor.OnVisualizar;
var
  r: TFrmRelFornecedor;
begin
  inherited;
  r := TFrmRelFornecedor.Create(Self);
  try
    r.CodigoProduto := FramePesquisaProduto.edtCodigoProduto.Text;
    r.QuickRep.Preview;
  finally
    r.Free;
  end;
end;

procedure TFrmFiltrosFornecedor.OnImprimir;
begin
  inherited;

end;

end.
