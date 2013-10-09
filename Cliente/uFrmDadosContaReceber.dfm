inherited FrmDadosContaReceber: TFrmDadosContaReceber
  Caption = 'FrmDadosContaReceber'
  ClientHeight = 281
  ClientWidth = 602
  ExplicitWidth = 608
  ExplicitHeight = 309
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 602
    inherited chbContinuarIncluindo: TCheckBox
      Left = 476
    end
  end
  inherited pnlDados: TPanel
    Width = 602
    Height = 253
    object Label4: TLabel
      Left = 8
      Top = 11
      Width = 11
      Height = 14
      Caption = 'Id'
    end
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
    object edtId: TEdit
      Left = 108
      Top = 8
      Width = 121
      Height = 22
      ReadOnly = True
      TabOrder = 0
    end
    object mmObservacoes: TMemo
      Left = 108
      Top = 133
      Width = 485
      Height = 108
      TabOrder = 4
    end
    inline FramePesquisaCliente: TFramePesquisaCliente
      Left = 8
      Top = 40
      Width = 585
      Height = 25
      AutoSize = True
      TabOrder = 1
      ExplicitLeft = 8
      ExplicitTop = 40
      ExplicitWidth = 585
      inherited Label3: TLabel
        Width = 37
        Height = 14
        ExplicitWidth = 37
        ExplicitHeight = 14
      end
      inherited edtCodigoCliente: TEdit
        Left = 100
        Height = 22
        ExplicitLeft = 100
        ExplicitHeight = 22
      end
      inherited bbtConsultarCliente: TBitBtn
        Left = 155
        ExplicitLeft = 155
      end
      inherited edtNomeCliente: TEdit
        Left = 185
        Height = 22
        ExplicitLeft = 185
        ExplicitHeight = 22
      end
    end
    object deVencimento: TDateEdit
      Left = 108
      Top = 73
      Width = 121
      Height = 22
      NumGlyphs = 2
      TabOrder = 2
    end
    object cedValor: TCurrencyEdit
      Left = 108
      Top = 105
      Width = 121
      Height = 22
      Margins.Left = 4
      Margins.Top = 1
      TabOrder = 3
    end
  end
end
