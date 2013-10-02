object SCPrincipal: TSCPrincipal
  OldCreateOrder = False
  Height = 271
  Width = 475
  object DSServer: TDSServer
    AutoStart = True
    HideDSAdmin = False
    Left = 96
    Top = 11
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    PoolSize = 0
    Server = DSServer
    BufferKBSize = 32
    Filters = <>
    Left = 96
    Top = 73
  end
  object ConnTopCommerce: TSQLConnection
    DriverName = 'MSSQL9'
    GetDriverFunc = 'getSQLDriverMSSQL'
    LibraryName = 'dbxmss9.dll'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=DBXMSSQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver150.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=15.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDr' +
        'iver150.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMSSQLDriver,Version=15.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverMSSQL'
      'LibraryName=dbxmss9.dll'
      'VendorLib=sqlncli.dll'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OSAuthentication=False'
      'PrepareSQL=True'
      'BlobSize=-1'
      'ErrorResourceFile='
      'OS Authentication=False'
      'Prepare SQL=False')
    VendorLib = 'sqlncli.dll'
    Left = 96
    Top = 144
  end
  object TipoProduto: TDSServerClass
    OnGetClass = TipoProdutoGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 224
    Top = 13
  end
  object Produto: TDSServerClass
    OnGetClass = ProdutoGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 224
    Top = 64
  end
  object Fornecedor: TDSServerClass
    OnGetClass = FornecedorGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 224
    Top = 116
  end
  object Estoque: TDSServerClass
    OnGetClass = EstoqueGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 224
    Top = 168
  end
  object PedidoVenda: TDSServerClass
    OnGetClass = PedidoVendaGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 304
    Top = 14
  end
  object Usuario: TDSServerClass
    OnGetClass = UsuarioGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 304
    Top = 64
  end
  object Cliente: TDSServerClass
    OnGetClass = ClienteGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 300
    Top = 116
  end
  object Caixa: TDSServerClass
    OnGetClass = CaixaGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 300
    Top = 169
  end
  object ContaPagar: TDSServerClass
    OnGetClass = ContaPagarGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 385
    Top = 14
  end
  object ContaReceber: TDSServerClass
    OnGetClass = ContaReceberGetClass
    Server = DSServer
    LifeCycle = 'Session'
    Left = 385
    Top = 65
  end
end
