unit uFrmBaixarContaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmBase, StdCtrls, DXPControl, DXPButtons, Mask, RxToolEdit,
  RxCurrEdit, uContaReceberDAOClient, ContaReceber;

type
  TFrmBaixarContaReceber = class(TFrmBase)
    Label1: TLabel;
    cedValor: TCurrencyEdit;
    Label2: TLabel;
    lbFormaPagamento: TListBox;
    btnBaixar: TDXPButton;
    Label3: TLabel;
    deData: TDateEdit;
    procedure btnBaixarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ContaReceberId: Integer;
    ValorRestante, ValorTotal: Currency;
    Baixou, BaixaTotal: Boolean;
  end;

var
  FrmBaixarContaReceber: TFrmBaixarContaReceber;

implementation

uses MensagensUtils, uFrmPrincipal;

{$R *.dfm}

procedure TFrmBaixarContaReceber.btnBaixarClick(Sender: TObject);
var
  ContaReceberDAO: TContaReceberDAOClient;
  ContaReceber: TContaReceber;
begin
  inherited;
  if deData.Date = 0 then
  begin
    Atencao('Informe a data da baixa.');
    Exit;
  end;

  if cedValor.Value = 0 then
  begin
    Atencao('Informe o valor a ser baixado.');
    Exit;
  end;

  if lbFormaPagamento.ItemIndex = -1 then
  begin
    Atencao('Informe a forma de pagamento.');
    Exit;
  end;

  if cedValor.Value > ValorRestante then
  begin
    Atencao('O valor deste conta a receber é '+FormatCurr(',0.00', ValorRestante));
    Exit;
  end;

  if Confirma('Baixar parcela?') then
  begin
    ContaReceberDAO := TContaReceberDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
    try
      ContaReceber := TContaReceber.Create(ContaReceberId);
      ContaReceber.Valor := ValorTotal;

      BaixaTotal := ContaReceberDAO.BaixarConta(ContaReceber, deData.Date, cedValor.Value, lbFormaPagamento.ItemIndex);
      Baixou := True;
    finally
      ContaReceberDAO.Free;

      Self.Close;
    end;
  end;
end;

end.
