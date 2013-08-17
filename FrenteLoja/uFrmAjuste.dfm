object FrmAjuste: TFrmAjuste
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Item do Pedido'
  ClientHeight = 261
  ClientWidth = 456
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
    Top = 120
    Width = 103
    Height = 24
    Caption = 'Quantidade'
  end
  object Label4: TLabel
    Left = 10
    Top = 191
    Width = 101
    Height = 24
    Caption = 'Pre'#231'o Total'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 456
    Height = 41
    Align = alTop
    Color = clHotLight
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 578
    object lblDescricaoProduto: TLabel
      Left = 1
      Top = 1
      Width = 176
      Height = 23
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
    end
  end
  object edtQuantidade: TEdit
    Left = 10
    Top = 147
    Width = 167
    Height = 32
    Alignment = taRightJustify
    TabOrder = 1
    Text = '1'
    OnChange = edtQuantidadeChange
    OnKeyPress = edtQuantidadeKeyPress
  end
  object Panel2: TPanel
    Left = 10
    Top = 76
    Width = 167
    Height = 32
    AutoSize = True
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 2
    object edtPrecoUnitario: TEdit
      Left = 0
      Top = 0
      Width = 167
      Height = 32
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0,00'
    end
  end
  object Panel3: TPanel
    Left = 10
    Top = 217
    Width = 166
    Height = 32
    AutoSize = True
    BevelOuter = bvNone
    Enabled = False
    TabOrder = 3
    object edtPrecoTotal: TEdit
      Left = 0
      Top = 0
      Width = 166
      Height = 32
      Alignment = taRightJustify
      TabOrder = 0
      Text = '0,00'
    end
  end
end
