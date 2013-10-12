inherited FrmMovimentoCaixa: TFrmMovimentoCaixa
  Caption = 'Movimento de Caixa'
  ClientHeight = 443
  ClientWidth = 812
  ExplicitWidth = 828
  ExplicitHeight = 481
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 812
    inherited sbtNovo: TSpeedButton
      Enabled = False
    end
    inherited sbtEditar: TSpeedButton
      Enabled = False
    end
    inherited sbtExcluir: TSpeedButton
      Enabled = False
    end
    inherited sbtFechar: TSpeedButton
      Left = 730
    end
  end
  inherited grdCrud: TDBGrid
    Width = 812
    Height = 373
  end
  inherited pnlPesquisar: TPanel
    Top = 401
    Width = 812
    inherited edtPesquisar: TEdit
      Width = 810
    end
  end
  inherited cdsCrud: TClientDataSet
    object cdsRelatorioID: TIntegerField
      DisplayLabel = 'Caixa'
      FieldName = 'ID'
    end
    object cdsRelatorioDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
    end
    object cdsRelatorioFECHADO: TBooleanField
      DisplayLabel = 'Fechado'
      FieldName = 'FECHADO'
    end
    object cdsRelatorioVALOR_ABERTURA: TCurrencyField
      DisplayLabel = 'Valor de Abertura'
      FieldName = 'VALOR_ABERTURA'
    end
    object cdsCrudORIGEM: TIntegerField
      DisplayLabel = 'Origem da Movimenta'#231#227'o'
      DisplayWidth = 20
      FieldName = 'ORIGEM'
      OnGetText = cdsCrudORIGEMGetText
    end
    object cdsCrudVALOR: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
    end
    object cdsCrudOPERACAO: TIntegerField
      DisplayLabel = 'Opera'#231#227'o'
      FieldName = 'OPERACAO'
      OnGetText = cdsCrudOPERACAOGetText
    end
  end
end
