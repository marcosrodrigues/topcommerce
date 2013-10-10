unit uFrmDadosProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFrmDadosMasterDetailBase, ComCtrls, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, Produto, TipoProduto, DBClient, uProdutoDAOClient, Mask,
  Spin, uEstoqueDAOClient, Estoque, DB, FornecedorProduto,
  Generics.Collections, Fornecedor, uFramePesquisaTipoProduto, Validade,
  DXPCurrencyEdit, RxToolEdit, RxCurrEdit;

type
  TFrmDadosProduto = class(TFrmDadosMasterDetailBase)
    tbsFornecedores: TTabSheet;
    grdFornecedores: TDBGrid;
    Label1: TLabel;
    edtCodigo: TEdit;
    Label4: TLabel;
    edtCodigoBarras: TEdit;
    dsFornecedores: TDataSource;
    cdsFornecedores: TClientDataSet;
    cdsFornecedoresCODIGO_FORNECEDOR: TStringField;
    cdsFornecedoresNOME_FORNECEDOR: TStringField;
    cdsFornecedoresPRECO_COMPRA: TCurrencyField;
    bbtGerarCodigoBarras: TBitBtn;
    Label2: TLabel;
    edtDescricao: TEdit;
    Label5: TLabel;
    gbEstoque: TGroupBox;
    Label6: TLabel;
    sedQuantidadeEstoque: TSpinEdit;
    FramePesquisaTipoProduto: TFramePesquisaTipoProduto;
    tbsValidades: TTabSheet;
    grdValidades: TDBGrid;
    Panel1: TPanel;
    dsValidades: TDataSource;
    cdsValidades: TClientDataSet;
    cdsValidadesDATA: TDateTimeField;
    Label3: TLabel;
    sedEstoqueMinimo: TSpinEdit;
    Label7: TLabel;
    edtEndereco: TEdit;
    cedPrecoVenda: TCurrencyEdit;
    Label8: TLabel;
    cedMargemLucro: TCurrencyEdit;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    cedDescontoMaximoValor: TCurrencyEdit;
    Label10: TLabel;
    cedDescontoMaximoPercentual: TCurrencyEdit;
    Label11: TLabel;
    Label12: TLabel;
    procedure sbtNovoClick(Sender: TObject);
    procedure sbtEditarClick(Sender: TObject);
    procedure sbtExcluirClick(Sender: TObject);
    procedure bbtGerarCodigoBarrasClick(Sender: TObject);
    procedure edtCodigoBarrasExit(Sender: TObject);
    procedure cedMargemLucroExit(Sender: TObject);
    procedure cdsFornecedoresAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
    DAOClient: TProdutoDAOClient;
    DAOClientEstoque: TEstoqueDAOClient;

    QuantidadeAnterior: Integer;

    function MaiorPrecoCompra: Currency;
    procedure CalculaPrecoVendaComMargemLucro;
  protected
    procedure OnCreate; override;
    procedure OnDestroy; override;
    procedure OnSave; override;
    procedure OnShow; override;
  public
    { Public declarations }
    Produto: TProduto;
  end;

var
  FrmDadosProduto: TFrmDadosProduto;

implementation

uses MensagensUtils, TypesUtils, StringUtils, uFrmDadosFornecedorProduto,
  ufrmDadosValidade;

{$R *.dfm}

{ TFrmDadosProduto }

procedure TFrmDadosProduto.bbtGerarCodigoBarrasClick(Sender: TObject);
begin
  inherited;
  edtCodigoBarras.Text := DAOClient.NextCodigoBarras;
end;

procedure TFrmDadosProduto.CalculaPrecoVendaComMargemLucro;
var
  precoCompra: Currency;
begin
  if (cedMargemLucro.Value > 0) and (cedPrecoVenda.Value = 0) and not(cdsFornecedores.IsEmpty) then
  begin
    precoCompra := MaiorPrecoCompra;

    cedPrecoVenda.Value := precoCompra + (precoCompra * (cedMargemLucro.Value / 100));
  end;
end;

