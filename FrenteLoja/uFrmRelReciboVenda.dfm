inherited FrmRelReciboVenda: TFrmRelReciboVenda
  Caption = 'FrmRelReciboVenda'
  ExplicitWidth = 834
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport: TRLReport
    Top = 7
    PreviewOptions.WindowState = wsNormal
    PreviewOptions.ShowModal = True
    PrintDialog = False
    ExplicitTop = 7
    inherited RLBand1: TRLBand
      inherited RLLabel1: TRLLabel
        Width = 157
        Caption = 'Recibo de Venda'
        ExplicitWidth = 157
      end
    end
    object RLBand2: TRLBand [1]
      Left = 38
      Top = 144
      Width = 718
      Height = 117
      BandType = btColumnHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = True
      Borders.DrawTop = True
      Borders.DrawRight = True
      Borders.DrawBottom = True
      BeforePrint = RLBand2BeforePrint
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
      object RLDBText3: TRLDBText
        Left = 64
        Top = 8
        Width = 55
        Height = 16
        DataField = 'CODIGO'
        DataSource = dsRelatorio
      end
      object RLLabel4: TRLLabel
        Left = 147
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
      object RLDBText1: TRLDBText
        Left = 187
        Top = 8
        Width = 38
        Height = 16
        DataField = 'DATA'
        DataSource = dsRelatorio
      end
      object RLLabel12: TRLLabel
        Left = 438
        Top = 8
        Width = 104
        Height = 16
        Caption = 'Desconto Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText9: TRLDBText
        Left = 546
        Top = 8
        Width = 76
        Height = 16
        DataField = 'DESCONTO'
        DataSource = dsRelatorio
      end
      object RLLabel13: TRLLabel
        Left = 438
        Top = 29
        Width = 139
        Height = 16
        Caption = 'Desconto Percentual:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText10: TRLDBText
        Left = 582
        Top = 29
        Width = 221
        Height = 16
        DataField = 'VENDA_DESCONTO_PERCENTUAL'
        DataSource = dsRelatorio
        BeforePrint = RLDBText10BeforePrint
      end
      object RLDBText13: TRLDBText
        Left = 541
        Top = 71
        Width = 108
        Height = 16
        DataField = 'LOGIN_USUARIO'
        DataSource = dsRelatorio
      end
      object RLLabel16: TRLLabel
        Left = 438
        Top = 71
        Width = 97
        Height = 16
        Caption = 'Usu'#225'rio Caixa:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText12: TRLDBText
        Left = 288
        Top = 71
        Width = 49
        Height = 16
        DataField = 'TROCO'
        DataSource = dsRelatorio
      end
      object RLLabel15: TRLLabel
        Left = 240
        Top = 71
        Width = 44
        Height = 16
        Caption = 'Troco:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText4: TRLDBText
        Left = 145
        Top = 49
        Width = 123
        Height = 16
        DataField = 'TIPO_PAGAMENTO'
        DataSource = dsRelatorio
        BeforePrint = RLDBText4BeforePrint
      end
      object RLLabel5: TRLLabel
        Left = 8
        Top = 49
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
      object RLDBText11: TRLDBText
        Left = 64
        Top = 29
        Width = 43
        Height = 16
        DataField = 'NOME'
        DataSource = dsRelatorio
      end
      object RLLabel7: TRLLabel
        Left = 8
        Top = 29
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
      object RLLabel14: TRLLabel
        Left = 8
        Top = 71
        Width = 68
        Height = 16
        Caption = 'Recebido:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBText14: TRLDBText
        Left = 82
        Top = 71
        Width = 71
        Height = 16
        DataField = 'RECEBIDO'
        DataSource = dsRelatorio
      end
      object RLLabel8: TRLLabel
        Left = 1
        Top = 96
        Width = 49
        Height = 20
        Align = faLeftBottom
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 50
        Top = 96
        Width = 250
        Height = 20
        Align = faLeftBottom
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Caption = 'Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel19: TRLLabel
        Left = 300
        Top = 96
        Width = 79
        Height = 20
        Align = faLeftBottom
        Alignment = taRightJustify
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Caption = 'Desc. Perc.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel18: TRLLabel
        Left = 379
        Top = 96
        Width = 81
        Height = 20
        Align = faLeftBottom
        Alignment = taRightJustify
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Caption = 'Desc. Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel17: TRLLabel
        Left = 460
        Top = 96
        Width = 79
        Height = 20
        Align = faLeftBottom
        Alignment = taRightJustify
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Caption = 'Pre'#231'o Unit.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel10: TRLLabel
        Left = 539
        Top = 96
        Width = 78
        Height = 20
        Align = faLeftBottom
        Alignment = taRightJustify
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel11: TRLLabel
        Left = 617
        Top = 96
        Width = 100
        Height = 20
        Align = faClientBottom
        Alignment = taRightJustify
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand3: TRLBand [2]
      Left = 38
      Top = 261
      Width = 718
      Height = 20
      object RLDBText2: TRLDBText
        Left = 1
        Top = 0
        Width = 49
        Height = 20
        AutoSize = False
        DataField = 'CODIGO_PRODUTO'
        DataSource = dsRelatorio
        Holder = RLLabel8
      end
      object RLDBText5: TRLDBText
        Left = 50
        Top = 0
        Width = 250
        Height = 20
        AutoSize = False
        DataField = 'DESCRICAO'
        DataSource = dsRelatorio
        Holder = RLLabel9
      end
      object RLDBText15: TRLDBText
        Left = 300
        Top = 0
        Width = 79
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'ITEM_DESCONTO_PERCENTUAL'
        DataSource = dsRelatorio
        Holder = RLLabel19
        BeforePrint = RLDBText10BeforePrint
      end
      object RLDBText16: TRLDBText
        Left = 379
        Top = 0
        Width = 81
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'ITEM_DESCONTO_VALOR'
        DataSource = dsRelatorio
        Holder = RLLabel18
      end
      object RLDBText17: TRLDBText
        Left = 460
        Top = 0
        Width = 79
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'PRECO_VENDA'
        DataSource = dsRelatorio
        Holder = RLLabel17
      end
      object RLDBText6: TRLDBText
        Left = 539
        Top = 0
        Width = 78
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'QUANTIDADE'
        DataSource = dsRelatorio
        Holder = RLLabel10
      end
      object RLDBText8: TRLDBText
        Left = 617
        Top = 0
        Width = 100
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VALOR'
        DataSource = dsRelatorio
        Holder = RLLabel11
      end
    end
    object RLBand4: TRLBand [3]
      Left = 38
      Top = 281
      Width = 718
      Height = 20
      BandType = btColumnFooter
      BeforePrint = RLBand4BeforePrint
      object rlbTotalVenda: TRLLabel
        Left = 617
        Top = 0
        Width = 100
        Height = 20
        Align = faRight
        Alignment = taRightJustify
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Holder = RLDBText8
      end
    end
  end
  inherited cdsRelatorio: TClientDataSet
    Top = 208
    object cdsRelatorioCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsRelatorioDATA: TSQLTimeStampField
      FieldName = 'DATA'
    end
    object cdsRelatorioDESCONTO: TCurrencyField
      FieldName = 'DESCONTO'
    end
    object cdsRelatorioTIPO_PAGAMENTO: TIntegerField
      FieldName = 'TIPO_PAGAMENTO'
    end
    object cdsRelatorioCODIGO_CLIENTE: TStringField
      FieldName = 'CODIGO_CLIENTE'
      Size = 6
    end
    object cdsRelatorioNOME_CLIENTE_AVULSO: TStringField
      FieldName = 'NOME_CLIENTE_AVULSO'
      Size = 60
    end
    object cdsRelatorioCODIGO_PRODUTO: TStringField
      FieldName = 'CODIGO_PRODUTO'
      Size = 6
    end
    object cdsRelatorioQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsRelatorioDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsRelatorioVALOR: TCurrencyField
      FieldName = 'VALOR'
    end
    object cdsRelatorioNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsRelatorioVENDA_DESCONTO_PERCENTUAL: TCurrencyField
      FieldName = 'VENDA_DESCONTO_PERCENTUAL'
      currency = False
    end
    object cdsRelatorioTOTAL: TCurrencyField
      FieldName = 'TOTAL'
    end
    object cdsRelatorioRECEBIDO: TCurrencyField
      FieldName = 'RECEBIDO'
    end
    object cdsRelatorioTROCO: TCurrencyField
      FieldName = 'TROCO'
    end
    object cdsRelatorioLOGIN_USUARIO: TStringField
      FieldName = 'LOGIN_USUARIO'
    end
    object cdsRelatorioITEM_DESCONTO_VALOR: TCurrencyField
      FieldName = 'ITEM_DESCONTO_VALOR'
    end
    object cdsRelatorioITEM_DESCONTO_PERCENTUAL: TCurrencyField
      FieldName = 'ITEM_DESCONTO_PERCENTUAL'
      currency = False
    end
    object cdsRelatorioPRECO_VENDA: TCurrencyField
      FieldName = 'PRECO_VENDA'
    end
  end
end
