{TODO -oMarcos -cFrente Loja : Criar tela de ajuda}
unit uFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, DBGrids, jpeg, DB, DBClient, SqlExpr, DBXDataSnap,
  DBXCommon, DBXDBReaders, uPedidoVendaDAOClient, PedidoVenda, ItemPedidoVenda, Produto,
  Generics.Collections, Cliente, pngimage, RLConsts, DXPCurrencyEdit,
  DBCtrls, Caixa, ImgList, StrUtils;

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
    lblDataHora: TLabel;
    pnlStatus: TPanel;
    lblStatusPDV: TLabel;
    pnlRightContainer: TPanel;
    Label4: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Image21: TImage;
    Image22: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Label15: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    Image18: TImage;
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
    lblUsuario: TLabel;
    Image27: TImage;
    lblCaixa: TLabel;
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
    Image35: TImage;
    Label6: TLabel;
    Image23: TImage;
    Label8: TLabel;
    Image36: TImage;
    Label10: TLabel;
    tmImagens: TTimer;
    Label13: TLabel;
    lblCliente: TLabel;
    Image37: TImage;
    Label14: TLabel;
    Image38: TImage;
    Button1: TButton;
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
    procedure tmImagensTimer(Sender: TObject);
    procedure Label15Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Label19Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Image38Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    DAOPedidoVenda: TPedidoVendaDAOClient;
    CodigoPedidoVendaAtual: string;
    DataPedidoVendaAtual: TDateTime;
    VendaFechada, VendaCancelada: Boolean;
    MyBitmap: TBitmap;
    CaixaAbertoAtual: TCaixa;
    ImagemAtual: Integer;

    procedure NovaVenda;
    procedure FecharVenda;
    procedure ConsultarProduto;
    procedure GravarVenda(Desconto, DescontoPercentual, Recebido, Troco, Total: Currency; TipoPagamento: Integer);
    procedure ExcluirItem;
    procedure IniciaControles;
    procedure VendasFechadas;
    procedure VendasAbertas;
    procedure ImprimirRecibo;
    procedure AbrirCaixa;
    procedure FecharCaixa;
    procedure AtualizaCaixa;
    procedure CancelarVenda;

    procedure SetStatusVenda;
    procedure SetStatusConsultaProduto;
    procedure SetStatusAbrirCaixa;
    procedure SetStatusFecharCaixa;
    procedure SetStatusExcluirItemDaVenda;
    procedure SetStatusFecharVenda;
    procedure SetStatusVendasAbertas;
    procedure SetStatusVendasFechadas;
    procedure SetStatusVendaFechada;
    procedure SetStatusInformarCliente;
    procedure SetStatusCaixaFechado;
    procedure SetStatusVendaCancelada;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses uFrmConsultaProdutos, uFrmAjuste, uFrmFecharVenda, uFrmExcluirItem, MensagensUtils,
  uFrmVendasFechadas, uFrmVendasAbertas, uFrmRelReciboVenda,
  uFrmConectandoServidor, uFrmInformarCliente, uFrmAbrirCaixa, uCaixaDAOClient,
  uFrmLogin, FuncoesBematech, FuncoesBematechMatricial;

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
    VK_F10: AbrirCaixa;
    VK_F11: FecharCaixa;
    VK_F12: CancelarVenda;
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
  AtualizaCaixa;
end;

procedure TFrmPrincipal.GravarVenda(Desconto, DescontoPercentual, Recebido, Troco, Total: Currency; TipoPagamento: Integer);
var
  Pedido: TPedidoVenda;
begin
  Pedido               := TPedidoVenda.Create;
  Pedido.Codigo        := CodigoPedidoVendaAtual;
  Pedido.Data          := DataPedidoVendaAtual;
  Pedido.Desconto      := Desconto;
  Pedido.TipoPagamento := TipoPagamento;
  Pedido.Fechada       := True;
  Pedido.DescontoPercentual := DescontoPercentual;
  Pedido.Recebido := Recebido;
  Pedido.Troco := Troco;
  Pedido.Total := Total;

  DAOPedidoVenda.Update(Pedido);
end;

procedure TFrmPrincipal.NovaVenda;
begin
  if CaixaAbertoAtual = nil then
  begin
    Atencao('Caixa fechado');
    Exit;
  end;

  cdsProdutos.Close;

  IniciaControles;
  CodigoPedidoVendaAtual := '';
  DataPedidoVendaAtual   := 0;
  VendaFechada := False;
  VendaCancelada := False;
end;

procedure TFrmPrincipal.SetStatusAbrirCaixa;
begin
  lblStatusPDV.Caption := 'ABRIR CAIXA';
  lblStatusPDV.Font.Color := clSkyBlue;
