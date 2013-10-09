inherited FrmConsultaBase: TFrmConsultaBase
  BorderIcons = [biSystemMenu]
  Caption = 'FrmConsultaBase'
  ClientHeight = 292
  ClientWidth = 584
  Constraints.MinWidth = 600
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 600
  ExplicitHeight = 330
  PixelsPerInch = 96
  TextHeight = 14
  object pnlParametros: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 39
    Align = alTop
    TabOrder = 0
    DesignSize = (
      584
      39)
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 50
      Height = 14
      Caption = 'Consultar'
    end
    object edtConsultar: TEdit
      Left = 64
      Top = 8
      Width = 511
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = edtConsultarChange
      OnKeyDown = edtConsultarKeyDown
    end
  end
  object pnlResultado: TPanel
    Left = 0
    Top = 268
    Width = 584
    Height = 24
    Align = alBottom
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 4
      Width = 116
      Height = 14
      Caption = 'Total de Registros:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTotalRegistros: TLabel
      Left = 128
      Top = 4
      Width = 88
      Height = 14
      Caption = 'lblTotalRegistros'
    end
  end
  object grdConsulta: TDBGrid
    Left = 0
    Top = 39
    Width = 584
    Height = 229
    Align = alClient
    DataSource = dsConsulta
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grdConsultaDblClick
    OnKeyPress = grdConsultaKeyPress
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 97
    Top = 88
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 88
  end
end
