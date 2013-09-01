inherited FrmFiltrosProduto: TFrmFiltrosProduto
  Caption = 'Listagem de Produtos'
  ClientHeight = 207
  ClientWidth = 576
  ExplicitWidth = 582
  ExplicitHeight = 235
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 576
    ExplicitWidth = 576
    inherited sbtFechar: TSpeedButton
      Left = 494
      ExplicitLeft = 494
    end
  end
  inherited pnlFiltros: TPanel
    Width = 576
    Height = 179
    ExplicitWidth = 576
    ExplicitHeight = 179
    inline FramePesquisaTipoProduto: TFramePesquisaTipoProduto
      Left = 6
      Top = 8
      Width = 561
      Height = 25
      AutoSize = True
      TabOrder = 0
      ExplicitLeft = 6
      ExplicitTop = 8
      inherited Label3: TLabel
        Width = 90
        Height = 14
        ExplicitWidth = 90
        ExplicitHeight = 14
      end
      inherited edtCodigoTipoProduto: TEdit
        Height = 22
        ExplicitHeight = 22
      end
      inherited edtDescricaoTipoProduto: TEdit
        Height = 22
        ExplicitHeight = 22
      end
    end
    object rgEstoque: TRadioGroup
      Left = 6
      Top = 68
      Width = 203
      Height = 105
      Caption = ' Estoque '
      ItemIndex = 0
      Items.Strings = (
        'Todos os Produtos'
        'Apenas produtos com estoque'
        'Apenas produtos sem estoque')
      TabOrder = 2
    end
    inline FramePesquisaFornecedor: TFramePesquisaFornecedor
      Left = 6
      Top = 41
      Width = 562
      Height = 25
      AutoSize = True
      TabOrder = 1
      ExplicitLeft = 6
      ExplicitTop = 41
      ExplicitWidth = 562
      inherited Label3: TLabel
        Width = 62
        Height = 14
        ExplicitWidth = 62
        ExplicitHeight = 14
      end
      inherited edtCodigoFornecedor: TEdit
        Left = 96
        Height = 22
        ExplicitLeft = 96
        ExplicitHeight = 22
      end
      inherited bbtConsultarFornecedor: TBitBtn
        Left = 132
        ExplicitLeft = 132
      end
      inherited edtNomeFornecedor: TEdit
        Left = 162
        Height = 22
        ExplicitLeft = 162
        ExplicitHeight = 22
      end
    end
  end
end
