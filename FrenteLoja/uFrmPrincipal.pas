{TODO -oMarcos -cFrente Loja : Criar tela de ajuda}
unit uFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, jpeg, DB, DBClient, SqlExpr, DBXDataSnap,
  DBXCommon, DBXDBReaders, uPedidoVendaDAOClient, PedidoVenda, ItemPedidoVenda, Produto,
  Generics.Collections, Cliente, pngimage, RLConsts, DXPCurrencyEdit,
  ImageButton4, DBCtrls;

type
  TFrmPrincipal = class(TForm)
    imgBackground: TImage;
    pnlLeftContainer: TPanel;
    imgRoloImpressora: TImage;
    pnlSubTotal: TPanel;
    imgSubtotal: TImage;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    pnlFooter: TPanel;
    imgFooterLeft: TImage;
    imgFooterMiddle: TImage;
    imgFooterRight: TImage;
    pnlRelogio: TPanel;
    lblHora: TLabel;
    pnlStatus: TPanel;
    lblStatusPDV: TLabel;
    pnlRightContainer: TPanel;
    Label4: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Label15: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    Image18: TImage;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Panel1: TPanel;
    Image3: TImage;
    Image2: TImage;
    Image1: TImage;
    Label2: TLabel;
    pnlCodigoProduto: TPanel;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Panel2: TPanel;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Panel3: TPanel;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Panel4: TPanel;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Panel6: TPanel;
    Image29: TImage;
    Label13: TLabel;
    Image27: TImage;
    Label14: TLabel;
    Image28: TImage;
    ConnServidor: TSQLConnection;
    cdsProdutos: TClientDataSet;
    cdsProdutosCODIGO: TStringField;
    cdsProdutosDESCRICAO: TStringField;
    cdsProdutosPRECO_UNITARIO: TCurrencyField;
    cdsProdutosQUANTIDADE: TIntegerField;
    cdsProdutosDESCONTO_VALOR: TCurrencyField;
    cdsProdutosDESCONTO_PERCENTUAL: TCurrencyField;
    cdsProdutosPRECO_TOTAL: TCurrencyField;
    dsProdutos: TDataSource;
    tmHora: TTimer;
    lblSubtotal: TLabel;
    Image19: TImage;
    Panel5: TPanel;
    Image4: TImage;
    Image5: TImage;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    Panel7: TPanel;
    imgFotoProduto: TImage;
    imgFrameFotoProduto: TImage;
    Panel8: TPanel;
    Image20: TImage;
    Image30: TImage;
    Image31: TImage;
    DBText6: TDBText;
    Label3: TLabel;
    Label5: TLabel;
    Panel9: TPanel;
    Image32: TImage;
    Image33: TImage;
    Image34: TImage;
    DBText7: TDBText;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tmHoraTimer(Sender: TObject);
    procedure cdsProdutosDESCONTO_PERCENTUALGetText(Sender: TField;
      var Text: string; DisplayText: Boolean);
    procedure FormPaint(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure cdsProdutosQUANTIDADEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    DAOPedidoVenda: TPedidoVendaDAOClient;
    CodigoPedidoVendaAtual: string;
    DataPedidoVendaAtual: TDateTime;
    MyBitmap: TBitmap;

    procedure NovaVenda;
    procedure FecharVenda;
    procedure ConsultarProduto;
    procedure GravarVenda(Desconto, DescontoPercentual, Recebido, Troco, Total: Currency; TipoPagamento: Integer; Cliente: TCliente; NomeCliente: string);
    procedure ExcluirItem;
    procedure IniciaControles;
    procedure VendasFechadas;
    procedure VendasAbertas;
    procedure ImprimirRecibo;
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

  MyBitmap := TBitmap.Create;
  MyBitmap.Assign(imgBackground.Picture.Bitmap);
end;

procedure TFrmPrincipal.FormDestroy(Sender: TObject);
begin
  MyBitmap.Free;
  DAOPedidoVenda.Free;
end;

procedure TFrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_F2: NovaVenda;
    VK_F3: FecharVenda;
    VK_F5: ExcluirItem;
    VK_F6: ConsultarProduto;
    VK_F7: ImprimirRecibo;
    VK_F8: VendasAbertas;
    VK_F9: VendasFechadas;
  end;
end;

procedure TFrmPrincipal.FormPaint(Sender: TObject);
var
  x, y: Integer;
  iBMWid, iBMHeight : Integer;
begin
  iBMWid := MyBitmap.Width;
  iBMHeight := MyBitmap.Height;
  y := 0;
  while y < Height do
  begin
    x := 0;
    while x < Width do
    begin
      Canvas.Draw(x, y, MyBitmap);
      x := x + iBMWid;
    end;
    y := y + iBMHeight;
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

procedure TFrmPrincipal.GravarVenda(Desconto, DescontoPercentual, Recebido, Troco, Total: Currency; TipoPagamento: Integer; Cliente: TCliente; NomeCliente: string);
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
  Pedido.Recebido := Recebido;
  Pedido.Troco := Troco;
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

      lblSubtotal.Caption := FormatCurr(',0.00', pedido.Total);

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

      lblSubtotal.Caption := FormatCurr(',0.00', pedido.Total);

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
  if Sender.IsNull then
    Text := ''
  else
    Text := Sender.AsString + ' %';
end;

procedure TFrmPrincipal.cdsProdutosQUANTIDADEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text := ''
  else
    Text := IntToStr(Sender.AsInteger)+' x';
end;

procedure TFrmPrincipal.ConsultarProduto;
var
  fConsultaProdutos: TFrmConsultaProdutos;
  fAjuste: TFrmAjuste;
  Item: TItemPedidoVenda;
  Pedido: TPedidoVenda;
begin
  lblStatusPDV.Caption := 'CONSULTAR PRODUTO';
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

        if (cdsProdutos.FindKey([fConsultaProdutos.Produto.Codigo])) then
        begin
          cdsProdutos.Edit;
          if (Confirma('Este produto já se encontra no pedido. Deseja adicionar a quantidade?')) then
          begin
            cdsProdutosQUANTIDADE.AsInteger   := cdsProdutosQUANTIDADE.AsInteger + StrToInt(fAjuste.edtQuantidade.Text);
            cdsProdutosPRECO_TOTAL.AsCurrency := cdsProdutosPRECO_TOTAL.AsCurrency + fAjuste.cedPrecoTotal.Value;

            lblSubtotal.Caption := FormatCurr(',0.00', StrToCurrDef(lblSubtotal.Caption, 0) + fAjuste.cedPrecoTotal.Value);

            Item := TItemPedidoVenda.Create;
            Item.Produto    := TProduto.Create(cdsProdutosCODIGO.AsString);
            Item.Quantidade := cdsProdutosQUANTIDADE.AsInteger;
            DAOPedidoVenda.AtualizaItemDoPedido(CodigoPedidoVendaAtual, Item);

            Pedido := TPedidoVenda.Create;
            Pedido.Codigo := CodigoPedidoVendaAtual;
            Pedido.Data   := DataPedidoVendaAtual;
            Pedido.Total  := StrToCurrDef(lblSubtotal.Caption, 0);

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

          lblSubtotal.Caption := FormatCurr(',0.00', StrToCurrDef(lblSubtotal.Caption, 0) + cdsProdutosPRECO_TOTAL.AsCurrency);

          if CodigoPedidoVendaAtual = '' then
          begin
            CodigoPedidoVendaAtual := DAOPedidoVenda.NextCodigo;
            DataPedidoVendaAtual := Now;

            Pedido := TPedidoVenda.Create;
            Pedido.Codigo  := CodigoPedidoVendaAtual;
            Pedido.Data    := DataPedidoVendaAtual;
            Pedido.Total   := StrToCurrDef(lblSubtotal.Caption, 0);
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
          Pedido.Total  := StrToCurrDef(lblSubtotal.Caption, 0);

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
  lblStatusPDV.Caption := 'VENDA';
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
  lblStatusPDV.Caption := 'EXCLUIR ITEM';
  f := TFrmExcluirItem.Create(Self);
  try
    f.ShowModal;

    if (f.Excluir) then
    begin
      lblSubtotal.Caption := FormatCurr(',0.00', StrToCurrDef(lblSubtotal.Caption, 0) - cdsProdutosQUANTIDADE.AsInteger * cdsProdutosPRECO_UNITARIO.AsCurrency);

      DAOPedidoVenda.DeleteItemDoPedido(cdsProdutosCODIGO.AsString, CodigoPedidoVendaAtual);
      cdsProdutos.Delete;
    end;

    lblStatusPDV.Caption := 'VENDA';
  finally
    f.Free;
  end;
end;

procedure TFrmPrincipal.FecharVenda;
var
  f: TFrmFecharVenda;
begin
  if cdsProdutos.RecordCount <= 0 then
  begin
    Atencao('Ainda não foi incluído nenhum item na venda.');
    Exit;
  end;
  lblStatusPDV.Caption := 'FECHAR VENDA';
  f := TFrmFecharVenda.Create(Self);
  try
    f.cedTotal.Value := StrToCurrDef(lblSubtotal.Caption, 0);
    f.Total          := StrToCurrDef(lblSubtotal.Caption, 0);
    f.ShowModal;

    if (f.Fechar) then
    begin
      GravarVenda(f.cedDescontoValor.Value, f.cedDescontoPercentual.Value, f.cedValorRecebido.Value, f.cedTroco.Value, f.cedTotal.Value, f.cbFormaPagamento.ItemIndex, f.Cliente, f.NomeCliente);

      ImprimirRecibo;
    end;
  finally
    if f.Fechar then
      NovaVenda;

    f.Free;
    lblStatusPDV.Caption := 'VENDA';
  end;
end;

procedure TFrmPrincipal.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmPrincipal.ImprimirRecibo;
var
  recibo: TFrmRelReciboVenda;
begin
  if CodigoPedidoVendaAtual = '' then
  begin
    Atencao('Nenhuma venda ativa');
    Exit;
  end;

  recibo := TFrmRelReciboVenda.Create(Self);
  try
    recibo.CodigoVenda := CodigoPedidoVendaAtual;
    recibo.RLReport.Print;
  finally
    recibo.Free;
  end;
end;

procedure TFrmPrincipal.IniciaControles;
begin
  lblSubtotal.Caption := '';
  lblStatusPDV.Caption := 'VENDA';

  //lblData.Caption := FormatDateTime('dd/mm/yyyy', Now);
  tmHora.Enabled  := True;

  cdsProdutos.CreateDataSet;
end;

initialization
  RLConsts.SetVersion(3,71,'B');

end.
