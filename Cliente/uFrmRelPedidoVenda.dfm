inherited FrmRelPedidoVenda: TFrmRelPedidoVenda
  Caption = 'FrmRelPedidoVenda'
  ExplicitLeft = -120
  ExplicitWidth = 834
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport: TRLReport
    object RLGroup1: TRLGroup
      Left = 38
      Top = 107
      Width = 718
      Height = 81
      DataFields = 'CODIGO'
      object RLBand2: TRLBand
        Left = 0
        Top = 0
        Width = 718
        Height = 50
        BandType = btColumnHeader
        object RLDBText1: TRLDBText
          Left = 184
          Top = 8
          Width = 38
          Height = 16
          DataField = 'DATA'
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
        object RLDBText3: TRLDBText
          Left = 61
          Top = 8
          Width = 55
          Height = 16
          DataField = 'CODIGO'
          DataSource = dsRelatorio
        end
        object RLLabel4: TRLLabel
          Left = 144
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
        object RLLabel5: TRLLabel
          Left = 0
          Top = 30
          Width = 49
          Height = 20
          Align = faLeftBottom
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = True
          Borders.DrawRight = False
          Borders.DrawBottom = True
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RLLabel7: TRLLabel
          Left = 49
          Top = 30
          Width = 553
          Height = 20
          Align = faClientBottom
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
        object RLLabel9: TRLLabel
          Left = 680
          Top = 30
          Width = 38
          Height = 20
          Align = faRightBottom
          Alignment = taCenter
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
        object RLLabel8: TRLLabel
          Left = 602
          Top = 30
          Width = 78
          Height = 20
          Align = faRightBottom
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
      object RLBand3: TRLBand
        Left = 0
        Top = 50
        Width = 718
        Height = 20
        object RLDBText2: TRLDBText
          Left = 49
          Top = 0
          Width = 553
          Height = 20
          Align = faClient
          AutoSize = False
          DataField = 'DESCRICAO'
          DataSource = dsRelatorio
          Holder = RLLabel7
        end
        object RLDBText4: TRLDBText
          Left = 0
          Top = 0
          Width = 49
          Height = 20
          Align = faLeft
          AutoSize = False
          DataField = 'CODIGO_PRODUTO'
          DataSource = dsRelatorio
          Holder = RLLabel5
        end
        object RLDBText5: TRLDBText
          Left = 602
          Top = 0
          Width = 78
          Height = 20
          Align = faRight
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'QUANTIDADE'
          DataSource = dsRelatorio
          Holder = RLLabel8
        end
        object RLDBText6: TRLDBText
          Left = 680
          Top = 0
          Width = 38
          Height = 20
          Align = faRight
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'VALOR'
          DataSource = dsRelatorio
          Holder = RLLabel9
        end
      end
    end
  end
  inherited cdsRelatorio: TClientDataSet
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
      OnGetText = cdsRelatorioTIPO_PAGAMENTOGetText
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
      OnGetText = cdsRelatorioNOMEGetText
      Size = 60
    end
  end
end
