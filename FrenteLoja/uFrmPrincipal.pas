{TODO -oMarcos -cFrente Loja : Criar tela de ajuda}
unit uFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, jpeg, DB, DBClient, SqlExpr, DBXDataSnap,
  DBXCommon, DBXDBReaders, uPedidoVendaDAOClient, PedidoVenda, ItemPedidoVenda, Produto,
  Generics.Collections, Cliente, pngimage, RLConsts, DXPCurrencyEdit;

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
    cedSubtotal: TDXPCurrencyEdit;
    cdsProdutosDESCONTO_VALOR: TCurrencyField;
    cdsProdutosDESCONTO_PERCENTUAL: TCurrencyField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmHoraTimer(Sender: TObject);
    procedure cdsProdutosDESCONTO_PERCENTUALGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
    DAOPedidoVenda: TPedidoVendaDAOClient;
    CodigoPedidoVendaAtual: string;
    DataPedidoVendaAtual: TDateTime;

    procedure NovaVenda;
    procedure FecharVenda;
    procedure ConsultarProduto;
    procedure GravarVenda(Desconto, DescontoPercentual, Total: Currency; TipoPagamento: Integer; Cliente: TCliente; NomeCliente: string);
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
  uFrmVendasFechadas, uFrmVendasAbertas, uFrmRelReciboVenda,
  uFrmConectandoServidor;

{$R *.dfm}

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Confirma('Deseja sair do Frente de Loja?');
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
  fLoad: TFrmConectandoServidor;
  Direcao: Integer;
begin
  fLoad := TFrmConectandoServidor.Create(Application);
  fLoad.Show;
  Direcao := 1;
  while not ConnServidor.Connected do
  begin
    try
      if (Direcao = 1) then
        fLoad.ProgressBar.Position := fLoad.ProgressBar.Position + 10
      else
        fLoad.ProgressBar.Position := fLoad.ProgressBar.Position - 10;

      if fLoad.ProgressBar.Position = 100 then
        Direcao := -1;
      if fLoad.ProgressBar.Position = 0 then
        Direcao := 1;

      Application.ProcessMessages;
      ConnServidor.Open;

      Break;
    except
      
    end;
  end;
  fLoad.Close;
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

procedure TFrmPrincipal.GravarVenda(Desconto, DescontoPercentual, Total: Currency; TipoPagamento: Integer; Cliente: TCliente; NomeCliente: string);
var
  Pedido: TPedidoVenda;
begin
  Pedido               := TPedidoVenda.Create;
  Pedido.Codigo        := CodigoPedidoVendaAtual;
  Pedido.Data          := DataPedidoVendaAtual;
  Pedido.Desconto      := Desconto;
  Pedido.TipoPagamento := TipoPagamento;
  Pedido.Cliente       := Cliente;
  Pedido.Fechada       := True;
  Pedido.DescontoPercentual := DescontoPercentual;
  Pedido.Total := Total;
  if Cliente = nil then
    Pedido.NomeClienteAvulso := NomeCliente;

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

      cedSubtotal.Value := pedido.Total;

      cdsProdutos.Close;
      cdsProdutos.CreateDataSet;

      for i := 0 to pedido.Itens.Count - 1 do
      begin
        cdsProdutos.Append;
        cdsProdutosCODIGO.AsString := pedido.Itens[i].Produto.Codigo;
        cdsProdutosDESCRICAO.AsString := pedido.Itens[i].Produto.Descricao;
        cdsProdutosQUANTIDADE.AsInteger := pedido.Itens[i].Quantidade;
        cdsProdutosPRECO_UNITARIO.AsCurrency := pedido.Itens[i].Produto.PrecoVenda;
        cdsProdutosDESCONTO_VALOR.AsCurrency := pedido.Itens[i].DescontoValor;
        cdsProdutosDESCONTO_PERCENTUAL.AsCurrency := pedido.Itens[i].DescontoPercentual;
        cdsProdutosPRECO_TOTAL.AsCurrency := pedido.Itens[i].Valor;
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

      cedSubtotal.Value := pedido.Total;

      cdsProdutos.Close;
      cdsProdutos.CreateDataSet;

      for i := 0 to pedido.Itens.Count - 1 do
      begin
        cdsProdutos.Append;
        cdsProdutosCODIGO.AsString := pedido.Itens[i].Produto.Codigo;
        cdsProdutosDESCRICAO.AsString := pedido.Itens[i].Produto.Descricao;
        cdsProdutosQUANTIDADE.AsInteger := pedido.Itens[i].Quantidade;
        cdsProdutosPRECO_UNITARIO.AsCurrency := pedido.Itens[i].Produto.PrecoVenda;
        cdsProdutosDESCONTO_VALOR.AsCurrency := pedido.Itens[i].DescontoValor;
        cdsProdutosDESCONTO_PERCENTUAL.AsCurrency := pedido.Itens[i].DescontoPercentual;
        cdsProdutosPRECO_TOTAL.AsCurrency := pedido.Itens[i].Valor;
        cdsProdutos.Post;
      end;
    end;
  finally
    fVendasFechadas.Free;
  end;
end;

