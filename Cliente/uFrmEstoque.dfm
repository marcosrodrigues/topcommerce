inherited FrmEstoque: TFrmEstoque
  Caption = 'Movimenta'#231#227'o de Estoque'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    inherited sbtExcluir: TSpeedButton
      Visible = False
    end
  end
  inherited cdsCrud: TClientDataSet
    IndexDefs = <
      item
        Name = 'x1'
        Fields = 'CODIGO_PRODUTO'
        Options = [ixPrimary]
      end>
    IndexFieldNames = 'CODIGO_PRODUTO'
    StoreDefs = True
    object cdsCrudCODIGO_PRODUTO: TStringField
      FieldName = 'CODIGO_PRODUTO'
      Visible = False
      Size = 6
    end
    object cdsCrudDESCRICAO_PRODUTO: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 60
      FieldName = 'DESCRICAO_PRODUTO'
      Size = 60
    end
    object cdsCrudQUANTIDADE: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
    end
  end
end