end;

procedure TFrmPrincipal.SetStatusCaixaFechado;
begin
  lblCaixa.Caption := 'Caixa Fechado';
  lblStatusPDV.Caption := 'CAIXA FECHADO';
  lblStatusPDV.Font.Color := clRed;
end;

procedure TFrmPrincipal.SetStatusConsultaProduto;
begin
  lblStatusPDV.Caption := 'CONSULTA DE PRODUTOS';
  lblStatusPDV.Font.Color := clSkyBlue;
end;

procedure TFrmPrincipal.SetStatusExcluirItemDaVenda;
begin
  lblStatusPDV.Caption := 'EXCLUIR ITEM DA VENDA';
  lblStatusPDV.Font.Color := clSkyBlue;
end;

procedure TFrmPrincipal.SetStatusFecharCaixa;
begin
  lblStatusPDV.Caption := 'FECHAR CAIXA';
  lblStatusPDV.Font.Color := clSkyBlue;
end;

procedure TFrmPrincipal.SetStatusFecharVenda;
begin
  lblStatusPDV.Caption := 'FECHAR VENDA';
  lblStatusPDV.Font.Color := clSkyBlue;
end;

procedure TFrmPrincipal.SetStatusInformarCliente;
begin
  lblStatusPDV.Caption := 'INFORMAR CLIENTE';
  lblStatusPDV.Font.Color := clSkyBlue;
end;

procedure TFrmPrincipal.SetStatusVenda;
begin
  lblStatusPDV.Caption := 'VENDA';
  lblStatusPDV.Font.Color := $0040C485;
end;

procedure TFrmPrincipal.SetStatusVendaCancelada;
begin
  lblStatusPDV.Caption := 'VENDA CANCELADA';
  lblStatusPDV.Font.Color := clRed;
end;

procedure TFrmPrincipal.SetStatusVendaFechada;
begin
  lblStatusPDV.Caption := 'VENDA FECHADA';
  lblStatusPDV.Font.Color := clRed;
end;

procedure TFrmPrincipal.SetStatusVendasAbertas;
begin
  lblStatusPDV.Caption := 'VENDAS ABERTAS';
  lblStatusPDV.Font.Color := clSkyBlue;
end;

procedure TFrmPrincipal.SetStatusVendasFechadas;
begin
  lblStatusPDV.Caption := 'VENDAS FECHADAS';
  lblStatusPDV.Font.Color := clSkyBlue;
end;

procedure TFrmPrincipal.tmHoraTimer(Sender: TObject);
begin
  lblDataHora.Caption := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);
end;

procedure TFrmPrincipal.tmImagensTimer(Sender: TObject);
begin
  if (ImagemAtual = 0) or (ImagemAtual = 3) then
    ImagemAtual := 1
  else
    Inc(ImagemAtual);

  if FileExists(ExtractFileDir(Application.ExeName)+'/imagens/'+IntToStr(ImagemAtual)+'.jpg') then
    imgFotoProduto.Picture.LoadFromFile(ExtractFileDir(Application.ExeName)+'/imagens/'+IntToStr(ImagemAtual)+'.jpg');
end;

procedure TFrmPrincipal.VendasAbertas;
var
  fVendasAbertas: TFrmVendasAbertas;
  pedido: TPedidoVenda;
  i: Integer;
begin
  fVendasAbertas := TFrmVendasAbertas.Create(Self);
  try
    SetStatusVendasAbertas;

    fVendasAbertas.ShowModal;

    if fVendasAbertas.ModalResult = mrOk then
    begin
      pedido := DAOPedidoVenda.FindByCodigo(fVendasAbertas.cdsConsultaCODIGO.AsString);

      CodigoPedidoVendaAtual := pedido.Codigo;
      DataPedidoVendaAtual := pedido.Data;
      VendaFechada := False;
      VendaCancelada := False;

      if pedido.Cliente <> nil then
        lblCliente.Caption := pedido.Cliente.Nome
      else
        lblCliente.Caption := pedido.NomeClienteAvulso;

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

  if VendaFechada then
    SetStatusVendaFechada
  else if VendaCancelada then
    SetStatusVendaCancelada
  else
    SetStatusVenda;
end;

procedure TFrmPrincipal.VendasFechadas;
var
  fVendasFechadas: TFrmVendasFechadas;
  pedido: TPedidoVenda;
  i: Integer;
