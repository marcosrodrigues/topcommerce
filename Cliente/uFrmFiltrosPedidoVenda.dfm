inherited FrmFiltrosPedidoVenda: TFrmFiltrosPedidoVenda
  Caption = 'Relat'#243'rio de Pedidos de Venda'
  ClientHeight = 101
  OnShow = FormShow
  ExplicitHeight = 129
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlFiltros: TPanel
    Height = 73
    ExplicitHeight = 41
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
    object deDataInicial: TDateTimePicker
      Left = 127
      Top = 8
      Width = 103
      Height = 22
      Date = 41503.566427175920000000
      Time = 41503.566427175920000000
      TabOrder = 0
    end
    object deDataFinal: TDateTimePicker
      Left = 250
      Top = 8
      Width = 103
      Height = 22
      Date = 41503.566427175920000000
      Time = 41503.566427175920000000
      TabOrder = 1
    end
    object cbTipoPagamento: TComboBox
      Left = 127
      Top = 40
      Width = 145
      Height = 22
      TabOrder = 2
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'Dinheiro'
        'Cart'#227'o de Cr'#233'dito'
        'Cart'#227'o de D'#233'bito'
        'Cheque')
    end
  end
end
