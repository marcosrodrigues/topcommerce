inherited FrmRelReciboVenda: TFrmRelReciboVenda
  Caption = 'FrmRelReciboVenda'
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport: TRLReport
    object RLBand2: TRLBand
      Left = 38
      Top = 107
      Width = 718
      Height = 54
      BandType = btColumnHeader
      object RLDBText1: TRLDBText
        Left = 40
        Top = 8
        Width = 38
        Height = 16
        DataField = 'DATA'
        DataSource = dsRelatorio
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 161
      Width = 718
      Height = 24
      object RLDBText2: TRLDBText
        Left = 101
        Top = 5
        Width = 80
        Height = 16
        DataField = 'DESCRICAO'
        DataSource = dsRelatorio
      end
    end
  end
  inherited cdsRelatorio: TClientDataSet
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
