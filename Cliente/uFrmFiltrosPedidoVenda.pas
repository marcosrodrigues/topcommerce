unit uFrmFiltrosPedidoVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFiltrosBase, Buttons, ExtCtrls, StdCtrls, Mask;

type
  TFrmFiltrosPedidoVenda = class(TFrmFiltrosBase)
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  protected
    procedure OnVisualizar; override;
    procedure OnImprimir; override;
  public
    { Public declarations }
  end;

var
  FrmFiltrosPedidoVenda: TFrmFiltrosPedidoVenda;

implementation

uses uFrmRelPedidoVenda, MensagensUtils;

{$R *.dfm}

{ TFrmFiltrosPedidoVenda }

procedure TFrmFiltrosPedidoVenda.OnVisualizar;
var
  r: TFrmRelPedidoVenda;
begin
  inherited;
  { TODO : if ( deDataInicial.Date = 0 ) then }
  begin
    Atencao( 'Informe a data inicial do periodo.' );
    { TODO : deDataInicial.SetFocus; }
    Exit;
  end;

  { TODO : if ( deDataFinal.Date = 0 ) then }
  begin
    Atencao( 'Informe a data final do periodo.' );
    { TODO : deDataFinal.SetFocus; }
    Exit;
  end;

  r := TFrmRelPedidoVenda.Create(Self);
  try
    { TODO :
    r.DataInicial := deDataInicial.Date;
    r.DataFinal   := deDataFinal.Date; }
    r.QuickRep.Preview;
  finally
    r.Free;
  end;
end;

procedure TFrmFiltrosPedidoVenda.OnImprimir;
begin
  inherited;

end;

end.
