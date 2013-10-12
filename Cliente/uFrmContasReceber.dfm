inherited FrmFiltrosContasReceber: TFrmFiltrosContasReceber
  Caption = 'Relat'#243'rio de Contas a Receber'
  ClientHeight = 136
  ClientWidth = 566
  ExplicitWidth = 572
  ExplicitHeight = 164
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 566
    ExplicitWidth = 566
    inherited sbtFechar: TSpeedButton
      Left = 484
      ExplicitLeft = 484
    end
  end
  inherited pnlFiltros: TPanel
    Width = 566
    Height = 108
    ExplicitWidth = 566
    ExplicitHeight = 108
    object Label1: TLabel
      Left = 7
      Top = 79
      Width = 46
      Height = 14
      Caption = 'Situa'#231#227'o'
    end
    inline FramePeriodo: TFramePeriodo
      Left = 10
      Top = 9
      Width = 318
      Height = 22
      AutoSize = True
      TabOrder = 0
      ExplicitLeft = 10
      ExplicitTop = 9
      ExplicitWidth = 318
      inherited Label1: TLabel
        Width = 41
        Height = 14
        ExplicitWidth = 41
        ExplicitHeight = 14
      end
      inherited Label3: TLabel
        Left = 181
        Height = 14
        ExplicitLeft = 181
        ExplicitHeight = 14
      end
      inherited deDataInicial: TDateEdit
        Left = 50
        ExplicitLeft = 50
      end
      inherited deDataFinal: TDateEdit
        Left = 197
        ExplicitLeft = 197
      end
    end
    inline FramePesquisaCliente: TFramePesquisaCliente
      Left = 10
      Top = 41
      Width = 535
      Height = 25
      AutoSize = True
      TabOrder = 1
      ExplicitLeft = 10
      ExplicitTop = 41
      ExplicitWidth = 535
      inherited Label3: TLabel
        Width = 37
        Height = 14
        ExplicitWidth = 37
        ExplicitHeight = 14
      end
      inherited edtCodigoCliente: TEdit
        Left = 50
        Height = 22
        ExplicitLeft = 50
        ExplicitHeight = 22
      end
      inherited bbtConsultarCliente: TBitBtn
        Left = 105
        ExplicitLeft = 105
      end
      inherited edtNomeCliente: TEdit
        Left = 135
        Height = 22
        ExplicitLeft = 135
        ExplicitHeight = 22
      end
    end
    object cbSituacao: TComboBox
      Left = 60
      Top = 76
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
