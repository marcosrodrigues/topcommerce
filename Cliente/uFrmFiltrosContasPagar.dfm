inherited FrmFiltrosContasPagar: TFrmFiltrosContasPagar
  Caption = 'Relat'#243'rio de Contas a Pagar'
  ClientHeight = 140
  ClientWidth = 552
  ExplicitWidth = 558
  ExplicitHeight = 168
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 552
    inherited sbtFechar: TSpeedButton
      Left = 470
    end
  end
  inherited pnlFiltros: TPanel
    Width = 552
    Height = 112
    object Label1: TLabel
      Left = 7
      Top = 83
      Width = 46
      Height = 14
      Caption = 'Situa'#231#227'o'
    end
    inline FramePeriodo: TFramePeriodo
      Left = 7
      Top = 10
      Width = 336
      Height = 22
      AutoSize = True
      TabOrder = 0
      ExplicitLeft = 7
      ExplicitTop = 10
      ExplicitWidth = 336
      inherited Label1: TLabel
        Width = 41
        Height = 14
        ExplicitWidth = 41
        ExplicitHeight = 14
      end
      inherited Label3: TLabel
        Left = 199
        Height = 14
        ExplicitLeft = 199
        ExplicitHeight = 14
      end
      inherited deDataInicial: TDateEdit
        Left = 68
        ExplicitLeft = 68
      end
      inherited deDataFinal: TDateEdit
        Left = 215
        ExplicitLeft = 215
      end
    end
    inline FramePesquisaFornecedor: TFramePesquisaFornecedor
      Left = 7
      Top = 45
      Width = 534
      Height = 25
      AutoSize = True
      TabOrder = 1
      ExplicitLeft = 7
      ExplicitTop = 45
      ExplicitWidth = 534
      inherited Label3: TLabel
        Width = 62
        Height = 14
        ExplicitWidth = 62
        ExplicitHeight = 14
      end
      inherited edtCodigoFornecedor: TEdit
        Left = 68
        Height = 22
        ExplicitLeft = 68
        ExplicitHeight = 22
      end
      inherited bbtConsultarFornecedor: TBitBtn
        Left = 104
        ExplicitLeft = 104
      end
      inherited edtNomeFornecedor: TEdit
        Left = 134
        Height = 22
        ExplicitLeft = 134
        ExplicitHeight = 22
      end
    end
    object cbSituacao: TComboBox
      Left = 75
      Top = 80
      Width = 145
      Height = 22
      TabOrder = 2
      Text = 'Todas'
      Items.Strings = (
        'Todas'
        'Abertas'
        'Baixadas')
    end
  end
end
