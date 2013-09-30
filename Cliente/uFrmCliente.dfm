inherited FrmCliente: TFrmCliente
  Caption = 'Cadastro de Clientes'
  PixelsPerInch = 96
  TextHeight = 14
  inherited cdsCrud: TClientDataSet
    object cdsCrudCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsCrudNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 60
    end
    object cdsCrudTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 12
      FieldName = 'TELEFONE'
      EditMask = '!\(99\)0000-0000;0; '
      Size = 10
    end
  end
end
