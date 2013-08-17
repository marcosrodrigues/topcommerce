inherited FrmDadosUsuario: TFrmDadosUsuario
  ClientHeight = 93
  ExplicitWidth = 450
  ExplicitHeight = 118
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlDados: TPanel
    Height = 65
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 39
      Height = 14
      Caption = 'Usu'#225'rio'
    end
    object Label2: TLabel
      Left = 8
      Top = 39
      Width = 34
      Height = 14
      Caption = 'Senha'
    end
    object edtUsuario: TEdit
      Left = 64
      Top = 8
      Width = 147
      Height = 22
      CharCase = ecUpperCase
      MaxLength = 15
      TabOrder = 0
    end
    object edtSenha: TEdit
      Left = 64
      Top = 36
      Width = 147
      Height = 22
      MaxLength = 20
      PasswordChar = '*'
      TabOrder = 1
    end
  end
end
