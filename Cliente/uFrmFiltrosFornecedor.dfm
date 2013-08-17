inherited FrmFiltrosFornecedor: TFrmFiltrosFornecedor
  Caption = 'Listagem de Fornecedores'
  ClientHeight = 72
  ClientWidth = 529
  ExplicitWidth = 535
  ExplicitHeight = 97
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Width = 529
    ExplicitWidth = 529
    inherited sbtFechar: TSpeedButton
      Left = 447
      ExplicitLeft = 447
    end
  end
  inherited pnlFiltros: TPanel
    Width = 529
    Height = 44
    ExplicitWidth = 529
    ExplicitHeight = 44
    inline FramePesquisaProduto: TFramePesquisaProduto
      Left = 8
      Top = 8
      Width = 512
      Height = 25
      AutoSize = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 8
      ExplicitTop = 8
    end
  end
end