procedure TFrmDadosProduto.cdsFornecedoresAfterPost(DataSet: TDataSet);
begin
  inherited;
  CalculaPrecoVendaComMargemLucro;
end;

procedure TFrmDadosProduto.cedMargemLucroExit(Sender: TObject);
begin
  inherited;
  CalculaPrecoVendaComMargemLucro;
end;

procedure TFrmDadosProduto.edtCodigoBarrasExit(Sender: TObject);
begin
  inherited;
  if (Operacao = opInsert) and (edtCodigoBarras.Text <> '') and (DAOClient.ExisteCodigoBarras(edtCodigoBarras.Text)) then
  begin
    Atencao('Já existe um produto cadastrado com este código de barras.');
    edtCodigoBarras.SetFocus;
  end;
end;

function TFrmDadosProduto.MaiorPrecoCompra: Currency;
begin
  cdsFornecedores.DisableControls;

  cdsFornecedores.IndexFieldNames := 'PRECO_COMPRA';

  Result := cdsFornecedoresPRECO_COMPRA.AsCurrency;

  cdsFornecedores.IndexFieldNames := 'CODIGO_FORNECEDOR';

  cdsFornecedores.EnableControls;
end;

procedure TFrmDadosProduto.OnCreate;
begin
  inherited;
  SetCamposObrigatorios([edtDescricao, FramePesquisaTipoProduto.edtCodigoTipoProduto]);
  DAOClient            := TProdutoDAOClient.Create(DBXConnection);
  DAOClientEstoque     := TEstoqueDAOClient.Create(DBXConnection);
end;

procedure TFrmDadosProduto.OnDestroy;
begin
  inherited;
  DAOClient.Free;
  DAOClientEstoque.Free;
end;

procedure TFrmDadosProduto.OnSave;
var
  cds: TClientDataSet;
  Produto: TProduto;
