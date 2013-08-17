unit uFramePesquisaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, uProdutoDAOClient;

type
  TFramePesquisaProduto = class(TFrame)
    Label3: TLabel;
    edtCodigoProduto: TEdit;
    bbtConsultarProduto: TBitBtn;
    edtDescricaoProduto: TEdit;
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure edtCodigoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bbtConsultarProdutoClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConsultaProduto;
  public
    { Public declarations }
  end;

implementation

uses StringUtils, uFrmConsultaProduto, uFrmPrincipal;

{$R *.dfm}

{ TFramePesquisaProduto }

procedure TFramePesquisaProduto.bbtConsultarProdutoClick(Sender: TObject);
var
  f: TFrmConsultaProduto;
begin
  f := TFrmConsultaProduto.Create(Self);
  try
    f.ShowModal;
    if (Assigned(f.Produto)) then
    begin
      edtCodigoProduto.Text    := f.Produto.Codigo;
      edtDescricaoProduto.Text := f.Produto.Descricao;
    end;
  finally
    f.Free;
  end;
end;

procedure TFramePesquisaProduto.ConsultaProduto;
var
  DAOClient: TProdutoDAOClient;
begin
  if (edtCodigoProduto.Text <> '') then
  begin
    DAOClient := TProdutoDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
    try
      edtCodigoProduto.Text    := StrZero(StrToInt(edtCodigoProduto.Text), 6);
      edtDescricaoProduto.Text := DAOClient.FindByCodigo(edtCodigoProduto.Text).Descricao;
    finally
      DAOClient.Free;
    end;
  end
  else
    edtDescricaoProduto.Clear;
end;

procedure TFramePesquisaProduto.edtCodigoProdutoExit(Sender: TObject);
begin
  ConsultaProduto;
end;

procedure TFramePesquisaProduto.edtCodigoProdutoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Ord(Key) = 13) then
    ConsultaProduto;
end;

end.
