unit uFrmFiltrosProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFiltrosBase, Buttons, ExtCtrls, uFramePesquisaTipoProduto,
  StdCtrls, uFramePesquisaFornecedor;

type
  TFrmFiltrosProduto = class(TFrmFiltrosBase)
    FramePesquisaTipoProduto: TFramePesquisaTipoProduto;
    rgEstoque: TRadioGroup;
    FramePesquisaFornecedor: TFramePesquisaFornecedor;
  private
    { Private declarations }
  protected
    procedure OnVisualizar; override;
    procedure OnImprimir; override;
  public
    { Public declarations }
  end;

var
  FrmFiltrosProduto: TFrmFiltrosProduto;

implementation

uses uFrmRelProduto;

{$R *.dfm}

{ TFrmFiltrosProduto }

procedure TFrmFiltrosProduto.OnVisualizar;
var
  r: TFrmRelProduto;
begin
  inherited;
  r := TFrmRelProduto.Create(Self);
  try
    r.CodigoTipoProduto := FramePesquisaTipoProduto.edtCodigoTipoProduto.Text;
    r.CodigoFornecedor  := FramePesquisaFornecedor.edtCodigoFornecedor.Text;
    r.Estoque           := rgEstoque.ItemIndex;
    r.QuickRep.Preview;
  finally
    r.Free;
  end;
end;

procedure TFrmFiltrosProduto.OnImprimir;
begin
  inherited;

end;

end.