begin
  inherited;
  cds := TClientDataSet(Owner.FindComponent('cdsCrud'));

  Produto := TProduto.Create(edtCodigo.Text,
                             TTipoProduto.Create(FramePesquisaTipoProduto.edtCodigoTipoProduto.Text,
                             FramePesquisaTipoProduto.edtDescricaoTipoProduto.Text),
                             edtDescricao.Text,
                             edtCodigoBarras.Text,
                             cedPrecoVenda.Value,
                             sedEstoqueMinimo.Value,
                             nil,
                             nil,
                             edtEndereco.Text,
                             cedMargemLucro.Value,
                             cedDescontoMaximoValor.Value,
                             cedDescontoMaximoPercentual.Value);

  cdsFornecedores.DisableControls;
  cdsFornecedores.First;
  Produto.Fornecedores := TList<TFornecedorProduto>.Create;
  while not(cdsFornecedores.Eof) do
  begin
    Produto.Fornecedores.Add(TFornecedorProduto.Create(TFornecedor.Create(cdsFornecedoresCODIGO_FORNECEDOR.AsString,
                                                                          cdsFornecedoresNOME_FORNECEDOR.AsString,
                                                                          ''),
                                                       cdsFornecedoresPRECO_COMPRA.AsCurrency));
    cdsFornecedores.Next;
  end;
  cdsFornecedores.EnableControls;

  cdsValidades.DisableControls;
  cdsValidades.First;
  Produto.Validades := TList<TValidade>.Create;
  while not(cdsValidades.Eof) do
  begin
    Produto.Validades.Add(TValidade.Create(cdsValidadesDATA.AsDateTime));
    cdsValidades.Next;
  end;
  cdsValidades.EnableControls;

  if (Operacao = opInsert) then
  begin
    edtCodigo.Text := DAOClient.NextCodigo;
    Produto.Codigo := edtCodigo.Text;

    if (DAOClient.Insert(Produto)) then
      DAOClientEstoque.Insert(TEstoque.Create(TProduto.Create(edtCodigo.Text), sedQuantidadeEstoque.Value))
    else
      Erro('Ocorreu algum erro durante a inclusão.');

    cds.Append;
    cds.FieldByName('CODIGO').AsString                 := edtCodigo.Text;
    cds.FieldByName('DESCRICAO').AsString              := edtDescricao.Text;
    cds.FieldByName('CODIGO_TIPO_PRODUTO').AsString    := FramePesquisaTipoProduto.edtCodigoTipoProduto.Text;
    cds.FieldByName('DESCRICAO_TIPO_PRODUTO').AsString := FramePesquisaTipoProduto.edtDescricaoTipoProduto.Text;
    cds.FieldByName('CODIGO_BARRAS').AsString          := edtCodigoBarras.Text;
    cds.FieldByName('MARGEM_LUCRO').AsCurrency         := cedMargemLucro.Value;
    cds.FieldByName('PRECO_VENDA').AsCurrency          := cedPrecoVenda.Value;
    cds.FieldByName('DESCONTO_MAXIMO_VALOR').AsCurrency := cedDescontoMaximoValor.Value;
    cds.FieldByName('DESCONTO_MAXIMO_PERCENTUAL').AsCurrency := cedDescontoMaximoPercentual.Value;
    cds.FieldByName('QUANTIDADE').AsInteger            := sedQuantidadeEstoque.Value;
    cds.FieldByName('ESTOQUE_MINIMO').AsInteger        := sedEstoqueMinimo.Value;
    cds.FieldByName('ENDERECO').AsString               := edtEndereco.Text;
    cds.Post;

    if chbContinuarIncluindo.Checked then
    begin
      cdsFornecedores.EmptyDataSet;
      cdsValidades.EmptyDataSet;
    end;
  end
  else
  begin
    if (DAOClient.Update(Produto)) then
    begin
      if (QuantidadeAnterior <> sedQuantidadeEstoque.Value) then
        DAOClientEstoque.Update(TEstoque.Create(TProduto.Create(edtCodigo.Text), sedQuantidadeEstoque.Value));
    end
    else
      Erro('Ocorreu algum erro durante a alteração.');

    cds.Edit;
    cds.FieldByName('CODIGO').AsString                 := edtCodigo.Text;
    cds.FieldByName('DESCRICAO').AsString              := edtDescricao.Text;
    cds.FieldByName('CODIGO_TIPO_PRODUTO').AsString    := FramePesquisaTipoProduto.edtCodigoTipoProduto.Text;
    cds.FieldByName('DESCRICAO_TIPO_PRODUTO').AsString := FramePesquisaTipoProduto.edtDescricaoTipoProduto.Text;
    cds.FieldByName('CODIGO_BARRAS').AsString          := edtCodigoBarras.Text;
    cds.FieldByName('MARGEM_LUCRO').AsCurrency         := cedMargemLucro.Value;
    cds.FieldByName('PRECO_VENDA').AsCurrency          := cedPrecoVenda.Value;
    cds.FieldByName('DESCONTO_MAXIMO_VALOR').AsCurrency := cedDescontoMaximoValor.Value;
    cds.FieldByName('DESCONTO_MAXIMO_PERCENTUAL').AsCurrency := cedDescontoMaximoPercentual.Value;
    cds.FieldByName('QUANTIDADE').AsInteger            := sedQuantidadeEstoque.Value;
    cds.FieldByName('ESTOQUE_MINIMO').AsInteger        := sedEstoqueMinimo.Value;
    cds.FieldByName('ENDERECO').AsString               := edtEndereco.Text;
    cds.Post;
  end;
end;

procedure TFrmDadosProduto.OnShow;
var
  Fornecedor: TFornecedorProduto;
  Validade: TValidade;
