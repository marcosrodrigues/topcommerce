inherited FrmConsultaFornecedor: TFrmConsultaFornecedor
  Caption = 'Consulta de Fornecedores'
  ClientWidth = 592
  ExplicitWidth = 608
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
      FieldName = 'CODIGO'
      Size = 3
    end
    object cdsConsultaNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 60
    end
    object cdsConsultaTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
      Size = 10
    end
  end
end
