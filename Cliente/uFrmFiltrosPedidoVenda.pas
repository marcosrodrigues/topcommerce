unit uFrmFiltrosPedidoVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmFiltrosBase, Buttons, ExtCtrls, StdCtrls, Mask, ComCtrls, DateUtils,
  uFramePesquisaCliente, RxToolEdit;

type
  TFrmFiltrosPedidoVenda = class(TFrmFiltrosBase)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbTipoPagamento: TComboBox;
    FramePesquisaCliente: TFramePesquisaCliente;
    deDataInicial: TDateEdit;
    deDataFinal: TDateEdit;
    Label4: TLabel;
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

  r := TFrmRelPedidoVenda.Create(Self);
  try
    r.DataInicial := DateOf(deDataInicial.Date);
    r.DataFinal   := DateOf(deDataFinal.Date);
    r.TipoPagamento := cbTipoPagamento.ItemIndex;
    r.ClienteCodigo := FramePesquisaCliente.edtCodigoCliente.Text;
    r.RLReport.Preview;
  finally
    r.Free;
  end;
end;

procedure TFrmFiltrosPedidoVenda.FormShow(Sender: TObject);
begin
  inherited;
  deDataInicial.Date := Now;
  deDataFinal.Date   := Now;
end;

procedure TFrmFiltrosPedidoVenda.OnImprimir;
begin
  inherited;

end;

end.