begin
  inherited;
  cdsFornecedores.CreateDataSet;
  cdsValidades.CreateDataSet;
  if (Assigned(Produto)) then
  begin
    try
      edtCodigo.Text               := Produto.Codigo;
      edtDescricao.Text            := Produto.Descricao;
      FramePesquisaTipoProduto.edtCodigoTipoProduto.Text    := Produto.TipoProduto.Codigo;
      FramePesquisaTipoProduto.edtDescricaoTipoProduto.Text := Produto.TipoProduto.Descricao;
      edtCodigoBarras.Text         := Produto.CodigoBarras;
      cedMargemLucro.Value         := Produto.MargemLucro;
      cedPrecoVenda.Value          := Produto.PrecoVenda;
      edtEndereco.Text             := Produto.Endereco;
      cedDescontoMaximoValor.Value := Produto.DescontoMaximoValor;
      cedDescontoMaximoPercentual.Value := Produto.DescontoMaximoPercentual;
      sedEstoqueMinimo.Value       := Produto.EstoqueMinimo;
      sedQuantidadeEstoque.Value   := Produto.QuantidadeEstoque;

      QuantidadeAnterior           := Produto.QuantidadeEstoque;

      for Fornecedor in DAOClient.ListFornecedoresByProduto(Produto.Codigo) do
      begin
        cdsFornecedores.Append;
        cdsFornecedoresCODIGO_FORNECEDOR.AsString := Fornecedor.Fornecedor.Codigo;
        cdsFornecedoresNOME_FORNECEDOR.AsString   := Fornecedor.Fornecedor.Nome;
        cdsFornecedoresPRECO_COMPRA.AsCurrency    := Fornecedor.PrecoCompra;
        cdsFornecedores.Post;
      end;
      cdsFornecedores.First;

      for Validade in DAOClient.ListValidadesByProduto(Produto.Codigo) do
      begin
        cdsValidades.Append;
        cdsValidadesDATA.AsDateTime := Validade.Data;
        cdsValidades.Post;
      end;
      cdsValidades.First;
    finally
      Produto.Free;
    end;
  end;
end;

procedure TFrmDadosProduto.sbtNovoClick(Sender: TObject);
var
  fFornecedor: TFrmDadosFornecedorProduto;
  fValidade: TFrmDadosValidade;
begin
  inherited;
  case pgcDetail.ActivePageIndex of
    0: begin
         fFornecedor := TFrmDadosFornecedorProduto.Create(Self);
         try
           fFornecedor.Operacao := opInsert;
           fFornecedor.ShowModal;
         finally
           fFornecedor.Free;
         end;
       end;
    1: begin
         fValidade := TFrmDadosValidade.Create(Self);
         try
           fValidade.Operacao := opInsert;
           fValidade.ShowModal;
         finally
           fValidade.Free;
         end;
       end;
  end;
end;

procedure TFrmDadosProduto.sbtEditarClick(Sender: TObject);
var
  fFornecedor: TFrmDadosFornecedorProduto;
  fValidade: TFrmDadosValidade;
begin
  inherited;
  case pgcDetail.ActivePageIndex of
    0: begin
         fFornecedor := TFrmDadosFornecedorProduto.Create(Self);
         try
           fFornecedor.FornecedorProduto                   := TFornecedorProduto.Create;
           fFornecedor.FornecedorProduto.Fornecedor        := TFornecedor.Create;
           fFornecedor.FornecedorProduto.Fornecedor.Codigo := cdsFornecedoresCODIGO_FORNECEDOR.AsString;
           fFornecedor.FornecedorProduto.Fornecedor.Nome   := cdsFornecedoresNOME_FORNECEDOR.AsString;
           fFornecedor.FornecedorProduto.PrecoCompra       := cdsFornecedoresPRECO_COMPRA.AsCurrency;

           fFornecedor.Operacao := opEdit;
           fFornecedor.ShowModal;
         finally
           fFornecedor.Free;
         end;
       end;
    1: begin
         fValidade := TFrmDadosValidade.Create(Self);
         try
           fValidade.Validade      := TValidade.Create;
           fValidade.Validade.Data := cdsValidadesDATA.AsDateTime;

           fValidade.Operacao := opEdit;
           fValidade.ShowModal;
         finally
           fValidade.Free;
         end;
       end;
    end;
end;

procedure TFrmDadosProduto.sbtExcluirClick(Sender: TObject);
begin
  inherited;
  case pgcDetail.ActivePageIndex of
    0: cdsFornecedores.Delete;
    1: cdsValidades.Delete;
  end;
end;

end.
