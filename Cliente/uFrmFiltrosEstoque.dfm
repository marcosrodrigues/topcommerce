inherited FrmFiltrosEstoque: TFrmFiltrosEstoque
  Caption = 'Relat'#243'rio de Estoque'
  ClientHeight = 147
  ExplicitHeight = 172
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlFiltros: TPanel
    Height = 119
    ExplicitHeight = 119
    object rgEstoque: TRadioGroup
      Left = 6
      Top = 4
      Width = 203
      Height = 105
      Caption = ' Estoque '
      ItemIndex = 0
      Items.Strings = (
        'Todos os Produtos'
        'Apenas produtos com estoque'
        'Apenas produtos sem estoque')
      TabOrder = 0
    end
  end
end
