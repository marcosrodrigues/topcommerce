object FrmDXPSelectBrowser: TFrmDXPSelectBrowser
  Left = 0
  Top = 0
  Caption = 'FrmDXPSelectBrowser'
  ClientHeight = 203
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object grdSelectBrowser: TDBGrid
    Left = 0
    Top = 0
    Width = 400
    Height = 203
    Align = alClient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grdSelectBrowserDblClick
    OnKeyDown = grdSelectBrowserKeyDown
    OnKeyPress = grdSelectBrowserKeyPress
  end
end
