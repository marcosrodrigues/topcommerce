program prFrenteLoja;

uses
  Forms,
  IniFiles,
  SysUtils,
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
  uFrmConectandoServidor in '..\Cliente\uFrmConectandoServidor.pas' {FrmConectandoServidor},
  uFrmConexaoServidor in '..\Cliente\uFrmConexaoServidor.pas' {FrmConexaoServidor},
  uFrmLogin in '..\Cliente\uFrmLogin.pas' {FrmLogin},
  Usuario in '..\Entidades\Usuario.pas',
  uUsuarioDAOClient in '..\Cliente\DAOClient\uUsuarioDAOClient.pas',
  uFrmInformarCliente in 'uFrmInformarCliente.pas' {FrmInformarCliente},
  uCaixaDAOClient in '..\Cliente\DAOClient\uCaixaDAOClient.pas',
  Caixa in '..\Entidades\Caixa.pas',
  uFrmAbrirCaixa in 'uFrmAbrirCaixa.pas' {FrmAbrirCaixa},
  FuncoesBematech in '..\Utils\FuncoesBematech.pas',
  uFrmConfirm in '..\Utils\uFrmConfirm.pas' {FrmConfirm},
  uFrmError in '..\Utils\uFrmError.pas' {FrmError},
  uFrmInformation in '..\Utils\uFrmInformation.pas' {FrmInformation},
  uFrmWarning in '..\Utils\uFrmWarning.pas' {FrmWarning},
  FuncoesBematechMatricial in '..\Utils\FuncoesBematechMatricial.pas';

{$R *.res}

var
  fLogin: TFrmLogin;
  fConexaoServidor: TFrmConexaoServidor;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Frente de Loja - Top Commerce';

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
  Application.CreateForm(TFrmConectandoServidor, FrmConectandoServidor);
  Application.CreateForm(TFrmInformarCliente, FrmInformarCliente);
  Application.CreateForm(TFrmAbrirCaixa, FrmAbrirCaixa);
  Application.CreateForm(TFrmConfirm, FrmConfirm);
  Application.CreateForm(TFrmError, FrmError);
  Application.CreateForm(TFrmInformation, FrmInformation);
  Application.CreateForm(TFrmWarning, FrmWarning);
  if fLogin.Usuario <> nil then
        FrmPrincipal.lblUsuario.Caption := fLogin.Usuario.Login
      else
        FrmPrincipal.lblUsuario.Caption := 'TOP';
    end;
  finally
    fLogin.Free;
  end;

  Application.Run;
end.
