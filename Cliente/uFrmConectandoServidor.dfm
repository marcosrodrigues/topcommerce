object FrmConectandoServidor: TFrmConectandoServidor
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FrmConectandoServidor'
  ClientHeight = 85
  ClientWidth = 560
  Color = clActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 223
    Height = 46
    Caption = 'Conectando Servidor...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'Cordia New'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 66
    Width = 539
    Height = 14
    Caption = 
      'Caso demore mais de 1 minuto essa espera verificar se o servidor' +
      ' foi iniciado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 45
    Width = 539
    Height = 17
    TabOrder = 0
  end
end
