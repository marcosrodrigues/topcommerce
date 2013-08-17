inherited FrmDadosFornecedorProduto: TFrmDadosFornecedorProduto
  ClientHeight = 97
  ClientWidth = 582
  ExplicitWidth = 588
  ExplicitHeight = 122
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 582
    ExplicitWidth = 582
    inherited chbContinuarIncluindo: TCheckBox
      Left = 456
      ExplicitLeft = 456
    end
  end
  inherited pnlDados: TPanel
    Width = 582
    Height = 69
    ExplicitWidth = 582
    ExplicitHeight = 69
    object Label5: TLabel
      Left = 8
      Top = 42
      Width = 94
      Height = 14
      Caption = 'Pre'#231'o de Compra'
    end
    inline FramePesquisaFornecedor: TFramePesquisaFornecedor
      Left = 8
      Top = 7
      Width = 568
      Height = 25
      AutoSize = True
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = 7
      ExplicitWidth = 568
      inherited Label3: TLabel
        Width = 62
        Height = 14
        ExplicitWidth = 62
        ExplicitHeight = 14
      end
      inherited edtCodigoFornecedor: TEdit
        Left = 100
        Height = 22
        OnExit = FramePesquisaFornecedoredtCodigoFornecedorExit
        ExplicitLeft = 100
        ExplicitHeight = 22
      end
      inherited bbtConsultarFornecedor: TBitBtn
        Left = 136
        ExplicitLeft = 136
      end
      inherited edtNomeFornecedor: TEdit
        Left = 168
        Height = 22
        ExplicitLeft = 168
        ExplicitHeight = 22
      end
    end
  end
end
