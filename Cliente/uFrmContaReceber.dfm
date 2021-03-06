inherited FrmContaReceber: TFrmContaReceber
  Caption = 'Contas a Receber'
  ClientHeight = 412
  ClientWidth = 824
  Constraints.MinHeight = 450
  Constraints.MinWidth = 840
  ExplicitLeft = -46
  ExplicitWidth = 840
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 824
    ExplicitWidth = 824
    inherited sbtFechar: TSpeedButton
      Left = 742
      ExplicitLeft = 742
    end
    object sbtBaixarConta: TSpeedButton
      Left = 462
      Top = 1
      Width = 85
      Height = 25
      Hint = 'Baixar Conta'
      Caption = 'Baixar Conta'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        E0EEE17CB57FCDE3CEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFCFDFC95C59861A7666BAE6F4F9953DCEBDDE7
        F1E8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9F3EA
        7EBC82B7DEBB67AC6C75B67A4F985283B886ABCEADFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFABD3AE9CCDA06FB2738DC792AADCAF76B67B51
        9B5577B77B67A76AD0E4D1E1EEE2FFFFFFFFFFFFFFFFFFFFFFFFF2F9F37BBB80
        77B77C91CB97ABDEB19CD7A2AADDB077B77C60AC65AED8B28BC4917DB48097C2
        99E6F0E7FFFFFFFFFFFFAFD6B27FBD8497CE9CADDFB375BE7B96D59D9DD8A3AA
        DDB078B87C72BA76C3E7C8B2DAB56DBA72569E59ABCDACDAE9DA7BBB808EC893
        AFDFB5A1DAA798D79F97D69E7EC08382C187ABDDB079B97D63AE67C4E7C8C1E4
        C4B9E0BE4F9A53F3F8F3C7E5CA7DBB828FC894B0E0B6A2DAA87FC185A4D0A7DD
        EEDF80B883ABDEB17AB97F569F5AC4E7C878B87CA3CAA5FFFFFFFFFFFFEFF7EF
        80BD8490C995B0E0B685C28AF7FCF895C297DDEEDF82C287ABDEB17BBA7F58A0
        5C59A15DFCFDFCFFFFFFFFFFFFFFFFFFFFFFFF83BF8791CA96B1E0B6D9F3DDF7
        FCF8A4D0A77EC0849FD9A5ACDEB27BBB8059A15DFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF84C18A92CB97B1E1B685C38A80C18599D7A098D79F9FD9A5ACDF
        B27DBB815EA362FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF86C28B93CC98B1
        E1B7A3DBA99BD8A27ABF7EAFDFB487C38C65AA69F6FAF6FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF87C28C94CC99B2E2B7A3DCAAB0E0B68CC6926EB1
        73F7FAF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF88
        C38D94CD9AB3E2B793CB9877B77CF7FBF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF89C48F96CD9B80BE85F8FBF8FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF8BC590F8FCF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = sbtBaixarContaClick
    end
  end
  inherited grdCrud: TDBGrid
    Width = 824
    Height = 342
  end
  inherited pnlPesquisar: TPanel
    Top = 370
    Width = 824
    ExplicitTop = 370
    ExplicitWidth = 824
    inherited edtPesquisar: TEdit
      Width = 822
      ExplicitWidth = 822
    end
  end
  inherited cdsCrud: TClientDataSet
    object cdsCrudID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsCrudCLIENTE_CODIGO: TStringField
      FieldName = 'CLIENTE_CODIGO'
      Visible = False
      Size = 6
    end
    object cdsCrudNOME: TStringField
      DisplayLabel = 'Cliente'
      DisplayWidth = 40
      FieldName = 'NOME'
      Size = 60
    end
    object cdsCrudNOME_CLIENTE_AVULSO: TStringField
      DisplayLabel = 'Cliente Avulso'
      DisplayWidth = 35
      FieldName = 'NOME_CLIENTE_AVULSO'
      Size = 60
    end
    object cdsCrudVENCIMENTO: TDateTimeField
      DisplayLabel = 'Vencimento'
      FieldName = 'VENCIMENTO'
    end
    object cdsCrudVALOR: TCurrencyField
      DisplayLabel = 'Valor'
      DisplayWidth = 15
      FieldName = 'VALOR'
    end
    object cdsCrudOBSERVACOES: TStringField
      FieldName = 'OBSERVACOES'
      Visible = False
      Size = 255
    end
    object cdsCrudBAIXADA: TBooleanField
      FieldName = 'BAIXADA'
      Visible = False
    end
    object cdsCrudRESTANTE: TCurrencyField
      DisplayLabel = 'Restante'
      FieldName = 'RESTANTE'
    end
  end
end
