inherited FrmRelCaixas: TFrmRelCaixas
  Caption = 'FrmRelCaixas'
  ExplicitWidth = 834
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport: TRLReport
    inherited RLBand1: TRLBand
      inherited RLLabel1: TRLLabel
        Width = 65
        Caption = 'Caixas'
        ExplicitWidth = 65
      end
    end
    object RLGroup1: TRLGroup
      Left = 38
      Top = 128
      Width = 718
      Height = 103
      DataFields = 'ID'
      BeforePrint = RLGroup1BeforePrint
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 48
        BandType = btColumnHeader
        object RLDBText1: TRLDBText
          Left = 61
          Top = 8
          Width = 16
          Height = 16
          DataField = 'ID'
          DataSource = dsRelatorio
        end
        object RLLabel3: TRLLabel
          Left = 8
          Top = 8
          Width = 53
          Height = 16
          Caption = 'C'#243'digo:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel4: TRLLabel
          Left = 128
          Top = 8
          Width = 37
          Height = 16
          Caption = 'Data:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText3: TRLDBText
          Left = 168
          Top = 8
          Width = 38
          Height = 16
          DataField = 'DATA'
          DataSource = dsRelatorio
        end
        object RLLabel5: TRLLabel
          Left = 376
          Top = 8
          Width = 121
          Height = 16
          Caption = 'Valor de Abertura:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLDBText4: TRLDBText
          Left = 502
          Top = 8
          Width = 125
          Height = 16
          DataField = 'VALOR_ABERTURA'
          DataSource = dsRelatorio
        end
        object RLLabel7: TRLLabel
          Left = 0
          Top = 28
          Width = 51
          Height = 20
          Align = faLeftBottom
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'Origem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel8: TRLLabel
          Left = 51
          Top = 28
          Width = 66
          Height = 20
          Align = faLeftBottom
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'Opera'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel9: TRLLabel
          Left = 117
          Top = 28
          Width = 601
          Height = 20
          Align = faClientBottom
          Alignment = taRightJustify
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLBand3: TRLBand
        Left = 0
        Top = 48
        Width = 718
        Height = 20
        BeforePrint = RLBand3BeforePrint
        object RLDBText2: TRLDBText
          Left = 51
          Top = 0
          Width = 66
          Height = 16
          AutoSize = False
          DataField = 'OPERACAO'
          DataSource = dsRelatorio
          Holder = RLLabel8
        end
        object RLDBText5: TRLDBText
          Left = 0
          Top = 0
          Width = 51
          Height = 16
          AutoSize = False
          DataField = 'ORIGEM'
          DataSource = dsRelatorio
          Holder = RLLabel7
        end
        object RLDBText6: TRLDBText
          Left = 117
          Top = 0
          Width = 601
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALOR'
          DataSource = dsRelatorio
          Holder = RLLabel9
        end
      end
      object RLBand4: TRLBand
        Left = 0
        Top = 68
        Width = 718
        Height = 19
        BandType = btColumnFooter
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        BeforePrint = RLBand4BeforePrint
        object rlbTotalMovimentos: TRLLabel
          Left = 603
          Top = 1
          Width = 115
          Height = 18
          Align = faRight
          Alignment = taRightJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object RLLabel10: TRLLabel
          Left = 277
          Top = 1
          Width = 104
          Height = 18
          Align = faRight
          Caption = 'Total do Caixa:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel11: TRLLabel
          Left = 460
          Top = 1
          Width = 143
          Height = 18
          Align = faRight
          Caption = 'Total de Movimentos:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object rlbTotalCaixa: TRLLabel
          Left = 381
          Top = 1
          Width = 79
          Height = 18
          Align = faRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  inherited cdsRelatorio: TClientDataSet
    object cdsRelatorioID: TIntegerField
      FieldName = 'ID'
    end
    object cdsRelatorioDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object cdsRelatorioFECHADO: TBooleanField
      FieldName = 'FECHADO'
    end
    object cdsRelatorioVALOR_ABERTURA: TCurrencyField
      FieldName = 'VALOR_ABERTURA'
    end
    object cdsRelatorioORIGEM: TIntegerField
      FieldName = 'ORIGEM'
      OnGetText = cdsRelatorioORIGEMGetText
    end
    object cdsRelatorioVALOR: TCurrencyField
      FieldName = 'VALOR'
    end
    object cdsRelatorioOPERACAO: TIntegerField
      FieldName = 'OPERACAO'
      OnGetText = cdsRelatorioOPERACAOGetText
    end
  end
end
