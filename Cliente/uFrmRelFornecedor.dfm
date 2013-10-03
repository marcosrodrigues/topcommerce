inherited FrmRelFornecedor: TFrmRelFornecedor
  Caption = 'Listagem de Fornecedores'
  ExplicitWidth = 834
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport: TRLReport
    inherited RLBand1: TRLBand
      inherited RLLabel1: TRLLabel
        Width = 128
        Caption = 'Fornecedores'
        ExplicitWidth = 128
      end
    end
  end
  inherited cdsRelatorio: TClientDataSet
    object cdsRelatorioCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 3
    end
    object cdsRelatorioNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsRelatorioTELEFONE: TStringField
      FieldName = 'TELEFONE'
      EditMask = '!\(99\)0000-0000;0; '
      Size = 10
    end
  end
end
