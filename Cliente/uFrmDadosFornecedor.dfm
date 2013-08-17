inherited FrmDadosFornecedor: TFrmDadosFornecedor
  ClientHeight = 127
  ClientWidth = 479
  ExplicitWidth = 485
  ExplicitHeight = 152
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 479
    ExplicitWidth = 479
    inherited chbContinuarIncluindo: TCheckBox
      Left = 353
      ExplicitLeft = 353
    end
  end
  inherited pnlDados: TPanel
    Width = 479
    Height = 99
    ExplicitWidth = 479
    ExplicitHeight = 99
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 37
      Height = 14
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 8
      Top = 41
      Width = 32
      Height = 14
      Caption = 'Nome'
    end
    object Label3: TLabel
      Left = 8
      Top = 71
      Width = 49
      Height = 14
      Caption = 'Telefone'
    end
    object edtCodigo: TEdit
      Left = 66
      Top = 8
      Width = 44
      Height = 22
      Enabled = False
      MaxLength = 3
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 66
      Top = 38
      Width = 405
      Height = 22
      MaxLength = 60
      TabOrder = 1
    end
    object mkdTelefone: TMaskEdit
      Left = 66
      Top = 68
      Width = 99
      Height = 23
      EditMask = '!\(99\)0000-0000;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Courier New'
      Font.Style = []
      MaxLength = 13
      ParentFont = False
      TabOrder = 2
    end
  end
end
