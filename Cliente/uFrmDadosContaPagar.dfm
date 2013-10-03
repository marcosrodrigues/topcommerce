inherited FrmDadosContaPagar: TFrmDadosContaPagar
  Caption = 'FrmDadosContaPagar'
  ClientHeight = 280
  ClientWidth = 589
  ExplicitWidth = 595
  ExplicitHeight = 308
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 589
    inherited chbContinuarIncluindo: TCheckBox
      Left = 463
    end
  end
  inherited pnlDados: TPanel
    Width = 589
    Height = 252
    ExplicitLeft = 48
    ExplicitTop = 29
    ExplicitWidth = 589
    ExplicitHeight = 242
    object Label3: TLabel
      Left = 8
      Top = 76
      Width = 66
      Height = 14
      Caption = 'Vencimento'
    end
    object Label1: TLabel
      Left = 8
      Top = 108
      Width = 27
      Height = 14
      Caption = 'Valor'
    end
    object Label2: TLabel
      Left = 8
      Top = 138
      Width = 69
      Height = 14
      Caption = 'Observa'#231#245'es'
    end
    object Label4: TLabel
      Left = 8
      Top = 11
      Width = 11
      Height = 14
      Caption = 'Id'
    end
    inline FramePesquisaFornecedor: TFramePesquisaFornecedor
      Left = 8
      Top = 39
      Width = 568
      Height = 25
      AutoSize = True
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 39
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
    object deVencimento: TDateTimePicker
      Left = 108
      Top = 74
      Width = 103
      Height = 22
      Date = 41503.566427175920000000
      Time = 41503.566427175920000000
      TabOrder = 2
    end
    object cedValor: TDXPCurrencyEdit
      Left = 108
      Top = 105
      Width = 121
      Height = 19
      Alignment = taRightJustify
      Options = []
      TabOrder = 3
      Text = '0,00'
    end
    object mmObservacoes: TMemo
      Left = 108
      Top = 133
      Width = 468
      Height = 108
      TabOrder = 4
    end
    object edtId: TEdit
      Left = 108
      Top = 8
      Width = 121
      Height = 22
      ReadOnly = True
      TabOrder = 0
    end
  end
end
