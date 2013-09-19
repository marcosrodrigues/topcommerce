unit uFrmConsultaProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, DBClient, uProdutoDAOClient,
  DBXDBReaders, Produto;

type
  TFrmConsultaProdutos = class(TForm)
    pnlParametros: TPanel;
    Label1: TLabel;
    edtConsultar: TEdit;
    grdConsulta: TDBGrid;
    pnlResultado: TPanel;
    Label2: TLabel;
    lblTotalRegistros: TLabel;
    dsConsulta: TDataSource;
    cdsConsulta: TClientDataSet;
    cdsConsultaCODIGO: TStringField;
    cdsConsultaDESCRICAO: TStringField;
    cdsConsultaCODIGO_TIPO_PRODUTO: TStringField;
    cdsConsultaDESCRICAO_TIPO_PRODUTO: TStringField;
    cdsConsultaCODIGO_BARRAS: TStringField;
    cdsConsultaPRECO_VENDA: TCurrencyField;
    cdsConsultaQUANTIDADE: TIntegerField;
    cdsConsultaESTOQUE_MINIMO: TIntegerField;
    cdsConsultaENDERECO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdConsultaDblClick(Sender: TObject);
    procedure grdConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure edtConsultarChange(Sender: TObject);
    procedure edtConsultarKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    DAOClient: TProdutoDAOClient;

    procedure Selecionar;
  public
    { Public declarations }
    Produto: TProduto;
  end;

var
  FrmConsultaProdutos: TFrmConsultaProdutos;

implementation

uses uFrmPrincipal, MensagensUtils, DataUtils;

{$R *.dfm}

procedure TFrmConsultaProdutos.edtConsultarChange(Sender: TObject);
begin
  cdsConsulta.Filtered := False;
  cdsConsulta.Filter   := 'UPPER(DESCRICAO) LIKE ' + QuotedStr('%'+UpperCase(edtConsultar.Text)+'%');
  cdsConsulta.Filtered := True;

  lblTotalRegistros.Caption := IntToStr(cdsConsulta.RecordCount);
end;

procedure TFrmConsultaProdutos.edtConsultarKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
    Selecionar;
end;

procedure TFrmConsultaProdutos.FormCreate(Sender: TObject);
begin
  DAOClient := TProdutoDAOClient.Create(FrmPrincipal.ConnServidor.DBXConnection);
end;

procedure TFrmConsultaProdutos.FormDestroy(Sender: TObject);
begin
  DAOClient.Free;
end;

procedure TFrmConsultaProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Self.Close;
    VK_DOWN: grdConsulta.SetFocus;
  end;
end;

procedure TFrmConsultaProdutos.FormShow(Sender: TObject);
begin
  CopyReaderToClientDataSet(DAOClient.List, cdsConsulta);
  lblTotalRegistros.Caption := IntToStr(cdsConsulta.RecordCount);
end;

procedure TFrmConsultaProdutos.grdConsultaDblClick(Sender: TObject);
begin
  Selecionar;
end;

procedure TFrmConsultaProdutos.grdConsultaKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
    Selecionar;
end;

procedure TFrmConsultaProdutos.Selecionar;
begin
  if (cdsConsultaQUANTIDADE.AsInteger <= 0 ) then
  begin
    Atencao('Produto não possui estoque.');
    Exit;
  end;
  Produto                   := TProduto.Create;
  Produto.Codigo            := cdsConsultaCODIGO.AsString;
  Produto.Descricao         := cdsConsultaDESCRICAO.AsString;
  Produto.PrecoVenda        := cdsConsultaPRECO_VENDA.AsCurrency;
  Produto.QuantidadeEstoque := cdsConsultaQUANTIDADE.AsInteger;
  Self.Close;
end;

end.
