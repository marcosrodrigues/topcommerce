inherited FrmFiltrosPedidoVenda: TFrmFiltrosPedidoVenda
  Caption = 'Relat'#243'rio de Pedidos de Venda'
  ClientHeight = 136
  ClientWidth = 621
  OnShow = FormShow
  ExplicitWidth = 627
  ExplicitHeight = 164
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 621
    ExplicitWidth = 541
    inherited sbtFechar: TSpeedButton
      Left = 539
      ExplicitLeft = 439
    end
  end
  inherited pnlFiltros: TPanel
    Width = 621
    Height = 108
    ExplicitWidth = 541
    ExplicitHeight = 108
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 41
      Height = 14
      Caption = 'Per'#237'odo'
    end
    object Label2: TLabel
      Left = 238
      Top = 11
      Width = 6
      Height = 14
      Caption = 'a'
    end
    object Label3: TLabel
      Left = 8
      Top = 43
      Width = 108
      Height = 14
      Caption = 'Tipo de Pagamento'
    end
    object Label4: TLabel
      Left = 256
      Top = 11
      Width = 6
      Height = 14
      Caption = 'a'
    end
    object cbTipoPagamento: TComboBox
      Left = 127
      Top = 40
      Width = 145
      Height = 22
      TabOrder = 0
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'Dinheiro'
        'Credi'#225'rio'
        'Cart'#227'o de Cr'#233'dito'
        'Cart'#227'o de D'#233'bito'
        'Cheque')
    end
    inline FramePesquisaCliente: TFramePesquisaCliente
      Left = 8
      Top = 71
      Width = 604
      Height = 25
      AutoSize = True
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 71
      ExplicitWidth = 604
      inherited Label3: TLabel
        Width = 37
        Height = 14
        ExplicitWidth = 37
        ExplicitHeight = 14
      end
      inherited edtCodigoCliente: TEdit
        Left = 119
        Height = 22
        ExplicitLeft = 119
        ExplicitHeight = 22
      end
      inherited bbtConsultarCliente: TBitBtn
        Left = 174
        ExplicitLeft = 174
      end
      inherited edtNomeCliente: TEdit
        Left = 204
        Height = 22
        ExplicitLeft = 204
        ExplicitHeight = 22
      end
    end
    object deDataInicial: TDateEdit
      Left = 127
      Top = 8
      Width = 121
      Height = 22
      NumGlyphs = 2
      TabOrder = 2
    end
    object deDataFinal: TDateEdit
      Left = 272
      Top = 8
      Width = 121
      Height = 22
      NumGlyphs = 2
      TabOrder = 3
    end
  end
end
