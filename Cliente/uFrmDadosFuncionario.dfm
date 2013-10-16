inherited FrmDadosFuncionario: TFrmDadosFuncionario
  Caption = 'FrmDadosFuncionario'
  ClientHeight = 129
  ClientWidth = 544
  ExplicitWidth = 550
  ExplicitHeight = 157
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 544
    inherited chbContinuarIncluindo: TCheckBox
      Left = 418
    end
  end
  inherited pnlDados: TPanel
    Width = 544
    Height = 101
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
      Width = 32
      Height = 14
      Caption = 'Nome'
    end
    object edtCodigo: TEdit
      Left = 66
      Top = 8
      Width = 49
      Height = 22
      Enabled = False
      MaxLength = 3
      TabOrder = 0
    end
    object edtNome: TEdit
      Left = 66
      Top = 37
      Width = 380
      Height = 22
      MaxLength = 60
      TabOrder = 1
    end
    inline FramePesquisaCargo: TFramePesquisaCargo
      Left = 8
      Top = 68
      Width = 527
      Height = 25
      AutoSize = True
      TabOrder = 2
      ExplicitLeft = 8
      ExplicitTop = 68
      ExplicitWidth = 527
      inherited Label3: TLabel
        Width = 31
        Height = 14
        ExplicitWidth = 31
        ExplicitHeight = 14
      end
      inherited edtIdCargo: TEdit
        Left = 58
        Height = 22
        ExplicitLeft = 58
        ExplicitHeight = 22
      end
      inherited bbtConsultarCargo: TBitBtn
        Left = 97
        ExplicitLeft = 97
      end
      inherited edtDescricaoCargo: TEdit
        Left = 127
        Height = 22
        ExplicitLeft = 127
        ExplicitHeight = 22
      end
    end
  end
end
