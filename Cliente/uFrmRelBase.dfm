object FrmRelBase: TFrmRelBase
  Left = 0
  Top = 0
  Caption = 'FrmRelBase'
  ClientHeight = 624
  ClientWidth = 818
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport: TRLReport
    Left = 8
    Top = 8
    Width = 794
    Height = 1123
    DataSource = dsRelatorio
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    BeforePrint = RLReportBeforePrint
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 69
      BandType = btHeader
      object RLLabel1: TRLLabel
        Left = 101
        Top = 3
        Width = 90
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -20
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 520
        Top = 3
        Width = 60
        Height = 16
        Info = itFullDate
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 571
        Top = 21
        Width = 87
        Height = 16
        Info = itPageNumber
      end
      object RLLabel2: TRLLabel
        Left = 520
        Top = 21
        Width = 48
        Height = 16
        Caption = 'P'#225'gina:'
      end
      object RLLabel6: TRLLabel
        Left = 101
        Top = 51
        Width = 320
        Height = 14
        Caption = 'TEC Motos. Rua Prefeito Vitoriano Antunes, 2131. (85) 3334-1123'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLImage1: TRLImage
        Left = 8
        Top = 3
        Width = 86
        Height = 62
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
          003008060000005702F98700000006624B474400FF00FF00FFA0BDA793000007
          294944415478DAED98794C545714877FB3312B23BB2C8EC32836B8804BD3DAAA
          B4A64B14AD758931C634B6B6F60F0C225A4A53B521A9C1BA744C0DA2186D6C53
          5B026E484DB4B5D1DAAA5114B4A045A0C5A58AECEBC0EC333D6FE223CF6118DE
          2888269EE4E6BEE5BEFBCE77EE39F79E7B0578C64530D80A3C07186C059E030C
          B6020301A0A37288CA782AC2EE86829E4DD967DC77DC6742A1B0BB66442C1643
          2412B90A73EDE7E707A954DA5D3C89D3E9648AD562B1FC7EFDFAF579F4A8CB2B
          00FDEC47FA6009F363AE12DC7BA6B08AB0D78C421289A4BB668B376194D66834
          AE3E18455985B9352B76BB1DCDCDCDEB4E9F3EBDD12B0029799CAA995AAD16B3
          67CF76FDC4E170B096E8B6AE7BE15A9B7BED69E4D83E8283835DF05C6B73DF33
          C56834A2A4A40456AB1566B3F9EBA3478F7ECA0B20232303EBD7AF87CD667359
          B5BF85ABACA76B6EADD7EB515A5AEA1BC0E6CD9BB166CD1A90EFB97C752001D8
          7B9B83E244D813222B2B0B972E5D7A340066E8FAF2655F1567DD8AB976908E05
          D59DA8EA002C5607D6BEA88490DE7301590072277D6161619A4F002693694046
          80158BDD89ACBFDA512B5421AAF32E525ED5707571D53B76EC405151D1A301F4
          F70870A5D5E24476691B3A8D26E88C771013EA8FE913627BB8173B02644C7D41
          41C1D30170A3D5867D1526C8AD068C17D461DE94F81E6D581076047801901C27
          880175A113B7BAF05BBD0001420BA6499B303D6E440FA51F18B31BE04110EB0F
          1F3EEC1B009F11709AEB5073310376693422C62D854419E9B11DE3EFFBCA9A50
          DE2543B0D0843943AD98A08BE8D5F2AC7066217E0054666ED9B2C5234097C58E
          BCE29B3853711F06A71859D36AA128FF080A513BEA2DD168EBB0E18505A72056
          8DE85686B16487C581ACE27AD4DBE5088011EFE98488890AEBDD281C08D6851E
          0BA0A5CB8C7D672B70A4EC3EEC022194620116F9FF848543F653FEE1872E5B10
          A2FC6BD04010ED9D8076D67188FC635CCADF6EB360E7D566525B8C40472792E2
          87203C38A04F57E3C6001BC4BC015817BADDD0823D7FDCC0AF950DB009C4181E
          A8445CB0114B1C5F204C7015370D61B8670E4783661D668AF7225A7412CD9648
          B45B55087FE3182EB60421FF5F13281F4190B303A9AF44C15F21878382572851
          BA54F0966E70016851D51F3C78D03780157B8EE3DC7D1342E46268A27598A3BA
          80892DEB2017196096E850583D1285CA348445446274901F960A764067DA0EA3
          340E3596E1D887B5E8B007221406A4BD1E0DDCFB1ED6DA13A835A8C118382466
          1E86E8E6422092F53A12D9D9D92E17F21960F5EAD558F5ED09DC25030E8D0CC7
          C7B2EF30A42107624504648A1018866560F8D844A4E69E43B9598540891DA104
          BA26B61AC33AB2612305AB5A427059F0013E9C6483F0BF6C381D3634198310A6
          A8A315D78E7AB31656BB08CA201DFC639641A0D0F55068E7CE9DDD41EC13406A
          6A2AD27F3889603F23129D5B213796401AA0439B643246BDB91D32B9CAF50193
          0EA4E79F47895189A196460C8D1A06A5B0192B6499089375507C0440EDD78E36
          5B289C427FB4A81660584C029AFE390A59E759048B6E501B354C4E35ECFE2F23
          243ED52300C5A33E3F3FDF3780EA6BBFA0F5C2325A0B28BF9785C216FD39C6BC
          B4C0E3506F2EBC800A4118E4122124ED75981C64C10C753EDA3B8C94A809200E
          7F17DA71EFF4F0799BD9804682B135FD89E6AE40C4CFFCEAA13860002E5FBEEC
          1BC0A64D9BB06AD52A14E52D82D45A4D3E3D16F1B3B2A050AAE14D0E1755A2BC
          A6116342E4589030C9F58C9BC0F525CCDE83DDC1B1B26BD72EDF01366EDC8894
          941414FF9C0ABFA089889BFAFE43567117BE0AF6259EFA61008A8B8B9920DE76
          E0C0814F780164666662E5CA954CE0F4BA5FE58ABBD5FA5372727270E5CA15DF
          00366CD880E4E464D75E942BEEEEC0DC33DB42F767EE96F4F49DB77BF69AE97B
          F7EEDDBE03242626222D2DCDD501BB1F76CF511861566999ACF739DC1D848FAB
          71F7D94C32999B9B8BC6C646667BBB2D2F2F8F1F009F9FC8E572C4C6C6F679AC
          C2DEB323C59E66704F34D89A3DD5F024BC00F6EFDF9FA356AB63FB34135CE73C
          F45F9147E777B7341B23EE67499E8E6DD86B77A9AFAF2F983B77EE56AF00B76E
          DD3A49D55B7C00BC496B6B2BCE9F3F8FB2B232A4A7A7F7CB2C457D6468B5DA2F
          9F080093C3272525B92601268F494848783200959595FD02C02C3CCCF23F75EA
          548C1C39124AA5B25F00468D1AE51D60EFDEBDC7A89AFDD87F1B18F96CF9F2E5
          5BBC02D0E225A56857F8DAB34AA54AA200CCE4D396D285D70C06C3355FFF4153
          693BAD030F2D4CFD76BC7EE6CC992934C4E7783435523C28A9AD9347DB3EA5DF
          0028F847D394FA378FA6B51A8D268247BB270B70E7CE9D19B4529FE0D1943CC8
          A1D4E974A6A70AE0C8912359E416C97CDA12E8C2F9F3E71F7A2A00AAAAAA5690
          42F369E1D250BEAEA2795F4AF73D4EC2E8999382DC426E665228144D34ADD6D0
          48E829153935A800B9949C50276F3FC2A74C76B861F1E2C5DF0C2AC060CB7380
          C196E700832DCF3CC0FF18CCAC5ED62024090000000049454E44AE426082}
      end
    end
  end
  object cdsRelatorio: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 96
    Top = 176
  end
  object dsRelatorio: TDataSource
    DataSet = cdsRelatorio
    Left = 472
    Top = 296
  end
  object RLPDFFilter: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport (Open Source) v3.71B \251 Copyright '#169' 1999-2009 For' +
      'tes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 536
    Top = 296
  end
end
