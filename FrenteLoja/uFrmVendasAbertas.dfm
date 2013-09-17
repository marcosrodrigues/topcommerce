object FrmVendasAbertas: TFrmVendasAbertas
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Vendas Abertas'
  ClientHeight = 376
  ClientWidth = 714
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
  TextHeight = 13
  object grdConsulta: TDBGrid
    Left = 0
    Top = 0
    Width = 714
    Height = 376
    Align = alClient
    DataSource = dsConsulta
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyPress = grdConsultaKeyPress
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 128
    object cdsConsultaCODIGO: TStringField
      FieldName = 'CODIGO'
      Visible = False
    end
    object cdsConsultaDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object cdsConsultaNOME: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 20
      FieldName = 'NOME'
      Size = 60
    end
    object cdsConsultaNOME_CLIENTE_AVULSO: TStringField
      DisplayLabel = 'Cliente Avulso'
      DisplayWidth = 20
      FieldName = 'NOME_CLIENTE_AVULSO'
      Size = 60
    end
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 104
    Top = 128
  end
end
