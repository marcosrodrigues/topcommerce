unit uFramePesquisaTipoProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Buttons, uTipoProdutoDAOClient;

type
  TFramePesquisaTipoProduto = class(TFrame)
    Label3: TLabel;
    edtCodigoTipoProduto: TEdit;
    bbtConsultarTipoProduto: TBitBtn;
    edtDescricaoTipoProduto: TEdit;
    procedure bbtConsultarTipoProdutoClick(Sender: TObject);
    procedure edtCodigoTipoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoTipoProdutoExit(Sender: TObject);
  private
    { Private declarations }
    procedure ConsultaTipoProduto;
  public
    { Public declarations }
  end;

implementation

uses uFrmConsultaTipoProduto, StringUtils, uFrmPrincipal;

{$R *.dfm}

procedure TFramePesquisaTipoProduto.bbtConsultarTipoProdutoClick(Sender: TObject);
var
  f: TFrmConsultaTipoProduto;
begin
  f := TFrmConsultaTipoProduto.Create(Self);
  try
    f.ShowModal;
    if (Assigned(f.TipoProduto)) then
    begin
      edtCodigoTipoProduto.Text    := f.TipoProduto.Codigo;
      edtDescricaoTipoProduto.Text := f.TipoProduto.Descricao;
    end;
  finally
    f.Free;
  end;
end;

procedure TFramePesquisaTipoProduto.ConsultaTipoProduto;
var
  DAOClientTipoProduto: TTipoProdutoDAOClient;
begin
  if (edtCodigoTipoProduto.Text <> '') then
  begin
    DAOClientTipoProduto := TTipoProdutoDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
    try
      edtCodigoTipoProduto.Text    := StrZero(StrToInt(edtCodigoTipoProduto.Text), 3);
      edtDescricaoTipoProduto.Text := DAOClientTipoProduto.FindByCodigo(edtCodigoTipoProduto.Text).Descricao;
    finally
      DAOClientTipoProduto.Free;
    end;
  end
  else
    edtDescricaoTipoProduto.Clear;
end;

procedure TFramePesquisaTipoProduto.edtCodigoTipoProdutoExit(Sender: TObject);
begin
  ConsultaTipoProduto;
end;

procedure TFramePesquisaTipoProduto.edtCodigoTipoProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Ord(Key) = 13) then
    ConsultaTipoProduto;
end;

end.