begin
  fVendasFechadas := TFrmVendasFechadas.Create(Self);
  try
    SetStatusVendasFechadas;

    fVendasFechadas.ShowModal;

    if fVendasFechadas.ModalResult = mrOk then
    begin
      pedido := DAOPedidoVenda.FindByCodigo(fVendasFechadas.cdsConsultaCODIGO.AsString);

      CodigoPedidoVendaAtual := pedido.Codigo;
      DataPedidoVendaAtual := pedido.Data;
      VendaFechada := True;
      VendaCancelada := False;

      SetStatusVendaFechada;

      if pedido.Cliente <> nil then
        lblCliente.Caption := pedido.Cliente.Nome
      else
        lblCliente.Caption := pedido.NomeClienteAvulso;

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

  if VendaFechada then
    SetStatusVendaFechada
  else if VendaCancelada then
    SetStatusVendaCancelada
  else
    SetStatusVenda;
end;

procedure TFrmPrincipal.AbrirCaixa;
var
  f: TFrmAbrirCaixa;
  dao: TCaixaDAOClient;
  caixa: TCaixa;
begin
  if CaixaAbertoAtual <> nil then
  begin
    Atencao('Caixa atualmente aberto');
    Exit;
  end;

  SetStatusAbrirCaixa;

  f := TFrmAbrirCaixa.Create(Self);
  try
    f.ShowModal;

    if (f.Abrir) then
    begin
      dao := TCaixaDAOClient.Create(ConnServidor.DBXConnection);
      try
        caixa := TCaixa.Create;
        caixa.Data := f.deData.DateTime;
        caixa.Fechado := False;
        caixa.ValorAbertura := f.cedValorAbertura.Value;

        dao.Abrir(caixa);

        AtualizaCaixa;
      finally
        dao.Free;
      end;
    end;
  finally
    f.Free;

    SetStatusVenda;
  end;
end;

procedure TFrmPrincipal.AtualizaCaixa;
var
  dao: TCaixaDAOClient;
  caixa: TCaixa;
begin
  dao := TCaixaDAOClient.Create(ConnServidor.DBXConnection);
  try
    caixa := dao.CaixaAberto;

    if caixa <> nil then
    begin
      lblCaixa.Caption := 'Caixa '+IntToStr(caixa.Id);

      CaixaAbertoAtual := caixa;
    end
    else
      SetStatusCaixaFechado;
  finally
    dao.Free;
  end;
end;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
var
  i_modelo, i_retorno: Integer;
  s_porta: AnsiString;
