inherited FrmRelContasReceber: TFrmRelContasReceber
  Caption = 'FrmRelContasReceber'
  ClientWidth = 1153
  ExplicitWidth = 1169
  ExplicitHeight = 662
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport: TRLReport
    Width = 1123
    Height = 794
    PageSetup.Orientation = poLandscape
    ExplicitWidth = 1123
    ExplicitHeight = 794
    inherited RLBand1: TRLBand
      Width = 1047
      ExplicitWidth = 1047
      inherited RLLabel1: TRLLabel
        Width = 166
        Caption = 'Contas a Receber'
        ExplicitWidth = 166
      end
    end
    inherited RLBand5: TRLBand
      Width = 1047
      ExplicitWidth = 1047
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 144
      Width = 1047
      Height = 20
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RLLabel3: TRLLabel
        Left = 0
        Top = 0
        Width = 334
        Height = 19
        Align = faLeft
        AutoSize = False
        Caption = 'Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Left = 987
        Top = 0
        Width = 60
        Height = 19
        Align = faRight
        Alignment = taCenter
        AutoSize = False
        Caption = 'Baixada'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 334
        Top = 0
        Width = 87
        Height = 19
        Align = faLeft
        AutoSize = False
        Caption = 'Vencimento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel7: TRLLabel
        Left = 421
        Top = 0
        Width = 143
        Height = 19
        Align = faLeft
        Alignment = taRightJustify
        AutoSize = False
        Caption = 'Valor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel8: TRLLabel
        Left = 564
        Top = 0
        Width = 423
        Height = 19
        Align = faClient
        AutoSize = False
        Caption = 'Observa'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 164
      Width = 1047
      Height = 20
      object RLDBText1: TRLDBText
        Left = 0
        Top = 0
        Width = 334
        Height = 20
        AutoSize = False
        DataField = 'NOME'
        DataSource = dsRelatorio
        Holder = RLLabel3
      end
      object RLDBText2: TRLDBText
        Left = 334
        Top = 0
        Width = 87
        Height = 20
        AutoSize = False
        DataField = 'VENCIMENTO'
        DataSource = dsRelatorio
        Holder = RLLabel5
      end
      object RLDBText3: TRLDBText
        Left = 421
        Top = 0
        Width = 143
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VALOR'
        DataSource = dsRelatorio
        Holder = RLLabel7
      end
      object RLDBText4: TRLDBText
        Left = 564
        Top = 0
        Width = 423
        Height = 20
        AutoSize = False
        DataField = 'OBSERVACOES'
        DataSource = dsRelatorio
        Holder = RLLabel8
      end
      object RLDBText5: TRLDBText
        Left = 987
        Top = 0
        Width = 60
        Height = 20
        AutoSize = False
        DataField = 'BAIXADA'
        DataSource = dsRelatorio
        Holder = RLLabel4
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 184
      Width = 1047
      Height = 20
      BandType = btSummary
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = True
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLDBResult1: TRLDBResult
        Left = 421
        Top = 0
        Width = 143
        Height = 20
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'VALOR'
        DataSource = dsRelatorio
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Holder = RLDBText3
        Info = riSum
        ParentFont = False
      end
      object RLDBResult2: TRLDBResult
        Left = 82
        Top = 1
        Width = 49
        Height = 19
        Align = faLeft
        DataField = 'ID'
        DataSource = dsRelatorio
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Info = riCount
        ParentFont = False
      end
      object RLLabel9: TRLLabel
        Left = 0
        Top = 1
        Width = 82
        Height = 19
        Align = faLeft
        Caption = 'Quantidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited cdsRelatorio: TClientDataSet
    object cdsRelatorioID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsRelatorioCLIENTE_CODIGO: TStringField
      FieldName = 'CLIENTE_CODIGO'
      Visible = False
      Size = 6
    end
    object cdsRelatorioNOME: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 40
      FieldName = 'NOME'
      OnGetText = cdsRelatorioNOMEGetText
      Size = 60
    end
    object cdsRelatorioNOME_CLIENTE_AVULSO: TStringField
      DisplayLabel = 'Cliente Avulso'
      DisplayWidth = 35
      FieldName = 'NOME_CLIENTE_AVULSO'
      Size = 60
    end
    object cdsRelatorioVENCIMENTO: TDateTimeField
      DisplayLabel = 'Vencimento'
      FieldName = 'VENCIMENTO'
    end
    object cdsRelatorioVALOR: TCurrencyField
      DisplayLabel = 'Valor'
      DisplayWidth = 15
      FieldName = 'VALOR'
    end
    object cdsRelatorioOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Visible = False
      Size = 255
    end
    object cdsRelatorioBAIXADA: TBooleanField
      FieldName = 'BAIXADA'
      Visible = False
      OnGetText = cdsRelatorioBAIXADAGetText
    end
  end
end
