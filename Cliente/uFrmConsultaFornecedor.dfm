inherited FrmConsultaFornecedor: TFrmConsultaFornecedor
  Caption = 'Consulta de Fornecedores'
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
    object cdsConsultaCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 3
    end
    object cdsConsultaNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsConsultaTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 10
    end
  end
end