begin
  //COMANDO EXECUTADO INTERNAMENTE PELA DLL PARA
  //CONFIGURAÇÃO DO MODELO DA IMPRESSORA QUE SERÁ CONECTADA
  i_modelo  := 1;
  i_retorno := ConfiguraModeloImpressora(i_modelo);

  Informacao(IntToStr(i_retorno));

  s_porta := 'LPT1';
  //COMANDO DE ABERTURA DA PORTA DE COMUNICAÇÃO
  i_retorno:= IniciaPorta(s_porta);

  //VALIDAÇÃO DE EXECUÇÃO DO COMANDO
  if i_retorno = 1 then
    Informacao('Impressora conectada')
  else
    Erro('Erro de conexão '+IntToStr(i_retorno));

  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=BematechTX('Comprovante de Teste abcdefghij'+#10);
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));
  i_retorno:=ComandoTX(#13#10,length(#13#10));

  if i_retorno <> 1 then
    Erro('Erro de comunicação');
end;

procedure TFrmPrincipal.CancelarVenda;
begin
  if VendaCancelada then
  begin
    Atencao('Venda já está cancelada.');
    Exit;
  end;

  if CodigoPedidoVendaAtual = '' then
  begin
    Atencao('Nenhuma venda ativa');
    Exit;
  end;

  if Confirma('Deseja cancelar esta venda?') then
    if DAOPedidoVenda.CancelarVenda(CodigoPedidoVendaAtual) then
    begin
      VendaCancelada := True;
      SetStatusVendaCancelada;
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
  fInformarCliente: TFrmInformarCliente;
begin
  if VendaFechada then
  begin
    Atencao('Venda já está fechada.');
    Exit;
  end;

  if VendaCancelada then
  begin
    Atencao('Venda cancelada.');
    Exit;
  end;

  SetStatusConsultaProduto;

  fConsultaProdutos := TFrmConsultaProdutos.Create(Self);
  try
    fConsultaProdutos.ShowModal;
    if (Assigned(fConsultaProdutos.Produto)) then
    begin
      if CaixaAbertoAtual = nil then
      begin
        Atencao('Caixa fechado');
        Exit;
      end;

      fAjuste := TFrmAjuste.Create(Self);
      try
        fAjuste.lblDescricaoProduto.Caption := fConsultaProdutos.Produto.Descricao;
        fAjuste.cedPrecoUnitario.Value      := fConsultaProdutos.Produto.PrecoVenda;
        fAjuste.sedQuantidade.Value         := 1;
        fAjuste.cedPrecoTotal.Value         := fConsultaProdutos.Produto.PrecoVenda;
        fAjuste.DescontoMaximoValor         := fConsultaProdutos.Produto.DescontoMaximoValor;
        fAjuste.DescontoMaximoPercentual    := fConsultaProdutos.Produto.DescontoMaximoPercentual;

        fAjuste.ShowModal;

        if (cdsProdutos.FindKey([fConsultaProdutos.Produto.Codigo])) then
        begin
          cdsProdutos.Edit;
          if (Confirma('Este produto já se encontra no pedido. Deseja adicionar a quantidade?')) then
          begin
            cdsProdutosQUANTIDADE.AsInteger   := cdsProdutosQUANTIDADE.AsInteger + fAjuste.sedQuantidade.Value;
            cdsProdutosPRECO_TOTAL.AsCurrency := cdsProdutosPRECO_TOTAL.AsCurrency + fAjuste.cedPrecoTotal.Value;

            lblSubtotal.Caption := FormatCurr(',0.00', StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0) + fAjuste.cedPrecoTotal.Value);

            Item := TItemPedidoVenda.Create;
            Item.Produto    := TProduto.Create(cdsProdutosCODIGO.AsString);
            Item.Quantidade := cdsProdutosQUANTIDADE.AsInteger;
            DAOPedidoVenda.AtualizaItemDoPedido(CodigoPedidoVendaAtual, Item);

            Pedido := TPedidoVenda.Create;
            Pedido.Codigo := CodigoPedidoVendaAtual;
            Pedido.Data   := DataPedidoVendaAtual;
            Pedido.Total  := StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0);

            DAOPedidoVenda.Update(Pedido);
          end;
        end
        else
        begin
          cdsProdutos.Append;
          cdsProdutosCODIGO.AsString           := fConsultaProdutos.Produto.Codigo;
          cdsProdutosDESCRICAO.AsString        := fConsultaProdutos.Produto.Descricao;
          cdsProdutosPRECO_UNITARIO.AsCurrency := fConsultaProdutos.Produto.PrecoVenda;
          cdsProdutosQUANTIDADE.AsInteger      := fAjuste.sedQuantidade.Value;
          cdsProdutosDESCONTO_VALOR.AsCurrency := fAjuste.cedDescValor.Value;
          cdsProdutosDESCONTO_PERCENTUAL.AsCurrency := fAjuste.cedDescPercentual.Value;
          cdsProdutosPRECO_TOTAL.AsCurrency    := fAjuste.cedPrecoTotal.Value;

          lblSubtotal.Caption := FormatCurr(',0.00', StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0) + cdsProdutosPRECO_TOTAL.AsCurrency);

          if CodigoPedidoVendaAtual = '' then
          begin
            CodigoPedidoVendaAtual := DAOPedidoVenda.NextCodigo;
            DataPedidoVendaAtual := Now;

            Pedido := TPedidoVenda.Create;
            Pedido.Itens := TList<TItemPedidoVenda>.Create;
            Pedido.Codigo  := CodigoPedidoVendaAtual;
            Pedido.Data    := DataPedidoVendaAtual;
            Pedido.Total   := StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0);
            Pedido.Fechada := False;
            Pedido.LoginUsuario := lblUsuario.Caption;

            SetStatusInformarCliente;

            fInformarCliente := TFrmInformarCliente.Create(Self);
            try
              fInformarCliente.ShowModal;

              if (fInformarCliente.Salvar) then
              begin
                if fInformarCliente.Cliente <> nil then
                begin
                  Pedido.Cliente := fInformarCliente.Cliente;
                  lblCliente.Caption := Pedido.Cliente.Nome;
                end
                else
                begin
                  Pedido.NomeClienteAvulso := fInformarCliente.NomeCliente;
                  lblCliente.Caption := Pedido.NomeClienteAvulso;
                end;
              end;
            finally
              fInformarCliente.Free;

              SetStatusVenda;
            end;

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
          Pedido.Total  := StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0);

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

  SetStatusVenda;
end;

procedure TFrmPrincipal.ExcluirItem;
var
  f: TFrmExcluirItem;
  Pedido: TPedidoVenda;
