inherited FrmDadosCargo: TFrmDadosCargo
  Caption = 'FrmDadosCargo'
  ClientHeight = 98
  ClientWidth = 456
  ExplicitWidth = 462
  ExplicitHeight = 126
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 456
    inherited chbContinuarIncluindo: TCheckBox
      Left = 330
    end
  end
  inherited pnlDados: TPanel
    Width = 456
    Height = 70
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 11
      Height = 14
      Caption = 'Id'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 51
      Height = 14
      Caption = 'Descri'#231#227'o'
    end
    object edtId: TEdit
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
      MaxLength = 150
      TabOrder = 1
    end
  end
end
