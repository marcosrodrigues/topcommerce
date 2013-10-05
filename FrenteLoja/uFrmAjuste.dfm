object FrmAjuste: TFrmAjuste
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Item do Pedido'
  ClientHeight = 310
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -21
  Font.Name = 'Ubuntu Condensed'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 25
  object Label1: TLabel
    Left = 10
    Top = 50
    Width = 112
    Height = 25
    Caption = 'Pre'#231'o Unit'#225'rio'
  end
  object Label2: TLabel
    Left = 10
    Top = 113
    Width = 92
    Height = 25
    Caption = 'Quantidade'
  end
  object Label4: TLabel
    Left = 10
    Top = 241
    Width = 86
    Height = 25
    Caption = 'Pre'#231'o Total'
  end
  object Label3: TLabel
    Left = 10
    Top = 179
    Width = 84
    Height = 25
    Caption = 'Desc. Valor'
  end
  object Label5: TLabel
    Left = 194
    Top = 179
    Width = 127
    Height = 25
    Caption = 'Desc. Percentual'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 500
    Height = 41
    Align = alTop
    Color = 3682350
    ParentBackground = False
    TabOrder = 5
    object lblDescricaoProduto: TLabel
      Left = 1
      Top = 1
      Width = 498
      Height = 39
      Align = alClient
      Alignment = taCenter
      Caption = 'lblDescricaoProduto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4244613
      Font.Height = -27
      Font.Name = 'Ubuntu Condensed'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 208
      ExplicitHeight = 32
    end
  end
  object edtQuantidade: TEdit
    Left = 10
    Top = 140
    Width = 167
    Height = 33
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
