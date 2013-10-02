program prCliente;

uses
  Forms,
  IniFiles,
  SysUtils,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  TipoProduto in '..\Entidades\TipoProduto.pas',
  uFrmBase in 'uFrmBase.pas' {FrmBase},
  uFrmCrudBase in 'uFrmCrudBase.pas' {FrmCrudBase},
  uFrmTipoProduto in 'uFrmTipoProduto.pas' {FrmTipoProduto},
  MensagensUtils in '..\Utils\MensagensUtils.pas',
  uUsuarioDAOClient in 'DAOClient\uUsuarioDAOClient.pas',
  uFrmDadosBase in 'uFrmDadosBase.pas' {FrmDadosBase},
  uFrmDadosTipoProduto in 'uFrmDadosTipoProduto.pas' {FrmDadosTipoProduto},
  TypesUtils in '..\Utils\TypesUtils.pas',
  uProdutoDAOClient in 'DAOClient\uProdutoDAOClient.pas',
  Produto in '..\Entidades\Produto.pas',
  uFrmProduto in 'uFrmProduto.pas' {FrmProduto},
  uFrmDadosMasterDetailBase in 'uFrmDadosMasterDetailBase.pas' {FrmDadosMasterDetailBase},
  uFrmDadosProduto in 'uFrmDadosProduto.pas' {FrmDadosProduto},
  uFrmConsultaBase in 'uFrmConsultaBase.pas' {FrmConsultaBase},
  uFrmConsultaTipoProduto in 'uFrmConsultaTipoProduto.pas' {FrmConsultaTipoProduto},
  StringUtils in '..\Utils\StringUtils.pas',
  uFrmFornecedor in 'uFrmFornecedor.pas' {FrmFornecedor},
  uFrmDadosFornecedor in 'uFrmDadosFornecedor.pas' {FrmDadosFornecedor},
  Fornecedor in '..\Entidades\Fornecedor.pas',
  uFornecedorDAOClient in 'DAOClient\uFornecedorDAOClient.pas',
  uFrmEstoque in 'uFrmEstoque.pas' {FrmEstoque},
  uFrmDadosEstoque in 'uFrmDadosEstoque.pas' {FrmDadosEstoque},
  uEstoqueDAOClient in 'DAOClient\uEstoqueDAOClient.pas',
  Estoque in '..\Entidades\Estoque.pas',
  uFrmConsultaProduto in 'uFrmConsultaProduto.pas' {FrmConsultaProduto},
  FornecedorProduto in '..\Entidades\FornecedorProduto.pas',
  uFrmDadosFornecedorProduto in 'uFrmDadosFornecedorProduto.pas' {FrmDadosFornecedorProduto},
  uFrmConsultaFornecedor in 'uFrmConsultaFornecedor.pas' {FrmConsultaFornecedor},
  uFrmFiltrosBase in 'uFrmFiltrosBase.pas' {FrmFiltrosBase},
  uFrmFiltrosFornecedor in 'uFrmFiltrosFornecedor.pas' {FrmFiltrosFornecedor},
  uFrmRelBase in 'uFrmRelBase.pas' {FrmRelBase},
  uFrmRelFornecedor in 'uFrmRelFornecedor.pas' {FrmRelFornecedor},
  uFrmFiltrosProduto in 'uFrmFiltrosProduto.pas' {FrmFiltrosProduto},
  uFrmRelProduto in 'uFrmRelProduto.pas' {FrmRelProduto},
  uPedidoVendaDAOClient in 'DAOClient\uPedidoVendaDAOClient.pas',
  uFrmFiltrosPedidoVenda in 'uFrmFiltrosPedidoVenda.pas' {FrmFiltrosPedidoVenda},
  uFrmRelPedidoVenda in 'uFrmRelPedidoVenda.pas' {FrmRelPedidoVenda},
  ItemPedidoVenda in '..\Entidades\ItemPedidoVenda.pas',
  PedidoVenda in '..\Entidades\PedidoVenda.pas',
  uFrmFiltrosEstoque in 'uFrmFiltrosEstoque.pas' {FrmFiltrosEstoque},
  uFrmRelEstoque in 'uFrmRelEstoque.pas' {FrmRelEstoque},
  DataUtils in '..\Utils\DataUtils.pas',
  uFramePesquisaTipoProduto in 'uFramePesquisaTipoProduto.pas' {FramePesquisaTipoProduto: TFrame},
  uFramePesquisaFornecedor in 'uFramePesquisaFornecedor.pas' {FramePesquisaFornecedor: TFrame},
  uFramePesquisaProduto in 'uFramePesquisaProduto.pas' {FramePesquisaProduto: TFrame},
  Validade in '..\Entidades\Validade.pas',
  ufrmDadosValidade in 'ufrmDadosValidade.pas' {FrmDadosValidade},
  uFrmLogin in 'uFrmLogin.pas' {FrmLogin},
  uTipoProdutoDAOClient in 'DAOClient\uTipoProdutoDAOClient.pas',
  Usuario in '..\Entidades\Usuario.pas',
  uFrmUsuario in 'uFrmUsuario.pas' {FrmUsuario},
  uFrmDadosUsuario in 'uFrmDadosUsuario.pas' {FrmDadosUsuario},
  uClienteDAOClient in 'DAOClient\uClienteDAOClient.pas',
  Cliente in '..\Entidades\Cliente.pas',
  uFrmCliente in 'uFrmCliente.pas' {FrmCliente},
  uFrmDadosCliente in 'uFrmDadosCliente.pas' {FrmDadosCliente},
  uFrmConexaoServidor in 'uFrmConexaoServidor.pas' {FrmConexaoServidor},
  uFrmConectandoServidor in 'uFrmConectandoServidor.pas' {FrmConectandoServidor},
  uCaixaDAOClient in 'DAOClient\uCaixaDAOClient.pas',
  Caixa in '..\Entidades\Caixa.pas',
  uFrmFiltrosCaixas in 'uFrmFiltrosCaixas.pas' {FrmFiltrosCaixas},
  uFrmRelCaixas in 'uFrmRelCaixas.pas' {FrmRelCaixas},
  uContaPagarDAOClient in 'DAOClient\uContaPagarDAOClient.pas',
  uContaReceberDAOClient in 'DAOClient\uContaReceberDAOClient.pas',
  ContaPagar in '..\Entidades\ContaPagar.pas',
  ContaReceber in '..\Entidades\ContaReceber.pas',
  uFrmContaPagar in 'uFrmContaPagar.pas' {FrmContaPagar},
  uFrmContaReceber in 'uFrmContaReceber.pas' {FrmContaReceber},
  uFrmDadosContaPagar in 'uFrmDadosContaPagar.pas' {FrmDadosContaPagar},
  uFrmDadosContaReceber in 'uFrmDadosContaReceber.pas' {FrmDadosContaReceber};

{$R *.res}

var
  fLogin: TFrmLogin;
  fConexaoServidor: TFrmConexaoServidor;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Top Commerce - Sistema de Controle de Comércio';

  if not( FileExists( ChangeFileExt( Application.ExeName, '.INI' ) ) ) then
  begin
    fConexaoServidor := TFrmConexaoServidor.Create(nil);
    try
      fConexaoServidor.ShowModal;
    finally
      fConexaoServidor.Free;
    end;
  end;

  fLogin := TFrmLogin.Create( nil );
  try
    fLogin.ShowModal;
    if fLogin.FLoginSucess then
    begin
      Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  if fLogin.Usuario <> nil then
        FrmPrincipal.lblLogin.Caption := 'Usuário: ' + fLogin.Usuario.Login
      else
        FrmPrincipal.lblLogin.Caption := 'Usuário: TOP';
    end;
  finally
    fLogin.Free;
  end;
  Application.Run;
end.
