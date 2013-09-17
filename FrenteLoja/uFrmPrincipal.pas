{TODO -oMarcos -cFrente Loja : Criar tela de ajuda}
unit uFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, jpeg, DB, DBClient, SqlExpr, DBXDataSnap,
  DBXCommon, DBXDBReaders, uPedidoVendaDAOClient, PedidoVenda, ItemPedidoVenda, Produto,
  Generics.Collections, Cliente, pngimage, RLConsts;

type
  TFrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    pnlGrid: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel5: TPanel;
    Label5: TLabel;
    Image2: TImage;
    Panel6: TPanel;
    grdProdutos: TDBGrid;
    Panel7: TPanel;
    edtCodigo: TEdit;
    Panel8: TPanel;
    edtQuantidade: TEdit;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    edtSubtotal: TEdit;
    dsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    ConnServidor: TSQLConnection;
    cdsProdutosCODIGO: TStringField;
    cdsProdutosDESCRICAO: TStringField;
    cdsProdutosQUANTIDADE: TIntegerField;
    cdsProdutosPRECO_UNITARIO: TCurrencyField;
    cdsProdutosPRECO_TOTAL: TCurrencyField;
    edtPrecoUnitario: TEdit;
    edtPrecoTotal: TEdit;
    Label6: TLabel;
    Panel12: TPanel;
    edtAvisos: TEdit;
    Panel13: TPanel;
    edtDescricaoProduto: TEdit;
    lblData: TLabel;
    lblHora: TLabel;
    tmHora: TTimer;
    imgCalendario: TImage;
    imgRelogio: TImage;
    Memo1: TMemo;
    Panel14: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmHoraTimer(Sender: TObject);
  private
    { Private declarations }
    DAOPedidoVenda: TPedidoVendaDAOClient;
    CodigoPedidoVendaAtual: string;
    DataPedidoVendaAtual: TDateTime;

    procedure NovaVenda;
    procedure FecharVenda;
    procedure ConsultarProduto;
    function GravarVenda(Desconto: Currency; TipoPagamento: Integer; Cliente: TCliente; NomeCliente: string): string;
    procedure ExcluirItem;
    procedure IniciaControles;
    procedure VendasFechadas;
    procedure VendasAbertas;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses uFrmConsultaProdutos, uFrmAjuste, uFrmFecharVenda, uFrmExcluirItem, MensagensUtils,
  uFrmVendasFechadas, uFrmVendasAbertas, uFrmRelReciboVenda;

{$R *.dfm}

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Confirma('Deseja sair do Frente de Loja?');
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  ConnServidor.Open;
  DAOPedidoVenda := TPedidoVendaDAOClient.Create(ConnServidor.DBXConnection);
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  DAOPedidoVenda.Free;
end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F2: NovaVenda;
    VK_F3: FecharVenda;
    VK_F5: ExcluirItem;
    VK_F6: ConsultarProduto;
    VK_F8: VendasAbertas;
    VK_F9: VendasFechadas;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  r: TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @r,0);
  SetBounds(r.Left, r.Top, r.Right-r.Left, r.Bottom-r.Top);

  IniciaControles;
end;

function TFrmPrincipal.GravarVenda(Desconto: Currency; TipoPagamento: Integer; Cliente: TCliente; NomeCliente: string): string;
var
  Pedido: TPedidoVenda;
  //Item: TItemPedidoVenda;
begin
  Pedido               := TPedidoVenda.Create;

  //Result := DAOPedidoVenda.NextCodigo;

  Pedido.Codigo        := CodigoPedidoVendaAtual;
  Pedido.Data          := DataPedidoVendaAtual;
  Pedido.Desconto      := Desconto;
  Pedido.TipoPagamento := TipoPagamento;
  Pedido.Cliente       := Cliente;
  Pedido.Fechada       := True;
  if Cliente = nil then
    Pedido.NomeClienteAvulso := NomeCliente;

  {cdsProdutos.First;
  cdsProdutos.DisableControls;
  Pedido.Itens := TList<TItemPedidoVenda>.Create;
  while not(cdsProdutos.Eof) do
  begin
    Item := TItemPedidoVenda.Create;
    Item.Produto    := TProduto.Create(cdsProdutosCODIGO.AsString);
    Item.Quantidade := cdsProdutosQUANTIDADE.AsInteger;
    Pedido.Itens.Add(Item);

    cdsProdutos.Next;
  end;
  cdsProdutos.EnableControls;}

  DAOPedidoVenda.Update(Pedido);
end;

procedure TFrmPrincipal.NovaVenda;
begin
  cdsProdutos.Close;

  IniciaControles;
  CodigoPedidoVendaAtual := '';
  DataPedidoVendaAtual := 0;
end;

procedure TFrmPrincipal.tmHoraTimer(Sender: TObject);
begin
  lblHora.Caption := FormatDateTime('hh:mm:ss', Now);
end;

procedure TFrmPrincipal.VendasAbertas;
var
  fVendasAbertas: TFrmVendasAbertas;
  pedido: TPedidoVenda;
  i: Integer;
