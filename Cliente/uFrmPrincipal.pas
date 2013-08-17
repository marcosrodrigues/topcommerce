{TODO -oMarcos -cTestes : Criar testes unitários}
unit uFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, Buttons, DBXDataSnap, DBXCommon, DB, SqlExpr, ExtDlgs,
  IniFiles, StdCtrls, Grids, DBGrids, DBClient, DXPControl, DXPButtons;

type
  TFrmPrincipal = class(TForm)
    mmPrincipal: TMainMenu;
    Cadastros1: TMenuItem;
    N11TiposdeProdutos1: TMenuItem;
    pnlAtalhos: TPanel;
    ConnServidor: TSQLConnection;
    N12Produtos1: TMenuItem;
    N12Fornecedores1: TMenuItem;
    N21: TMenuItem;
    N21MovimentarEstoque1: TMenuItem;
    N3Relatrios1: TMenuItem;
    N31ListagemdeFornecedores1: TMenuItem;
    N32ListagemdeProdutos1: TMenuItem;
    N1: TMenuItem;
    N33Estoque1: TMenuItem;
    N34PedidosdeVenda1: TMenuItem;
    ppmPrincipal: TPopupMenu;
    PapeldeParede1: TMenuItem;
    OpenPictureDialog: TOpenPictureDialog;
    imgPapelParede: TImage;
    Splitter1: TSplitter;
    pnlAlertas: TPanel;
    dgrProdutosVencer: TDBGrid;
    pnlTitle: TPanel;
    Label1: TLabel;
    cdsProdutosVencer: TClientDataSet;
    dsProdutosVencer: TDataSource;
    cdsProdutosVencerCODIGO_PRODUTO: TStringField;
    cdsProdutosVencerDESCRICAO: TStringField;
    cdsProdutosVencerDATA: TDateTimeField;
    bbtAtualizar: TBitBtn;
    lblLogin: TLabel;
    N11Usurios1: TMenuItem;
    N2: TMenuItem;
    N12Clientes1: TMenuItem;
    btnUsuarios: TDXPButton;
    btnClientes: TDXPButton;
    btnFornecedores: TDXPButton;
    btnProdutos: TDXPButton;
    btnMovimentacaoEstoque: TDXPButton;
    btnRelatorioEstoque: TDXPButton;
    btnRelatorioPedidosVendas: TDXPButton;
    btnSair: TDXPButton;
    procedure N11TiposdeProdutos1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N12Produtos1Click(Sender: TObject);
    procedure N12Fornecedores1Click(Sender: TObject);
    procedure N21MovimentarEstoque1Click(Sender: TObject);
    procedure N31ListagemdeFornecedores1Click(Sender: TObject);
    procedure N32ListagemdeProdutos1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N34PedidosdeVenda1Click(Sender: TObject);
    procedure N33Estoque1Click(Sender: TObject);
    procedure PapeldeParede1Click(Sender: TObject);
    procedure bbtAtualizarClick(Sender: TObject);
    procedure N11Usurios1Click(Sender: TObject);
    procedure N12Clientes1Click(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregaProdutosVencer;
    function FileVersion: string;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses uFrmTipoProduto, MensagensUtils, uFrmProduto, uFrmFornecedor, uFrmEstoque,
  uFrmFiltrosFornecedor, uFrmFiltrosProduto, uFrmFiltrosPedidoVenda, uFrmFiltrosEstoque,
  uProdutoDAOClient, DataUtils, uFrmUsuario, uFrmCliente, uFrmConexaoServidor;

{$R *.dfm}

procedure TFrmPrincipal.bbtAtualizarClick(Sender: TObject);
begin
  cdsProdutosVencer.Close;
  CarregaProdutosVencer;
end;

procedure TFrmPrincipal.CarregaProdutosVencer;
var
  ProdutoDao: TProdutoDAOClient;
begin
  ProdutoDao := TProdutoDAOClient.Create(ConnServidor.DBXConnection);
  try
    CopyReaderToClientDataSet(ProdutoDao.ListProdutosPertoVencimento, cdsProdutosVencer);
  finally
    ProdutoDao.Free;
  end;
end;

procedure TFrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

function TFrmPrincipal.FileVersion: string;
var
  h,q:DWORD;
  i:pointer;
  f:PVSFixedFileInfo;
  l:UInt;
  n:string;
begin
  Result := '';
  n := Application.ExeName;
  q := GetFileVersionInfoSize(PChar(n),h);
  if q = 0 then
    Exit;
  getmem(i,q);
  try
    if GetFileVersionInfo(PChar(n), h, q, i) then
      if VerQueryValue(i, '\', pointer(f), l) then
        Result := IntToStr(HIWORD(f^.dwFileVersionMS))+'.'+IntToStr(LOWORD(f^.dwFileVersionMS))+'.'+IntToStr(HIWORD(f^.dwFileVersionLS));
  finally
    freemem(i,q);
  end;
end;

procedure TFrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Confirma('Deseja sair do sistema?');
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  Ini: TIniFile;
  PapelParede: string;
begin
  Caption := Caption + ' - ' + FileVersion;

  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    ConnServidor.Params.Add('HostName=' + Ini.ReadString('SERVIDOR', 'HOST', ''));

    PapelParede := Ini.ReadString('APLICACAO', 'PAPELPAREDE', '');

    if FileExists(PapelParede) then
      imgPapelParede.Picture.LoadFromFile(PapelParede);
  finally
    Ini.Free;
  end;

  ConnServidor.Open;

  CarregaProdutosVencer;
end;

procedure TFrmPrincipal.N11TiposdeProdutos1Click(Sender: TObject);
var
  f: TFrmTipoProduto;
begin
  f := nil;
  if (f = nil) then
    f := TFrmTipoProduto.Create(Self);
  f.Show;
end;

procedure TFrmPrincipal.N11Usurios1Click(Sender: TObject);
var
  f: TFrmUsuario;
begin
  f := nil;
  if (f = nil) then
    f := TFrmUsuario.Create(Self);
  f.Show;
end;

procedure TFrmPrincipal.N12Fornecedores1Click(Sender: TObject);
var
  f: TFrmFornecedor;
begin
  f := nil;
  if (f = nil) then
    f := TFrmFornecedor.Create(Self);
  f.Show;
end;

procedure TFrmPrincipal.N12Produtos1Click(Sender: TObject);
var
  f: TFrmProduto;
begin
  f := nil;
  if (f = nil) then
    f := TFrmProduto.Create(Self);
  f.Show;
end;

procedure TFrmPrincipal.N21MovimentarEstoque1Click(Sender: TObject);
var
  f: TFrmEstoque;
begin
  f := nil;
  if (f = nil) then
    f := TFrmEstoque.Create(Self);
  f.Show;
end;

procedure TFrmPrincipal.N31ListagemdeFornecedores1Click(Sender: TObject);
var
  f: TFrmFiltrosFornecedor;
begin
  f := nil;
  if (f = nil) then
    f := TFrmFiltrosFornecedor.Create(Self);
  f.ShowModal;
end;

procedure TFrmPrincipal.N32ListagemdeProdutos1Click(Sender: TObject);
var
  f: TFrmFiltrosProduto;
begin
  f := nil;
  if (f = nil) then
    f := TFrmFiltrosProduto.Create(Self);
  f.ShowModal;
end;

procedure TFrmPrincipal.N33Estoque1Click(Sender: TObject);
var
  f: TFrmFiltrosEstoque;
begin
  f := nil;
  if (f = nil) then
    f := TFrmFiltrosEstoque.Create(Self);
  f.ShowModal;
end;

procedure TFrmPrincipal.N34PedidosdeVenda1Click(Sender: TObject);
var
  f: TFrmFiltrosPedidoVenda;
begin
  f := nil;
  if (f = nil) then
    f := TFrmFiltrosPedidoVenda.Create(Self);
  f.ShowModal;
end;

procedure TFrmPrincipal.N12Clientes1Click(Sender: TObject);
var
  f: TFrmCliente;
begin
  f := nil;
  if (f = nil) then
    f := TFrmCliente.Create(Self);
  f.Show;
end;

procedure TFrmPrincipal.PapeldeParede1Click(Sender: TObject);
var
  Ini: TIniFile;
begin
  if OpenPictureDialog.Execute then
    if FileExists(OpenPictureDialog.FileName) then
    begin
      Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
      try
        Ini.WriteString('APLICACAO', 'PAPELPAREDE', OpenPictureDialog.FileName);

        imgPapelParede.Picture.LoadFromFile(OpenPictureDialog.FileName);
      finally
        Ini.Free;
      end;
    end;
end;

end.
