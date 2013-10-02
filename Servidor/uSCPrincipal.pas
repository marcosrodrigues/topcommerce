unit uSCPrincipal;

interface

uses
  SysUtils, Classes,
  DSTCPServerTransport,
  DSServer, DSCommonServer, DSAuth, DBXMSSQL, DB, SqlExpr;

type
  TSCPrincipal = class(TDataModule)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    ConnTopCommerce: TSQLConnection;
    TipoProduto: TDSServerClass;
    Produto: TDSServerClass;
    Fornecedor: TDSServerClass;
    Estoque: TDSServerClass;
    PedidoVenda: TDSServerClass;
    Usuario: TDSServerClass;
    Cliente: TDSServerClass;
    Caixa: TDSServerClass;
    ContaPagar: TDSServerClass;
    ContaReceber: TDSServerClass;
    procedure TipoProdutoGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ProdutoGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure FornecedorGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure EstoqueGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure PedidoVendaGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure UsuarioGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure ClienteGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure CaixaGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ContaPagarGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure ContaReceberGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
  end;

var
  SCPrincipal: TSCPrincipal;

implementation

uses Windows, TipoProdutoDAO, ProdutoDAO, FornecedorDAO, EstoqueDAO, PedidoVendaDAO, UsuarioDAO,
  ClienteDAO, CaixaDAO, ContaPagarDAO, ContaReceberDAO;

{$R *.dfm}

procedure TSCPrincipal.TipoProdutoGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TTipoProdutoDAO;
end;

procedure TSCPrincipal.UsuarioGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TUsuarioDAO;
end;

procedure TSCPrincipal.ProdutoGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TProdutoDAO;
end;

procedure TSCPrincipal.FornecedorGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TFornecedorDAO;
end;

procedure TSCPrincipal.CaixaGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := TCaixaDAO;
end;

procedure TSCPrincipal.ClienteGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TClienteDAO;
end;

procedure TSCPrincipal.ContaPagarGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := TContaPagarDAO;
end;

procedure TSCPrincipal.ContaReceberGetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := TContaReceberDAO;
end;

procedure TSCPrincipal.EstoqueGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TEstoqueDAO;
end;

procedure TSCPrincipal.PedidoVendaGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TPedidoVendaDAO;
end;

end.

