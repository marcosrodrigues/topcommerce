inherited FrmDadosTipoProduto: TFrmDadosTipoProduto
  ClientHeight = 93
  ClientWidth = 450
  ExplicitWidth = 456
  ExplicitHeight = 118
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 450
    ExplicitWidth = 450
    inherited chbContinuarIncluindo: TCheckBox
      Left = 324
      ExplicitLeft = 324
    end
  end
  inherited pnlDados: TPanel
    Width = 450
    Height = 65
    ExplicitWidth = 450
    ExplicitHeight = 65
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 37
      Height = 14
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 51
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object edtCodigo: TEdit
      Left = 64
      Top = 8
      Width = 49
      Height = 22
      Enabled = False
      MaxLength = 3
      TabOrder = 0
    end
    object edtDescricao: TEdit
      Left = 64
      Top = 37
      Width = 380
      Height = 22
      MaxLength = 60
      TabOrder = 1
    end
  end
end