begin
  if cdsProdutos.RecordCount <= 0 then
  begin
    Atencao('Ainda não foi incluído nenhum item na venda.');
    Exit;
  end;

  if VendaFechada then
  begin
    Atencao('Venda já está fechada.');
    Exit;
  end;

  if VendaCancelada then
  begin
    Atencao('Venda cancelada.');
    Exit;
  end;

  SetStatusExcluirItemDaVenda;

  f := TFrmExcluirItem.Create(Self);
  try
    f.ShowModal;

    if (f.Excluir) then
    begin
      lblSubtotal.Caption := FormatCurr(',0.00', StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0) - cdsProdutosPRECO_TOTAL.AsCurrency);

      DAOPedidoVenda.DeleteItemDoPedido(cdsProdutosCODIGO.AsString, CodigoPedidoVendaAtual);
      cdsProdutos.Delete;

      Pedido := TPedidoVenda.Create;
      Pedido.Codigo := CodigoPedidoVendaAtual;
      Pedido.Data   := DataPedidoVendaAtual;
      Pedido.Total  := StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0);

      DAOPedidoVenda.Update(Pedido);
    end;

    SetStatusVenda;
  finally
    f.Free;
  end;
end;

procedure TFrmPrincipal.FecharCaixa;
var
  dao: TCaixaDAOClient;
begin
  if CaixaAbertoAtual = nil then
  begin
    Atencao('Caixa atualmente fechado');
    Exit;
  end;

  SetStatusFecharCaixa;

  if Confirma('Deseja fechar o caixa?') then
  begin
    dao := TCaixaDAOClient.Create(ConnServidor.DBXConnection);
    try
      dao.Fechar;
      CaixaAbertoAtual := nil;
    finally
      dao.Free;
    end;

    SetStatusCaixaFechado;
  end
  else
  begin
    if VendaFechada then
      SetStatusVendaFechada
    else
      SetStatusVenda;
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

  if VendaFechada then
  begin
    Atencao('Venda já está fechada.');
    Exit;
  end;

  if VendaCancelada then
  begin
    Atencao('Venda cancelada.');
    Exit;
  end;

  SetStatusFecharVenda;

  f := TFrmFecharVenda.Create(Self);
  try
    f.cedTotal.Value := StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0);
    f.Total          := StrToCurrDef(AnsiReplaceStr(lblSubtotal.Caption,'.',''), 0);
    f.ShowModal;

    if (f.Fechar) then
    begin
      GravarVenda(f.cedDescontoValor.Value, f.cedDescontoPercentual.Value, f.cedValorRecebido.Value, f.cedTroco.Value, f.cedTotal.Value, f.lbFormaPagamento.ItemIndex);

      ImprimirRecibo;
    end;
  finally
    if f.Fechar then
      NovaVenda;

    f.Free;

    SetStatusVenda;
  end;
end;

procedure TFrmPrincipal.Image19Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmPrincipal.Image38Click(Sender: TObject);
var
  fLogin: TFrmLogin;
begin
  fLogin := TFrmLogin.Create( nil );
  try
    fLogin.TrocarUsuario := True;
    fLogin.ShowModal;
    if fLogin.FLoginSucess then
      if fLogin.Usuario <> nil then
        FrmPrincipal.lblUsuario.Caption := fLogin.Usuario.Login
      else
        FrmPrincipal.lblUsuario.Caption := 'TOP';
  finally
    fLogin.Free;
  end;
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
  lblCliente.Caption  := '';
  lblSubtotal.Caption := '';

  SetStatusVenda;

  lblDataHora.Caption := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);
  tmHora.Enabled  := True;

  cdsProdutos.CreateDataSet;
end;

procedure TFrmPrincipal.Label10Click(Sender: TObject);
begin
  FecharCaixa;
end;

procedure TFrmPrincipal.Label12Click(Sender: TObject);
begin
  FecharVenda;
end;

procedure TFrmPrincipal.Label14Click(Sender: TObject);
begin
  CancelarVenda;
end;

procedure TFrmPrincipal.Label15Click(Sender: TObject);
begin
  NovaVenda;
end;

procedure TFrmPrincipal.Label16Click(Sender: TObject);
begin
  ExcluirItem;
end;

procedure TFrmPrincipal.Label18Click(Sender: TObject);
begin
  ImprimirRecibo;
end;

procedure TFrmPrincipal.Label19Click(Sender: TObject);
begin
  VendasAbertas;
end;

procedure TFrmPrincipal.Label20Click(Sender: TObject);
begin
  VendasFechadas;
end;

procedure TFrmPrincipal.Label6Click(Sender: TObject);
begin
  ConsultarProduto;
end;

procedure TFrmPrincipal.Label8Click(Sender: TObject);
begin
  AbrirCaixa;
end;

initialization
  RLConsts.SetVersion(3,71,'B');

end.
