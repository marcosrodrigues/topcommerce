program prFrenteLoja;

uses
  Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uFrmConsultaProdutos in 'uFrmConsultaProdutos.pas' {FrmConsultaProdutos},
  uProdutoDAOClient in '..\Cliente\DAOClient\uProdutoDAOClient.pas',
  Produto in '..\Entidades\Produto.pas',
  TipoProduto in '..\Entidades\TipoProduto.pas',
  uFrmAjuste in 'uFrmAjuste.pas' {FrmAjuste},
  FornecedorProduto in '..\Entidades\FornecedorProduto.pas',
  Fornecedor in '..\Entidades\Fornecedor.pas',
  uFrmFecharVenda in 'uFrmFecharVenda.pas' {FrmFecharVenda},
  uPedidoVendaDAOClient in '..\Cliente\DAOClient\uPedidoVendaDAOClient.pas',
  ItemPedidoVenda in '..\Entidades\ItemPedidoVenda.pas',
  PedidoVenda in '..\Entidades\PedidoVenda.pas',
  uFrmExcluirItem in 'uFrmExcluirItem.pas' {FrmExcluirItem},
  MensagensUtils in '..\Utils\MensagensUtils.pas',
  DataUtils in '..\Utils\DataUtils.pas',
  Validade in '..\Entidades\Validade.pas',
  Cliente in '..\Entidades\Cliente.pas',
  uFrmConsultaClientes in 'uFrmConsultaClientes.pas' {FrmConsultaClientes},
  uClienteDAOClient in '..\Cliente\DAOClient\uClienteDAOClient.pas',
  uFrmVendasFechadas in 'uFrmVendasFechadas.pas' {FrmVendasFechadas},
  uFrmVendasAbertas in 'uFrmVendasAbertas.pas' {FrmVendasAbertas},
  uFrmRelBase in '..\Cliente\uFrmRelBase.pas' {FrmRelBase},
  uFrmRelReciboVenda in 'uFrmRelReciboVenda.pas' {FrmRelReciboVenda},
  uFrmConectandoServidor in '..\Cliente\uFrmConectandoServidor.pas' {FrmConectandoServidor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Frente de Loja - Top Commerce';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
