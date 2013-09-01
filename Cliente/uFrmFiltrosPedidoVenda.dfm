inherited FrmFiltrosPedidoVenda: TFrmFiltrosPedidoVenda
  Caption = 'Relat'#243'rio de Pedidos de Venda'
  ClientHeight = 69
  OnShow = FormShow
  ExplicitHeight = 97
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlFiltros: TPanel
    Height = 41
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 41
      Height = 14
      Caption = 'Per'#237'odo'
    end
    object Label2: TLabel
      Left = 166
      Top = 11
      Width = 6
      Height = 14
      Caption = 'a'
    end
    object deDataInicial: TDateTimePicker
      Left = 55
      Top = 8
      Width = 103
      Height = 22
      Date = 41503.566427175920000000
      Time = 41503.566427175920000000
      TabOrder = 0
    end
    object deDataFinal: TDateTimePicker
      Left = 178
      Top = 8
      Width = 103
      Height = 22
      Date = 41503.566427175920000000
      Time = 41503.566427175920000000
      TabOrder = 1
    end
  end
end
