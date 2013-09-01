inherited FrmRelProduto: TFrmRelProduto
  Caption = 'Listagem de Produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited cdsRelatorio: TClientDataSet
    Left = 64
    Top = 232
    object cdsRelatorioCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsRelatorioCODIGO_TIPO_PRODUTO: TStringField
      FieldName = 'CODIGO_TIPO_PRODUTO'
      Size = 3
    end
    object cdsRelatorioDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsRelatorioCODIGO_BARRAS: TStringField
      FieldName = 'CODIGO_BARRAS'
    end
    object cdsRelatorioPRECO_VENDA: TCurrencyField
      FieldName = 'PRECO_VENDA'
    end
    object cdsRelatorioDESCRICAO_TIPO_PRODUTO: TStringField
      FieldName = 'DESCRICAO_TIPO_PRODUTO'
      Size = 60
    end
    object cdsRelatorioPRECO_COMPRA: TCurrencyField
      FieldName = 'PRECO_COMPRA'
    end
    object cdsRelatorioNOME_FORNECEDOR: TStringField
      FieldName = 'NOME_FORNECEDOR'
      Size = 60
    end
  end
end
