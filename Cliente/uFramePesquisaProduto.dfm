object FramePesquisaProduto: TFramePesquisaProduto
  Left = 0
  Top = 0
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
  object Label3: TLabel
    Left = 0
    Top = 5
    Width = 44
    Height = 14
    Caption = 'Produto'
  end
  object edtCodigoProduto: TEdit
    Left = 46
    Top = 2
    Width = 53
    Height = 22
    MaxLength = 6
    TabOrder = 0
    OnExit = edtCodigoProdutoExit
    OnKeyDown = edtCodigoProdutoKeyDown
  end
  object bbtConsultarProduto: TBitBtn
    Left = 100
    Top = 0
    Width = 30
    Height = 25
    DoubleBuffered = True
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3E3934
      393430332F2B2C2925272421201D1BE7E7E73331300B0A090707060404030000
      00000000FFFFFFFFFFFFFFFFFF46413B857A70C3B8AE7C72687F756B36322DF2
      F2F14C4A4795897DBAAEA27C72687F756B010101FFFFFFFFFFFFFFFFFF4D4741
      83786FCCC3BA786F657B716734302DFEFEFE2C2A2795897DC2B8AD786F657C72
      68060505FFFFFFFFFFFFFFFFFF554E4883786FCCC3BA79706671685F585550FF
      FFFF494645857A70C2B8AD786F657B71670D0C0BFFFFFFFFFFFFFFFFFF817B76
      9F9286CCC3BAC0B4AAA6988B807D79FFFFFF74726F908479C2B8ADC0B4AAA89B
      8E494747FFFFFFFFFFFFFCFCFC605952423D3858514A3D3833332F2B393734D3
      D3D35F5E5C1A18162522201917150F0E0D121212FDFDFDFFFFFFFDFDFD9D9185
      B1A3967F756B7C7268776D646C635B2E2A26564F4880766C7C7268776D647067
      5E010101FAFAFAFFFFFFFEFDFDB8ACA1BAAEA282776D82776DAA917BBAA794B8
      A690B097819F8D7D836D5B71635795897D232322FCFCFCFFFFFFFDFCFCDDDAD7
      9B8E829D9185867B71564F48504A4480766C6E665D826C58A6917D948474564F
      488B8A8AFEFEFEFFFFFFFFFFFFFFFFFF746B62A4978A95897D9F92863E3934FF
      FFFF4C46407E746A857A703E393485817EF5F5F5FDFDFDFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFF9B9187C3B8AE655D55FFFFFF7C7268A89B8EA69B90FFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA79C91BCB0A49D9185FF
      FFFFAEA0939D91857B756EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
    ParentDoubleBuffered = False
    TabOrder = 1
    TabStop = False
    OnClick = bbtConsultarProdutoClick
  end
  object edtDescricaoProduto: TEdit
    Left = 131
    Top = 2
    Width = 381
    Height = 22
    Enabled = False
    TabOrder = 2
  end
end
