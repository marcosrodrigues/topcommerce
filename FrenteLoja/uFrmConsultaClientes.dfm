object FrmConsultaClientes: TFrmConsultaClientes
  Left = 0
  Top = 0
  Caption = 'Consulta de Clientes'
  ClientHeight = 388
  ClientWidth = 1034
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
    Width = 1034
    Height = 49
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = -10
    ExplicitWidth = 1044
    DesignSize = (
      1034
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
      Width = 924
      Height = 32
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = edtConsultarChange
      OnKeyPress = edtConsultarKeyPress
      ExplicitWidth = 934
    end
  end
  object grdConsulta: TDBGrid
    Left = 0
    Top = 49
    Width = 1034
    Height = 298
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
    Top = 347
    Width = 1034
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = -10
    ExplicitWidth = 1044
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
    object cdsConsultaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 60
    end
    object cdsConsultaTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 12
      FieldName = 'TELEFONE'
      EditMask = '!\(99\)0000-0000;0; '
      Size = 10
    end
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 104
    Top = 128
  end
end
