inherited FrmConsultaProduto: TFrmConsultaProduto
  Caption = 'Consulta de Produtos'
  ClientWidth = 592
  ExplicitWidth = 608
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlParametros: TPanel
    Width = 592
    ExplicitWidth = 592
  end
  inherited pnlResultado: TPanel
    Width = 592
    ExplicitWidth = 592
  end
  inherited grdConsulta: TDBGrid
    Width = 592
  end
  inherited cdsConsulta: TClientDataSet
    object cdsConsultaCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 6
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsConsultaDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 60
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsConsultaCODIGO_TIPO_PRODUTO: TStringField
      FieldName = 'CODIGO_TIPO_PRODUTO'
      Visible = False
      Size = 3
    end
    object cdsConsultaDESCRICAO_TIPO_PRODUTO: TStringField
      DisplayLabel = 'Tipo de Produto'
      DisplayWidth = 30
      FieldName = 'DESCRICAO_TIPO_PRODUTO'
      Size = 60
    end
    object cdsConsultaPRECO_VENDA: TCurrencyField
      DisplayLabel = 'Pre'#231'o de Venda'
      DisplayWidth = 10
      FieldName = 'PRECO_VENDA'
    end
    object cdsConsultaCODIGO_BARRAS: TStringField
      DisplayLabel = 'C'#243'digo de Barras'
      DisplayWidth = 20
      FieldName = 'CODIGO_BARRAS'
    end
    object cdsConsultaQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      Visible = False
    end
  end
end
