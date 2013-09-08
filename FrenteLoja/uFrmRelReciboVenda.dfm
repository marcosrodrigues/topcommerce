inherited FrmRelReciboVenda: TFrmRelReciboVenda
  Caption = 'FrmRelReciboVenda'
  ExplicitLeft = -24
  ExplicitWidth = 834
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport: TRLReport
    object RLBand2: TRLBand
      Left = 38
      Top = 107
      Width = 718
      Height = 112
      BandType = btColumnHeader
      object RLDBText1: TRLDBText
        Left = 147
        Top = 6
        Width = 38
        Height = 16
        DataField = 'DATA'
        DataSource = dsRelatorio
      end
      object RLLabel3: TRLLabel
        Left = 104
        Top = 6
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
      object RLLabel4: TRLLabel
        Left = 88
        Top = 28
        Width = 53
        Height = 16
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rlbCliente: TRLLabel
        Left = 147
        Top = 28
        Width = 58
        Height = 16
        BeforePrint = rlbClienteBeforePrint
      end
      object RLLabel5: TRLLabel
        Left = 8
        Top = 50
        Width = 133
        Height = 16
        Caption = 'Tipo de Pagamento:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText3: TRLDBText
        Left = 147
        Top = 50
        Width = 123
        Height = 16
        DataField = 'TIPO_PAGAMENTO'
        DataSource = dsRelatorio
        BeforePrint = RLDBText3BeforePrint
      end
      object RLLabel7: TRLLabel
        Left = 75
        Top = 70
        Width = 66
        Height = 16
        Caption = 'Desconto:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText4: TRLDBText
        Left = 147
        Top = 70
        Width = 76
        Height = 16
        DataField = 'DESCONTO'
        DataSource = dsRelatorio
      end
      object RLPanel1: TRLPanel
        Left = 623
        Top = 92
        Width = 95
        Height = 20
        Align = faRightBottom
        object RLLabel11: TRLLabel
          Left = 0
          Top = 0
          Width = 95
          Height = 20
          Align = faClient
          Alignment = taCenter
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLPanel2: TRLPanel
        Left = 528
        Top = 92
        Width = 95
        Height = 20
        Align = faRightBottom
        object RLLabel10: TRLLabel
          Left = 0
          Top = 0
          Width = 95
          Height = 20
          Align = faClient
          Alignment = taCenter
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'Quantidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLPanel3: TRLPanel
        Left = 433
        Top = 92
        Width = 95
        Height = 20
        Align = faRightBottom
        object RLLabel9: TRLLabel
          Left = 0
          Top = 0
          Width = 95
          Height = 20
          Align = faClient
          Alignment = taCenter
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'Pre'#231'o Unt.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object RLPanel4: TRLPanel
        Left = 0
        Top = 92
        Width = 433
        Height = 20
        Align = faClientBottom
        object RLLabel8: TRLLabel
          Left = 0
          Top = 0
          Width = 433
          Height = 20
          Align = faClient
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 219
      Width = 718
      Height = 20
      BeforePrint = RLBand3BeforePrint
      object RLDBText2: TRLDBText
        Left = 0
        Top = 0
        Width = 433
        Height = 16
        AutoSize = False
        DataField = 'DESCRICAO'
        DataSource = dsRelatorio
        Holder = RLPanel4
      end
      object RLDBText5: TRLDBText
        Left = 433
        Top = 0
        Width = 95
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'PRECO_VENDA'
        DataSource = dsRelatorio
        Holder = RLPanel3
      end
      object RLDBText6: TRLDBText
        Left = 528
        Top = 0
        Width = 95
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'QUANTIDADE'
        DataSource = dsRelatorio
        Holder = RLPanel2
      end
      object rlbTotal: TRLLabel
        Left = 623
        Top = 0
        Width = 95
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        Holder = RLPanel1
        BeforePrint = rlbTotalBeforePrint
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 239
      Width = 718
      Height = 25
      BandType = btSummary
      BeforePrint = RLBand4BeforePrint
      object RLLabel13: TRLLabel
        Left = 573
        Top = 0
        Width = 50
        Height = 25
        Align = faRight
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Caption = 'Total:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
      object rlbTotalVenda: TRLLabel
        Left = 623
        Top = 0
        Width = 95
        Height = 25
        Align = faRight
        Alignment = taRightJustify
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Layout = tlCenter
        ParentFont = False
      end
    end
  end
  inherited cdsRelatorio: TClientDataSet
    Top = 208
    object cdsRelatorioQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsRelatorioDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsRelatorioPRECO_VENDA: TCurrencyField
      FieldName = 'PRECO_VENDA'
    end
    object cdsRelatorioDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object cdsRelatorioDESCONTO: TCurrencyField
      FieldName = 'DESCONTO'
    end
    object cdsRelatorioTIPO_PAGAMENTO: TIntegerField
      FieldName = 'TIPO_PAGAMENTO'
    end
    object cdsRelatorioNOME_CLIENTE_AVULSO: TStringField
      FieldName = 'NOME_CLIENTE_AVULSO'
      Size = 60
    end
    object cdsRelatorioNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
  end
end
