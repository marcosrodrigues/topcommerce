inherited FrmDadosProduto: TFrmDadosProduto
  ClientHeight = 527
  ClientWidth = 741
  ExplicitWidth = 747
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 14
  inherited splDados: TSplitter
    Top = 244
    Width = 741
    ExplicitTop = 163
    ExplicitWidth = 578
  end
  object Panel1: TPanel [1]
    Left = 0
    Top = 275
    Width = 741
    Height = 252
    Align = alClient
    TabOrder = 4
    ExplicitTop = 264
    ExplicitHeight = 263
  end
  inherited pnlBotoes: TPanel
    Width = 741
    ExplicitWidth = 741
    inherited chbContinuarIncluindo: TCheckBox
      Left = 615
      ExplicitLeft = 615
    end
  end
  inherited pnlDados: TPanel
    Width = 741
    Height = 216
    ExplicitWidth = 741
    ExplicitHeight = 216
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 37
      Height = 14
      Caption = 'C'#243'digo'
    end
    object Label4: TLabel
      Left = 176
      Top = 11
      Width = 91
      Height = 14
      Caption = 'C'#243'digo de Barras'
    end
    object Label2: TLabel
      Left = 8
      Top = 41
      Width = 51
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object Label5: TLabel
      Left = 8
      Top = 161
      Width = 88
      Height = 14
      Caption = 'Pre'#231'o de Venda'
    end
    object Label7: TLabel
      Left = 8
      Top = 190
      Width = 52
      Height = 14
      Caption = 'Endere'#231'o'
    end
    object Label8: TLabel
      Left = 8
      Top = 106
      Width = 95
      Height = 14
      Caption = 'Margem de Lucro'
    end
    object Label11: TLabel
      Left = 8
      Top = 126
      Width = 211
      Height = 13
      Caption = 'A margem de lucro calcula o pre'#231'o de venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 8
      Top = 138
      Width = 172
      Height = 13
      Caption = 'com base no maior pre'#231'o de compra'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtCodigo: TEdit
      Left = 110
      Top = 8
      Width = 51
      Height = 22
      Enabled = False
      MaxLength = 6
      TabOrder = 0
    end
    object edtCodigoBarras: TEdit
      Left = 272
      Top = 8
      Width = 154
      Height = 22
      MaxLength = 20
      TabOrder = 1
      OnExit = edtCodigoBarrasExit
    end
    object bbtGerarCodigoBarras: TBitBtn
      Left = 428
      Top = 6
      Width = 30
      Height = 25
      DoubleBuffered = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFDFEFD9FC2A2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8BBC905E9D63FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF9BCBA066B06E61AA683D8B4437833E327B373D7F436496689EBC
        A0E6EDE6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAAD8AF73BD7C96D19F94CF9C8F
        CD968ACA9185C78B7ABE8165AD6C4B925168976BCDDCCEFFFFFFFFFFFFFFFFFF
        FFFFFFA9DBAF79C4839ED7A79BD4A497D29F92CF9A8DCC9588CA907AC2827EC4
        855DA46369996CE6EDE6FFFFFFFFFFFFFFFFFFFFFFFFA4DAAB7BC78577C28154
        AB5E4EA357499B5163AC6B83C38B87C98F82C689509756A0BFA2FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF9ED8A57BC784FFFFFFFFFFFFFFFFFF9BC9A05BA26286C6
        8E88C98F6FB376699D6DB8D7BBB6D4B9B4D1B6B2CEB4AFCBB1FDFEFDB4E2BAFF
        FFFFFFFFFFFFFFFFFFFFFFA4CFA854A05B48954F408B47478B4E5DA9644C9C54
        48954F49904F97BE9BFFFFFFFFFFFFFFFFFFFFFFFF92B294FCFDFCBEDFC2BCDC
        BFBAD9BDB7D6BBB5D3B884C38B80C3898DCC9583C48A54995A90BA94FFFFFFFF
        FFFFFFFFFF4A814D739C76FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB7DEBB75BF7E
        98D2A194CF9C86C78D5EA765398640347E3A2E763349904F458B4A7EA581FFFF
        FFFFFFFFFFFFFFFFFFFFEDF7EE8ECD9685C98E9BD4A48FCE9892CF9A8DCC9588
        CA9083C68B7EC48579C17F478D4C87AC89FFFFFFFFFFFFFFFFFFFFFFFFDCF0DE
        90CF9779C38389CA9294D09C95D19E90CF998CCB9487C98F80C4874E95548FB3
        92FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDF8EFB9E1BE89C99064B46C50A65A4B
        9E5345964D60A8685BA2628CB690FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF67AB6E8BBC90FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFACD4B0FDFEFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentDoubleBuffered = False
      TabOrder = 2
      TabStop = False
      OnClick = bbtGerarCodigoBarrasClick
    end
    object edtDescricao: TEdit
      Left = 110
      Top = 38
      Width = 465
      Height = 22
      MaxLength = 60
      TabOrder = 3
    end
    object gbEstoque: TGroupBox
      Left = 481
      Top = 96
      Width = 249
      Height = 91
      Caption = ' Estoque '
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 9
      object Label6: TLabel
        Left = 12
        Top = 24
        Width = 63
        Height = 14
        Caption = 'Quantidade'
      end
      object Label3: TLabel
        Left = 12
        Top = 55
        Width = 103
        Height = 14
        Caption = 'Quantidade Minima'
      end
      object sedQuantidadeEstoque: TSpinEdit
        Left = 120
        Top = 21
        Width = 68
        Height = 23
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object sedEstoqueMinimo: TSpinEdit
        Left = 120
        Top = 52
        Width = 68
        Height = 23
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
    end
    inline FramePesquisaTipoProduto: TFramePesquisaTipoProduto
      Left = 8
      Top = 68
      Width = 567
      Height = 25
      AutoSize = True
      TabOrder = 4
      ExplicitLeft = 8
      ExplicitTop = 68
      ExplicitWidth = 567
      inherited Label3: TLabel
        Width = 90
        Height = 14
        ExplicitWidth = 90
        ExplicitHeight = 14
      end
      inherited edtCodigoTipoProduto: TEdit
        Left = 102
        Height = 22
        ExplicitLeft = 102
        ExplicitHeight = 22
      end
      inherited bbtConsultarTipoProduto: TBitBtn
        Left = 137
        ExplicitLeft = 137
      end
      inherited edtDescricaoTipoProduto: TEdit
        Left = 167
        Height = 22
        ExplicitLeft = 167
        ExplicitHeight = 22
      end
    end
    object edtEndereco: TEdit
      Left = 110
      Top = 187
      Width = 121
      Height = 22
      MaxLength = 60
      TabOrder = 7
    end
    object cedPrecoVenda: TCurrencyEdit
      Left = 110
      Top = 158
      Width = 121
      Height = 22
      Margins.Left = 4
      Margins.Top = 1
      TabOrder = 6
    end
    object cedMargemLucro: TCurrencyEdit
      Left = 110
      Top = 103
      Width = 121
      Height = 22
      Margins.Left = 4
      Margins.Top = 1
      DisplayFormat = '% ,0.00;-% ,0.00'
      TabOrder = 5
      OnExit = cedMargemLucroExit
    end
    object GroupBox1: TGroupBox
      Left = 256
      Top = 96
      Width = 213
      Height = 91
      Caption = ' Desconto M'#225'ximo '
      TabOrder = 8
      object Label9: TLabel
        Left = 12
        Top = 24
        Width = 27
        Height = 14
        Caption = 'Valor'
      end
      object Label10: TLabel
        Left = 12
        Top = 55
        Width = 58
        Height = 14
        Caption = 'Percentual'
      end
      object cedDescontoMaximoValor: TCurrencyEdit
        Left = 75
        Top = 21
        Width = 121
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        TabOrder = 0
      end
      object cedDescontoMaximoPercentual: TCurrencyEdit
        Left = 75
        Top = 52
        Width = 121
        Height = 22
        Margins.Left = 4
        Margins.Top = 1
        DisplayFormat = '% ,0.00;-% ,0.00'
        TabOrder = 1
      end
    end
  end
  inherited pnlDetails: TPanel
    Top = 275
    Width = 741
    Height = 252
    ExplicitTop = 264
    ExplicitWidth = 741
    ExplicitHeight = 263
    inherited pgcDetail: TPageControl
      Width = 739
      Height = 250
      ActivePage = tbsFornecedores
      ExplicitWidth = 739
      ExplicitHeight = 261
      object tbsFornecedores: TTabSheet
        Caption = '&Fornecedores'
        ExplicitHeight = 232
        object grdFornecedores: TDBGrid
          Left = 0
          Top = 0
          Width = 731
          Height = 221
          Align = alClient
          DataSource = dsFornecedores
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
      object tbsValidades: TTabSheet
        Caption = '&Validades'
        ImageIndex = 1
        ExplicitHeight = 232
        object grdValidades: TDBGrid
          Left = 0
          Top = 0
          Width = 731
          Height = 221
          Align = alClient
          DataSource = dsValidades
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
      end
    end
  end
  inherited pnlBotoesDetails: TPanel
    Top = 247
    Width = 741
    ExplicitTop = 236
    ExplicitWidth = 741
    inherited sbtNovo: TSpeedButton
      OnClick = sbtNovoClick
    end
    inherited sbtEditar: TSpeedButton
      OnClick = sbtEditarClick
    end
    inherited sbtExcluir: TSpeedButton
      OnClick = sbtExcluirClick
    end
  end
  object dsFornecedores: TDataSource
    DataSet = cdsFornecedores
    Left = 112
    Top = 296
  end
  object cdsFornecedores: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'x1'
        Fields = 'CODIGO_FORNECEDOR'
        Options = [ixPrimary]
      end
      item
        Name = 'x2'
        Fields = 'PRECO_COMPRA'
        Options = [ixCaseInsensitive]
      end>
    IndexFieldNames = 'CODIGO_FORNECEDOR'
    Params = <>
    StoreDefs = True
    AfterPost = cdsFornecedoresAfterPost
    Left = 32
    Top = 296
    object cdsFornecedoresCODIGO_FORNECEDOR: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 3
      FieldName = 'CODIGO_FORNECEDOR'
      Size = 3
    end
    object cdsFornecedoresNOME_FORNECEDOR: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 55
      FieldName = 'NOME_FORNECEDOR'
      Size = 60
    end
    object cdsFornecedoresPRECO_COMPRA: TCurrencyField
      DisplayLabel = 'Pre'#231'o de Compra'
      DisplayWidth = 10
      FieldName = 'PRECO_COMPRA'
    end
  end
  object dsValidades: TDataSource
    DataSet = cdsValidades
    Left = 112
    Top = 352
  end
  object cdsValidades: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'x1'
        Fields = 'DATA'
        Options = [ixPrimary]
      end>
    IndexFieldNames = 'DATA'
    Params = <>
    StoreDefs = True
    Left = 32
    Top = 352
    object cdsValidadesDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
  end
end
