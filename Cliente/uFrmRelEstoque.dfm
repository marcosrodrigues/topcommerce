inherited FrmRelEstoque: TFrmRelEstoque
  Caption = 'FrmRelEstoque'
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
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
  end
end
