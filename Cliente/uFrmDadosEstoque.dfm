inherited FrmDadosEstoque: TFrmDadosEstoque
  ClientHeight = 97
  ClientWidth = 552
  ExplicitWidth = 558
  ExplicitHeight = 122
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 552
    ExplicitWidth = 552
    inherited chbContinuarIncluindo: TCheckBox
      Left = 426
      ExplicitLeft = 426
    end
  end
  inherited pnlDados: TPanel
    Width = 552
    Height = 69
    ExplicitWidth = 552
    ExplicitHeight = 69
    object Label1: TLabel
      Left = 8
      Top = 42
      Width = 63
      Height = 14
      Caption = 'Quantidade'
    end
    inline FramePesquisaProduto: TFramePesquisaProduto
      Left = 8
      Top = 8
      Width = 537
      Height = 25
      AutoSize = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = 8
      ExplicitWidth = 537
      inherited edtCodigoProduto: TEdit
        Left = 71
        OnExit = FramePesquisaProdutoedtCodigoProdutoExit
        ExplicitLeft = 71
      end
      inherited bbtConsultarProduto: TBitBtn
        Left = 125
        ExplicitLeft = 125
      end
      inherited edtDescricaoProduto: TEdit
        Left = 156
        ExplicitLeft = 156
      end
    end
    object sedQuantidade: TSpinEdit
      Left = 79
      Top = 39
      Width = 68
      Height = 23
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
end
