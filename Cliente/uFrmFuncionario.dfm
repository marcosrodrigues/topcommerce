inherited FrmFuncionario: TFrmFuncionario
  Caption = 'Cadastro de Funcion'#225'rios'
  ClientHeight = 403
  ClientWidth = 767
  ExplicitWidth = 783
  ExplicitHeight = 441
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 767
    inherited sbtFechar: TSpeedButton
      Left = 685
    end
  end
  inherited grdCrud: TDBGrid
    Width = 767
    Height = 333
  end
  inherited pnlPesquisar: TPanel
    Top = 361
    Width = 767
    inherited edtPesquisar: TEdit
      Width = 765
    end
  end
  inherited cdsCrud: TClientDataSet
    object cdsCrudCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsCrudNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 50
      FieldName = 'NOME'
      Size = 150
    end
    object cdsCrudCARGO_ID: TIntegerField
      FieldName = 'CARGO_ID'
      Visible = False
    end
    object cdsCrudCARGO_DESCRICAO: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 40
      FieldName = 'CARGO_DESCRICAO'
      Size = 150
    end
  end
end
