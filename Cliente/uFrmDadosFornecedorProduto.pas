unit uFrmDadosFornecedorProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosBase, StdCtrls, Buttons, ExtCtrls, Mask,
  DBClient, FornecedorProduto, uFramePesquisaFornecedor, DXPCurrencyEdit;

type
  TFrmDadosFornecedorProduto = class(TFrmDadosBase)
    Label5: TLabel;
    FramePesquisaFornecedor: TFramePesquisaFornecedor;
    cedPrecoCompra: TDXPCurrencyEdit;
    procedure FramePesquisaFornecedoredtCodigoFornecedorExit(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    FornecedorProduto: TFornecedorProduto;
  end;

var
  FrmDadosFornecedorProduto: TFrmDadosFornecedorProduto;

implementation

uses StringUtils, MensagensUtils, TypesUtils;

{$R *.dfm}

{ TFrmDadosFornecedorProduto }

procedure TFrmDadosFornecedorProduto.FramePesquisaFornecedoredtCodigoFornecedorExit(Sender: TObject);
var
  cds: TClientDataSet;
begin
  inherited;
  FramePesquisaFornecedor.edtCodigoFornecedorExit(Sender);
  cds := TClientDataSet(Owner.FindComponent('cdsFornecedores'));
  if ( Operacao = opInsert ) and cds.FindKey([FramePesquisaFornecedor.edtCodigoFornecedor.Text]) then
  begin
    Atencao('Este fornecedor já foi inserido.');
    FramePesquisaFornecedor.edtCodigoFornecedor.SetFocus;
    Exit;
  end;
end;

procedure TFrmDadosFornecedorProduto.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([FramePesquisaFornecedor.edtCodigoFornecedor]);
end;

procedure TFrmDadosFornecedorProduto.OnDestroy;
begin
  inherited;

end;

procedure TFrmDadosFornecedorProduto.OnSave;
var
  cds: TClientDataSet;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsFornecedores'));
  if (Operacao = opInsert) then
  begin
    try
      cds.Append;
      cds.FieldByName('CODIGO_FORNECEDOR').AsString := FramePesquisaFornecedor.edtCodigoFornecedor.Text;
      cds.FieldByName('NOME_FORNECEDOR').AsString   := FramePesquisaFornecedor.edtNomeFornecedor.Text;
      cds.FieldByName('PRECO_COMPRA').AsCurrency    := cedPrecoCompra.Value;
      cds.Post;
    except
      Erro('Ocorreu algum erro durante a inclusão.');
    end;
  end
  else
  begin
    try
      cds.Edit;
      cds.FieldByName('CODIGO_FORNECEDOR').AsString := FramePesquisaFornecedor.edtCodigoFornecedor.Text;
      cds.FieldByName('NOME_FORNECEDOR').AsString   := FramePesquisaFornecedor.edtNomeFornecedor.Text;
      cds.FieldByName('PRECO_COMPRA').AsCurrency    := cedPrecoCompra.Value;
      cds.Post;
    except
      Erro('Ocorreu algum erro durante a inclusão.');
    end;
  end;
end;

procedure TFrmDadosFornecedorProduto.OnShow;
begin
  inherited;
  if (Assigned(FornecedorProduto)) then
  begin
    try
      FramePesquisaFornecedor.edtCodigoFornecedor.Text := FornecedorProduto.Fornecedor.Codigo;
      FramePesquisaFornecedor.edtNomeFornecedor.Text   := FornecedorProduto.Fornecedor.Nome;
      cedPrecoCompra.Value     := FornecedorProduto.PrecoCompra;
    finally
      FornecedorProduto.Free;
    end;
  end;
end;

end.
