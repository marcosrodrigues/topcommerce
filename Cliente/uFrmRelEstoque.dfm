inherited FrmRelEstoque: TFrmRelEstoque
  Caption = 'FrmRelEstoque'
  ExplicitWidth = 834
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport: TRLReport
    inherited RLBand1: TRLBand
      inherited RLLabel1: TRLLabel
        Width = 78
        Caption = 'Estoque'
        ExplicitWidth = 78
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 128
      Width = 718
      Height = 20
      BandType = btColumnHeader
      object RLLabel3: TRLLabel
        Left = 0
        Top = 0
        Width = 49
        Height = 20
        Align = faLeft
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Left = 49
        Top = 0
        Width = 370
        Height = 20
        Align = faClient
        Caption = 'Produto'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 603
        Top = 0
        Width = 115
        Height = 20
        Align = faRight
        Caption = 'Pre'#231'o de Compra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 525
        Top = 0
        Width = 78
        Height = 20
        Align = faRight
        Alignment = taCenter
        Caption = 'Quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 419
        Top = 0
        Width = 106
        Height = 20
        Align = faRight
        Alignment = taCenter
        Caption = 'Estoque Minimo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 148
      Width = 718
      Height = 20
      object RLDBText1: TRLDBText
        Left = 0
        Top = 0
        Width = 49
        Height = 16
        AutoSize = False
        DataField = 'CODIGO_PRODUTO'
        DataSource = dsRelatorio
        Holder = RLLabel3
      end
      object RLDBText2: TRLDBText
        Left = 49
        Top = 0
        Width = 370
        Height = 16
        AutoSize = False
        DataField = 'DESCRICAO_PRODUTO'
        DataSource = dsRelatorio
        Holder = RLLabel4
      end
      object RLDBText3: TRLDBText
        Left = 525
        Top = 0
        Width = 78
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'QUANTIDADE'
        DataSource = dsRelatorio
        Holder = RLLabel7
      end
      object RLDBText4: TRLDBText
        Left = 603
        Top = 0
        Width = 115
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'PRECO_COMPRA'
        DataSource = dsRelatorio
        Holder = RLLabel5
      end
      object RLDBText5: TRLDBText
        Left = 419
        Top = 0
        Width = 106
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'ESTOQUE_MINIMO'
        DataSource = dsRelatorio
        Holder = RLLabel8
      end
    end
  end
  inherited cdsRelatorio: TClientDataSet
    object cdsRelatorioCODIGO_PRODUTO: TStringField
      FieldName = 'CODIGO_PRODUTO'
      Size = 6
    end
    object cdsRelatorioDESCRICAO_PRODUTO: TStringField
      DisplayWidth = 60
      FieldName = 'DESCRICAO_PRODUTO'
      Size = 60
    end
    object cdsRelatorioQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object cdsRelatorioPRECO_COMPRA: TCurrencyField
      FieldName = 'PRECO_COMPRA'
    end
    object cdsRelatorioESTOQUE_MINIMO: TIntegerField
      FieldName = 'ESTOQUE_MINIMO'
    end
  end
end
