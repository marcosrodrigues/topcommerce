inherited FrmCargo: TFrmCargo
  Caption = 'Cadastro de Cargos'
  ClientWidth = 647
  ExplicitWidth = 663
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 647
    inherited sbtFechar: TSpeedButton
      Left = 565
    end
  end
  inherited grdCrud: TDBGrid
    Width = 647
  end
  inherited pnlPesquisar: TPanel
    Width = 647
    inherited edtPesquisar: TEdit
      Width = 645
    end
  end
  inherited cdsCrud: TClientDataSet
    object cdsCrudID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object cdsCrudDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 60
      FieldName = 'DESCRICAO'
      Size = 150
    end
  end
end
