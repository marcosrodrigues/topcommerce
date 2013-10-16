inherited FrmConsultaCargo: TFrmConsultaCargo
  Caption = 'Consulta de Cargos'
  PixelsPerInch = 96
  TextHeight = 14
  inherited cdsConsulta: TClientDataSet
    object cdsConsultaID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsConsultaDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 150
    end
  end
end