begin
  fVendasAbertas := TFrmVendasAbertas.Create(Self);
  try
    fVendasAbertas.ShowModal;

    if fVendasAbertas.ModalResult = mrOk then
    begin
      pedido := DAOPedidoVenda.FindByCodigo(fVendasAbertas.cdsConsultaCODIGO.AsString);

      CodigoPedidoVendaAtual := pedido.Codigo;
      DataPedidoVendaAtual := pedido.Data;

      cdsProdutos.Close;
      cdsProdutos.CreateDataSet;

      for i := 0 to pedido.Itens.Count - 1 do
      begin
        cdsProdutos.Append;
        cdsProdutosCODIGO.AsString := pedido.Itens[i].Produto.Codigo;
        cdsProdutosDESCRICAO.AsString := pedido.Itens[i].Produto.Descricao;
        cdsProdutosQUANTIDADE.AsInteger := pedido.Itens[i].Quantidade;
        cdsProdutosPRECO_UNITARIO.AsCurrency := pedido.Itens[i].Produto.PrecoVenda;
        cdsProdutosPRECO_TOTAL.AsCurrency := cdsProdutosQUANTIDADE.AsInteger * cdsProdutosPRECO_UNITARIO.AsCurrency;
        cdsProdutos.Post;
      end;
    end;
  finally
    fVendasAbertas.Free;
  end;
end;

procedure TFrmPrincipal.VendasFechadas;
var
  fVendasFechadas: TFrmVendasFechadas;
  pedido: TPedidoVenda;
  i: Integer;
begin
  fVendasFechadas := TFrmVendasFechadas.Create(Self);
  try
    fVendasFechadas.ShowModal;

    if fVendasFechadas.ModalResult = mrOk then
    begin
      pedido := DAOPedidoVenda.FindByCodigo(fVendasFechadas.cdsConsultaCODIGO.AsString);

      CodigoPedidoVendaAtual := pedido.Codigo;
      DataPedidoVendaAtual := pedido.Data;

      cdsProdutos.Close;
      cdsProdutos.CreateDataSet;

      for i := 0 to pedido.Itens.Count - 1 do
      begin
        cdsProdutos.Append;
        cdsProdutosCODIGO.AsString := pedido.Itens[i].Produto.Codigo;
        cdsProdutosDESCRICAO.AsString := pedido.Itens[i].Produto.Descricao;
        cdsProdutosQUANTIDADE.AsInteger := pedido.Itens[i].Quantidade;
        cdsProdutosPRECO_UNITARIO.AsCurrency := pedido.Itens[i].Produto.PrecoVenda;
        cdsProdutosPRECO_TOTAL.AsCurrency := cdsProdutosQUANTIDADE.AsInteger * cdsProdutosPRECO_UNITARIO.AsCurrency;
        cdsProdutos.Post;
      end;
    end;
  finally
    fVendasFechadas.Free;
  end;
end;

procedure TFrmPrincipal.ConsultarProduto;
var
  fConsultaProdutos: TFrmConsultaProdutos;
  fAjuste: TFrmAjuste;
  Item: TItemPedidoVenda;
  Pedido: TPedidoVenda;
