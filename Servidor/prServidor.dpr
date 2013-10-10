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
  ClienteDAO in 'DAO\ClienteDAO.pas',
  Caixa in '..\Entidades\Caixa.pas',
  CaixaDAO in 'DAO\CaixaDAO.pas',
  ContaPagar in '..\Entidades\ContaPagar.pas',
  ContaReceber in '..\Entidades\ContaReceber.pas',
  ContaPagarDAO in 'DAO\ContaPagarDAO.pas',
  ContaReceberDAO in 'DAO\ContaReceberDAO.pas',
  uFrmConfirm in '..\Utils\uFrmConfirm.pas' {FrmConfirm},
  uFrmError in '..\Utils\uFrmError.pas' {FrmError},
  uFrmInformation in '..\Utils\uFrmInformation.pas' {FrmInformation},
  uFrmWarning in '..\Utils\uFrmWarning.pas' {FrmWarning};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Servidor Top Commerce';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TSCPrincipal, SCPrincipal);
  Application.CreateForm(TFrmConfirm, FrmConfirm);
  Application.CreateForm(TFrmError, FrmError);
  Application.CreateForm(TFrmInformation, FrmInformation);
  Application.CreateForm(TFrmWarning, FrmWarning);
  Application.Run;
end.

