inherited FrmFiltrosCaixas: TFrmFiltrosCaixas
  Caption = 'Relat'#243'rio de Caixas'
  ClientHeight = 103
  OnShow = FormShow
  ExplicitHeight = 131
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlFiltros: TPanel
    Height = 75
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 41
      Height = 14
      Caption = 'Per'#237'odo'
    end
    object Label2: TLabel
      Left = 8
      Top = 45
      Width = 46
      Height = 14
      Caption = 'Situa'#231#227'o'
    end
    object Label3: TLabel
      Left = 200
      Top = 11
      Width = 6
      Height = 14
      Caption = 'a'
    end
    object deDataInicial: TDateEdit
      Left = 69
      Top = 8
      Width = 121
      Height = 22
      NumGlyphs = 2
      TabOrder = 0
    end
    object deDataFinal: TDateEdit
      Left = 216
      Top = 8
      Width = 121
      Height = 22
      NumGlyphs = 2
      TabOrder = 1
    end
    object cbSituacao: TComboBox
      Left = 69
      Top = 42
      Width = 145
      Height = 22
      ItemIndex = 0
      TabOrder = 2
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'Abertos'
        'Fechados')
    end
  end
end
