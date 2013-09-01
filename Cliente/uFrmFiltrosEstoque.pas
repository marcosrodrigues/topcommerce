unit uFrmFiltrosEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFiltrosBase, Buttons, ExtCtrls, StdCtrls;

type
  TFrmFiltrosEstoque = class(TFrmFiltrosBase)
    rgEstoque: TRadioGroup;
  private
    { Private declarations }
  protected
    procedure OnVisualizar; override;
    procedure OnImprimir; override;
  public
    { Public declarations }
  end;

var
  FrmFiltrosEstoque: TFrmFiltrosEstoque;

implementation

uses uFrmRelEstoque;

{$R *.dfm}

{ TFrmFiltrosEstoque }

procedure TFrmFiltrosEstoque.OnVisualizar;
var
  r: TFrmRelEstoque;
begin
  inherited;
  r := TFrmRelEstoque.Create(Self);
  try
    r.Estoque := rgEstoque.ItemIndex;
    r.RLReport.Preview;
  finally
    r.Free;
  end;
end;

procedure TFrmFiltrosEstoque.OnImprimir;
begin
  inherited;

end;

end.