begin
  edtAvisos.Text := 'CONSULTAR PRODUTO';
  fConsultaProdutos := TFrmConsultaProdutos.Create(Self);
  try
    fConsultaProdutos.ShowModal;
    if (Assigned(fConsultaProdutos.Produto)) then
    begin
      fAjuste := TFrmAjuste.Create(Self);
      try
        fAjuste.lblDescricaoProduto.Caption := fConsultaProdutos.Produto.Descricao;
        fAjuste.edtPrecoUnitario.Text       := FormatCurr(',0.00', fConsultaProdutos.Produto.PrecoVenda);
        fAjuste.edtQuantidade.Text          := '1';
        fAjuste.edtPrecoTotal.Text          := FormatCurr(',0.00', fConsultaProdutos.Produto.PrecoVenda);

        fAjuste.ShowModal;

        edtDescricaoProduto.Text := fConsultaProdutos.Produto.Descricao;
        edtCodigo.Text           := fConsultaProdutos.Produto.Codigo;
        edtQuantidade.Text       := fAjuste.edtQuantidade.Text;
        edtPrecoUnitario.Text    := FormatCurr(',0.00', fConsultaProdutos.Produto.PrecoVenda);
        edtPrecoTotal.Text       := fAjuste.edtPrecoTotal.Text;

        if (cdsProdutos.FindKey([fConsultaProdutos.Produto.Codigo])) then
        begin
          cdsProdutos.Edit;
          if (Confirma('Este produto já se encontra no pedido. Deseja adicionar a quantidade?')) then
          begin
            cdsProdutosQUANTIDADE.AsInteger   := cdsProdutosQUANTIDADE.AsInteger + StrToInt(fAjuste.edtQuantidade.Text);
            cdsProdutosPRECO_TOTAL.AsCurrency := cdsProdutosPRECO_TOTAL.AsCurrency + StrToCurr(fAjuste.edtPrecoTotal.Text);

            edtSubtotal.Text   := FormatCurr(',0.00', StrToCurr(edtSubtotal.Text) + StrToInt(fAjuste.edtQuantidade.Text) * cdsProdutosPRECO_UNITARIO.AsCurrency);

            Item := TItemPedidoVenda.Create;
            Item.Produto    := TProduto.Create(cdsProdutosCODIGO.AsString);
            Item.Quantidade := cdsProdutosQUANTIDADE.AsInteger;
            DAOPedidoVenda.AtualizaItemDoPedido(CodigoPedidoVendaAtual, Item);
          end;
        end
        else
        begin
          cdsProdutos.Append;
          cdsProdutosCODIGO.AsString           := fConsultaProdutos.Produto.Codigo;
          cdsProdutosDESCRICAO.AsString        := fConsultaProdutos.Produto.Descricao;
          cdsProdutosQUANTIDADE.AsInteger      := StrToInt(fAjuste.edtQuantidade.Text);
          cdsProdutosPRECO_UNITARIO.AsCurrency := fConsultaProdutos.Produto.PrecoVenda;
          cdsProdutosPRECO_TOTAL.AsCurrency    := StrToCurr(fAjuste.edtPrecoTotal.Text);

          edtSubtotal.Text := FormatCurr(',0.00', StrToCurr(edtSubtotal.Text) + cdsProdutosQUANTIDADE.AsInteger * cdsProdutosPRECO_UNITARIO.AsCurrency);

          if CodigoPedidoVendaAtual = '' then
          begin
            CodigoPedidoVendaAtual := DAOPedidoVenda.NextCodigo;
            DataPedidoVendaAtual := Now;

            Pedido := TPedidoVenda.Create;
            Pedido.Codigo := CodigoPedidoVendaAtual;
            Pedido.Data    := DataPedidoVendaAtual;
            Pedido.Fechada := False;

            DAOPedidoVenda.Insert(Pedido);
          end;

          Item := TItemPedidoVenda.Create;
          Item.Produto    := TProduto.Create(cdsProdutosCODIGO.AsString);
          Item.Quantidade := cdsProdutosQUANTIDADE.AsInteger;
          DAOPedidoVenda.InsertItemNoPedido(CodigoPedidoVendaAtual, Item);
        end;
        cdsProdutos.Post;

      finally
        fAjuste.Free;
      end;
    end;
  finally
    fConsultaProdutos.Free;
  end;
  edtAvisos.Text := 'VENDA';
end;

procedure TFrmPrincipal.ExcluirItem;
var
  f: TFrmExcluirItem;
begin
  if cdsProdutos.RecordCount <= 0 then
  begin
    Atencao('Ainda não foi incluído nenhum item na venda.');
    Exit;
  end;
  edtAvisos.Text := 'EXCLUIR ITEM';
  f := TFrmExcluirItem.Create(Self);
  try
    f.ShowModal;

    if (f.Excluir) then
    begin
      edtSubtotal.Text := FormatCurr(',0.00', StrToCurr(edtSubtotal.Text) - cdsProdutosQUANTIDADE.AsInteger * cdsProdutosPRECO_UNITARIO.AsCurrency);

      cdsProdutos.Delete;
    end;

    edtAvisos.Text := 'VENDA';
  finally
    f.Free;
  end;
end;

procedure TFrmPrincipal.FecharVenda;
var
  f: TFrmFecharVenda;
  recibo: TFrmRelReciboVenda;
  CodigoVenda: string;
begin
  if cdsProdutos.RecordCount <= 0 then
  begin
    Atencao('Ainda não foi incluído nenhum item na venda.');
    Exit;
  end;
  edtAvisos.Text := 'FECHAR VENDA';
  f := TFrmFecharVenda.Create(Self);
  try
    f.edtTotal.Text := edtSubtotal.Text;
    f.Total         := StrToCurr(edtSubtotal.Text);
    f.ShowModal;

    if (f.Fechar) then
    begin
      CodigoVenda := GravarVenda(f.cedDescontoValor.Value, f.cbFormaPagamento.ItemIndex, f.Cliente, f.NomeCliente);

      recibo := TFrmRelReciboVenda.Create(Self);
      try
        recibo.CodigoVenda := CodigoVenda;
        recibo.RLReport.Preview;
      finally
        recibo.Free;
      end;
      
      //NovaVenda;
      //edtAvisos.Text := 'VENDA';
    end;
  finally
    f.Free;
  end;
end;

procedure TFrmPrincipal.IniciaControles;
begin
  edtDescricaoProduto.Clear;
  edtCodigo.Clear;
  edtQuantidade.Clear;
  edtPrecoUnitario.Clear;
  edtPrecoTotal.Clear;
  edtSubtotal.Text := '0,00';
  edtAvisos.Text := 'VENDA';

  lblData.Caption := FormatDateTime('dd/mm/yyyy', Now);
  tmHora.Enabled  := True;

  cdsProdutos.CreateDataSet;
end;

initialization
  RLConsts.SetVersion(3,71,'B');

end.
