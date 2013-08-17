inherited FrmTipoProduto: TFrmTipoProduto
  Caption = 'Cadastro de Tipos de Produto'
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    inherited sbtFechar: TSpeedButton
      ExplicitLeft = 502
    end
  end
  inherited cdsCrud: TClientDataSet
    object cdsCrudCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Size = 3
    end
    object cdsCrudDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 60
      FieldName = 'DESCRICAO'
      Size = 60
    end
  end
end
