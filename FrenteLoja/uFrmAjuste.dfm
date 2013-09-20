object FrmAjuste: TFrmAjuste
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Item do Pedido'
  ClientHeight = 309
  ClientWidth = 371
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 24
  object Label1: TLabel
    Left = 10
    Top = 50
    Width = 125
    Height = 24
    Caption = 'Pre'#231'o Unit'#225'rio'
  end
  object Label2: TLabel
    Left = 10
    Top = 113
    Width = 103
    Height = 24
    Caption = 'Quantidade'
  end
  object Label4: TLabel
    Left = 10
    Top = 241
    Width = 101
    Height = 24
    Caption = 'Pre'#231'o Total'
  end
  object Label3: TLabel
    Left = 10
    Top = 179
    Width = 101
    Height = 24
    Caption = 'Desc. Valor'
  end
  object Label5: TLabel
    Left = 194
    Top = 179
    Width = 149
    Height = 24
    Caption = 'Desc. Percentual'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 371
    Height = 41
    Align = alTop
    Color = clHotLight
    ParentBackground = False
    TabOrder = 5
    ExplicitWidth = 456
    object lblDescricaoProduto: TLabel
      Left = 1
      Top = 1
      Width = 369
      Height = 39
      Align = alClient
      Alignment = taCenter
      Caption = 'lblDescricaoProduto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 176
      ExplicitHeight = 23
    end
  end
  object edtQuantidade: TEdit
    Left = 10
    Top = 140
    Width = 167
    Height = 32
    Alignment = taRightJustify
    NumbersOnly = True
    TabOrder = 1
    Text = '1'
    OnChange = edtQuantidadeChange
  end
  object cedPrecoUnitario: TDXPCurrencyEdit
    Left = 10
    Top = 77
    Width = 166
    Height = 32
    Alignment = taRightJustify
    Enabled = False
    Options = []
    TabOrder = 0
    Text = '0,00'
  end
  object cedDescValor: TDXPCurrencyEdit
    Left = 10
    Top = 204
    Width = 166
    Height = 32
    Alignment = taRightJustify
    Options = []
    TabOrder = 2
    Text = '0,00'
    OnExit = cedDescValorExit
  end
  object cedDescPercentual: TDXPCurrencyEdit
    Left = 194
    Top = 204
    Width = 166
    Height = 32
    Alignment = taRightJustify
    Options = []
    TabOrder = 3
    Text = '0,00'
    OnExit = cedDescPercentualExit
  end
  object cedPrecoTotal: TDXPCurrencyEdit
    Left = 10
    Top = 267
    Width = 166
    Height = 32
    Alignment = taRightJustify
    Options = []
    TabOrder = 4
    Text = '0,00'
  end
end