procedure TFrmPrincipal.cdsProdutosDESCONTO_PERCENTUALGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := Sender.AsString + ' %';
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
        fAjuste.cedPrecoUnitario.Value      := fConsultaProdutos.Produto.PrecoVenda;
        fAjuste.edtQuantidade.Text          := '1';
        fAjuste.cedPrecoTotal.Value         := fConsultaProdutos.Produto.PrecoVenda;

        fAjuste.ShowModal;

        edtDescricaoProduto.Text := fConsultaProdutos.Produto.Descricao;
        edtCodigo.Text           := fConsultaProdutos.Produto.Codigo;
        edtQuantidade.Text       := fAjuste.edtQuantidade.Text;
        edtPrecoUnitario.Text    := FormatCurr(',0.00', fConsultaProdutos.Produto.PrecoVenda);
        edtPrecoTotal.Text       := fAjuste.cedPrecoTotal.Text;

        if (cdsProdutos.FindKey([fConsultaProdutos.Produto.Codigo])) then
        begin
          cdsProdutos.Edit;
          if (Confirma('Este produto já se encontra no pedido. Deseja adicionar a quantidade?')) then
          begin
            cdsProdutosQUANTIDADE.AsInteger   := cdsProdutosQUANTIDADE.AsInteger + StrToInt(fAjuste.edtQuantidade.Text);
            cdsProdutosPRECO_TOTAL.AsCurrency := cdsProdutosPRECO_TOTAL.AsCurrency + fAjuste.cedPrecoTotal.Value;

            cedSubtotal.Value := cedSubtotal.Value + fAjuste.cedPrecoTotal.Value;

            Item := TItemPedidoVenda.Create;
            Item.Produto    := TProduto.Create(cdsProdutosCODIGO.AsString);
            Item.Quantidade := cdsProdutosQUANTIDADE.AsInteger;
            DAOPedidoVenda.AtualizaItemDoPedido(CodigoPedidoVendaAtual, Item);

            Pedido := TPedidoVenda.Create;
            Pedido.Codigo := CodigoPedidoVendaAtual;
            Pedido.Data   := DataPedidoVendaAtual;
            Pedido.Total  := cedSubtotal.Value;

            DAOPedidoVenda.Update(Pedido);
          end;
        end
        else
        begin
          cdsProdutos.Append;
          cdsProdutosCODIGO.AsString           := fConsultaProdutos.Produto.Codigo;
          cdsProdutosDESCRICAO.AsString        := fConsultaProdutos.Produto.Descricao;
          cdsProdutosPRECO_UNITARIO.AsCurrency := fConsultaProdutos.Produto.PrecoVenda;
          cdsProdutosQUANTIDADE.AsInteger      := StrToInt(fAjuste.edtQuantidade.Text);
          cdsProdutosDESCONTO_VALOR.AsCurrency := fAjuste.cedDescValor.Value;
          cdsProdutosDESCONTO_PERCENTUAL.AsCurrency := fAjuste.cedDescPercentual.Value;
          cdsProdutosPRECO_TOTAL.AsCurrency    := fAjuste.cedPrecoTotal.Value;

          cedSubtotal.Value := cedSubtotal.Value + cdsProdutosPRECO_TOTAL.AsCurrency;

          if CodigoPedidoVendaAtual = '' then
          begin
            CodigoPedidoVendaAtual := DAOPedidoVenda.NextCodigo;
            DataPedidoVendaAtual := Now;

            Pedido := TPedidoVenda.Create;
            Pedido.Codigo  := CodigoPedidoVendaAtual;
            Pedido.Data    := DataPedidoVendaAtual;
            Pedido.Total   := cedSubtotal.Value;
            Pedido.Fechada := False;

            DAOPedidoVenda.Insert(Pedido);
          end;

          Item := TItemPedidoVenda.Create;
          Item.Produto    := TProduto.Create(cdsProdutosCODIGO.AsString);
          Item.Quantidade := cdsProdutosQUANTIDADE.AsInteger;
          Item.DescontoValor := cdsProdutosDESCONTO_VALOR.AsCurrency;
          Item.DescontoPercentual := cdsProdutosDESCONTO_PERCENTUAL.AsCurrency;
          Item.Valor := cdsProdutosPRECO_TOTAL.AsCurrency;
          DAOPedidoVenda.InsertItemNoPedido(CodigoPedidoVendaAtual, Item);

          Pedido := TPedidoVenda.Create;
          Pedido.Codigo := CodigoPedidoVendaAtual;
          Pedido.Data   := DataPedidoVendaAtual;
          Pedido.Total  := cedSubtotal.Value;

          DAOPedidoVenda.Update(Pedido);
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
      cedSubtotal.Value := cedSubtotal.Value - cdsProdutosQUANTIDADE.AsInteger * cdsProdutosPRECO_UNITARIO.AsCurrency;

      DAOPedidoVenda.DeleteItemDoPedido(cdsProdutosCODIGO.AsString, CodigoPedidoVendaAtual);
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
begin
  if cdsProdutos.RecordCount <= 0 then
  begin
    Atencao('Ainda não foi incluído nenhum item na venda.');
    Exit;
  end;
  edtAvisos.Text := 'FECHAR VENDA';
  f := TFrmFecharVenda.Create(Self);
  try
    f.cedTotal.Value := cedSubtotal.Value;
    f.Total         := cedSubtotal.Value;
    f.ShowModal;

    if (f.Fechar) then
    begin
      GravarVenda(f.cedDescontoValor.Value, f.cedDescontoPercentual.Value, f.cedTotal.Value, f.cbFormaPagamento.ItemIndex, f.Cliente, f.NomeCliente);

      recibo := TFrmRelReciboVenda.Create(Self);
      try
        recibo.CodigoVenda := CodigoPedidoVendaAtual;
        recibo.RLReport.Print;
      finally
        recibo.Free;
      end;
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
  cedSubtotal.Value := 0;
  edtAvisos.Text := 'VENDA';

  lblData.Caption := FormatDateTime('dd/mm/yyyy', Now);
  tmHora.Enabled  := True;

  cdsProdutos.CreateDataSet;
end;

initialization
  RLConsts.SetVersion(3,71,'B');

end.
