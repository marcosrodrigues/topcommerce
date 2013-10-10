inherited FrmProduto: TFrmProduto
  Caption = 'Cadastro de Produtos'
  ClientHeight = 459
  ClientWidth = 820
  ExplicitWidth = 836
  ExplicitHeight = 497
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 820
    ExplicitWidth = 820
    inherited sbtFechar: TSpeedButton
      Left = 738
      ExplicitLeft = 652
    end
  end
  inherited grdCrud: TDBGrid
    Width = 820
    Height = 389
  end
  inherited pnlPesquisar: TPanel
    Top = 417
    Width = 820
    ExplicitTop = 417
    ExplicitWidth = 820
    inherited edtPesquisar: TEdit
      Width = 818
      ExplicitWidth = 818
    end
  end
  inherited cdsCrud: TClientDataSet
    object cdsCrudCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 6
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsCrudDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 40
      FieldName = 'DESCRICAO'
      Size = 60
    end
    object cdsCrudCODIGO_TIPO_PRODUTO: TStringField
      FieldName = 'CODIGO_TIPO_PRODUTO'
      Visible = False
      Size = 3
    end
    object cdsCrudDESCRICAO_TIPO_PRODUTO: TStringField
      DisplayLabel = 'Tipo de Produto'
      DisplayWidth = 30
      FieldName = 'DESCRICAO_TIPO_PRODUTO'
      Size = 60
    end
    object cdsCrudPRECO_VENDA: TCurrencyField
      DisplayLabel = 'Pre'#231'o de Venda'
      DisplayWidth = 10
      FieldName = 'PRECO_VENDA'
    end
    object cdsCrudESTOQUE_MINIMO: TIntegerField
      FieldName = 'ESTOQUE_MINIMO'
      Visible = False
    end
    object cdsCrudCODIGO_BARRAS: TStringField
      DisplayLabel = 'C'#243'digo de Barras'
      DisplayWidth = 20
      FieldName = 'CODIGO_BARRAS'
    end
    object cdsCrudQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
      Visible = False
    end
    object cdsCrudENDERECO: TStringField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'ENDERECO'
      Size = 50
    end
    object cdsCrudMARGEM_LUCRO: TCurrencyField
      FieldName = 'MARGEM_LUCRO'
      Visible = False
    end
    object cdsCrudDESCONTO_MAXIMO_VALOR: TCurrencyField
      FieldName = 'DESCONTO_MAXIMO_VALOR'
      Visible = False
    end
    object cdsCrudDESCONTO_MAXIMO_PERCENTUAL: TCurrencyField
      FieldName = 'DESCONTO_MAXIMO_PERCENTUAL'
      Visible = False
    end
  end
end
