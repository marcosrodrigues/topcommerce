inherited FrmConsultaTipoProduto: TFrmConsultaTipoProduto
  Caption = 'Consulta de Tipos de Produtos'
  ClientWidth = 592
  ExplicitWidth = 320
  ExplicitHeight = 319
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
    StoreDefs = True
    object cdsConsultaCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 3
      FieldName = 'CODIGO'
      Size = 3
    end
    object cdsConsultaDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 60
      FieldName = 'DESCRICAO'
      Size = 60
    end
  end
end
