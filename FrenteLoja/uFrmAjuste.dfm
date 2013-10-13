object FrmAjuste: TFrmAjuste
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Item do Pedido'
  ClientHeight = 310
  ClientWidth = 607
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
    Width = 607
    Height = 41
    Align = alTop
    Color = 3682350
    ParentBackground = False
    TabOrder = 5
    object lblDescricaoProduto: TLabel
      Left = 1
      Top = 1
      Width = 605
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
  object cedPrecoUnitario: TCurrencyEdit
    Left = 10
    Top = 77
    Width = 167
    Height = 33
    Margins.Top = 1
    Enabled = False
    TabOrder = 0
  end
  object cedDescValor: TCurrencyEdit
    Left = 10
    Top = 204
    Width = 167
    Height = 33
    Margins.Top = 1
    TabOrder = 2
    OnExit = cedDescValorExit
  end
  object cedDescPercentual: TCurrencyEdit
    Left = 194
    Top = 204
    Width = 167
    Height = 33
    Margins.Top = 1
    DisplayFormat = '% ,0.00;-% ,0.00'
    TabOrder = 3
    OnExit = cedDescPercentualExit
  end
  object cedPrecoTotal: TCurrencyEdit
    Left = 10
    Top = 269
    Width = 167
    Height = 33
    Margins.Top = 1
    TabOrder = 4
  end
  object sedQuantidade: TSpinEdit
    Left = 10
    Top = 141
    Width = 167
    Height = 35
    MaxValue = 10000
    MinValue = 1
    TabOrder = 1
    Value = 1
    OnChange = sedQuantidadeChange
  end
end
