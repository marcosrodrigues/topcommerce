inherited FrmConsultaCliente: TFrmConsultaCliente
  Caption = 'Consulta de Clientes'
  PixelsPerInch = 96
  TextHeight = 14
  inherited cdsConsulta: TClientDataSet
    object cdsConsultaCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 6
      FieldName = 'CODIGO'
      Size = 6
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
