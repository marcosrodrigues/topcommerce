object FrmConsultaProdutos: TFrmConsultaProdutos
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Consulta de Produtos'
  ClientHeight = 398
  ClientWidth = 1044
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 24
  object pnlParametros: TPanel
    Left = 0
    Top = 0
    Width = 1044
    Height = 49
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      1044
      49)
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 84
      Height = 24
      Caption = 'Consultar'
    end
    object edtConsultar: TEdit
      Left = 99
      Top = 8
      Width = 934
      Height = 32
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = edtConsultarChange
      OnKeyPress = edtConsultarKeyPress
    end
  end
  object grdConsulta: TDBGrid
    Left = 0
    Top = 49
    Width = 1044
    Height = 308
    Align = alClient
    DataSource = dsConsulta
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -20
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grdConsultaDblClick
    OnKeyPress = grdConsultaKeyPress
  end
  object pnlResultado: TPanel
    Left = 0
    Top = 357
    Width = 1044
    Height = 41
    Align = alBottom
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 9
      Width = 189
      Height = 24
      Caption = 'Total de Registros:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotalRegistros: TLabel
      Left = 201
      Top = 9
      Width = 149
      Height = 24
      Caption = 'lblTotalRegistros'
    end
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 104
    Top = 128
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 128
    object cdsConsultaCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsConsultaDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 35
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsConsultaCODIGO_TIPO_PRODUTO: TStringField
      FieldName = 'CODIGO_TIPO_PRODUTO'
      Visible = False
      Size = 3
    end
    object cdsConsultaDESCRICAO_TIPO_PRODUTO: TStringField
      DisplayLabel = 'Tipo de Produto'
      DisplayWidth = 25
      FieldName = 'DESCRICAO_TIPO_PRODUTO'
      Size = 60
    end
    object cdsConsultaPRECO_VENDA: TCurrencyField
      DisplayLabel = 'Pre'#231'o de Venda'
      FieldName = 'PRECO_VENDA'
    end
    object cdsConsultaCODIGO_BARRAS: TStringField
      FieldName = 'CODIGO_BARRAS'
      Visible = False
    end
    object cdsConsultaQUANTIDADE: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
    end
  end
end
