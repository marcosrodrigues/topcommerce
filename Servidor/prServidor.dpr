program prServidor;

uses
  Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  TipoProduto in '..\Entidades\TipoProduto.pas',
  TipoProdutoDAO in 'DAO\TipoProdutoDAO.pas',
  StringUtils in '..\Utils\StringUtils.pas',
  uSCPrincipal in 'uSCPrincipal.pas' {SCPrincipal: TDataModule},
  Produto in '..\Entidades\Produto.pas',
  ProdutoDAO in 'DAO\ProdutoDAO.pas',
  FornecedorDAO in 'DAO\FornecedorDAO.pas',
  Fornecedor in '..\Entidades\Fornecedor.pas',
  EstoqueDAO in 'DAO\EstoqueDAO.pas',
  Estoque in '..\Entidades\Estoque.pas',
  FornecedorProduto in '..\Entidades\FornecedorProduto.pas',
  PedidoVenda in '..\Entidades\PedidoVenda.pas',
  ItemPedidoVenda in '..\Entidades\ItemPedidoVenda.pas',
  PedidoVendaDAO in 'DAO\PedidoVendaDAO.pas',
  MensagensUtils in '..\Utils\MensagensUtils.pas',
  Validade in '..\Entidades\Validade.pas',
  Usuario in '..\Entidades\Usuario.pas',
  UsuarioDAO in 'DAO\UsuarioDAO.pas',
  BaseDAO in 'DAO\BaseDAO.pas',
  Cliente in '..\Entidades\Cliente.pas',
  ClienteDAO in 'DAO\ClienteDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Servidor Top Commerce';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TSCPrincipal, SCPrincipal);
  Application.Run;
end.

