object FrmConsultaFuncionarios: TFrmConsultaFuncionarios
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FrmConsultaFuncionarios'
  ClientHeight = 426
  ClientWidth = 1050
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlParametros: TPanel
    Left = 0
    Top = 41
    Width = 1050
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      1050
      49)
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 84
      Height = 24
      Caption = 'Consultar'
    end
    object edtConsultar: TEdit
      Left = 99
      Top = 8
      Width = 940
      Height = 32
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      OnChange = edtConsultarChange
      OnKeyPress = edtConsultarKeyPress
    end
  end
  object grdConsulta: TDBGrid
    Left = 0
    Top = 90
    Width = 1050
    Height = 336
    Align = alClient
    DataSource = dsConsulta
    DrawingStyle = gdsClassic
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grdConsultaDblClick
    OnKeyPress = grdConsultaKeyPress
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1050
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Consulta de Funcion'#225'rios'
    Color = 3682350
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 4244613
    Font.Height = -27
    Font.Name = 'Ubuntu Condensed'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      1050
      41)
    object Image19: TImage
      Left = 1020
      Top = 3
      Width = 24
      Height = 24
      Cursor = crHandPoint
      Anchors = [akTop, akRight]
      AutoSize = True
      Center = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
        00180806000000E0773DF8000000097048597300000B1300000B1301009A9C18
        00000A4F6943435050686F746F73686F70204943432070726F66696C65000078
        DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A21
        09104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E4
        21A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C
        9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD
        230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C
        01808401C07491384B08801400407A8E42A600404601809D98265300A0040060
        CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365
        884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B7
        00C0CE100BB200080C00305188852900047B0060C8232378008499001446F257
        3CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B
        14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0E
        AECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2F
        B31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F8
        7E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3C
        FCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB7
        0BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2
        FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F700
        00F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44
        242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036
        844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051
        688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801
        628A58238E08179985F821C14804128B2420C9881451224B91354831528A5420
        55481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543
        B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F
        3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056
        AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A820
        1C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23
        D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223
        E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421
        F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DD
        A8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A
        681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583
        C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F99
        6F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB54
        8FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A8
        6F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B
        0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352
        F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931
        655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A
        275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477
        BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806
        B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E184
        91B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE
        9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDF
        B7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346
        AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806
        DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D
        5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613
        CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BD
        E44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E
        593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F91
        57ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8
        B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FB
        F87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC
        90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F
        8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3E
        AA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDF
        FCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C
        884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C
        2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A
        9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585
        B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B26765
        5766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A586
        4B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54F
        ABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D
        4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF
        99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40D
        DF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A4
        54F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB
        5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203
        FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D55
        8D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A
        429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794A
        F354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F
        6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6D
        EA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4
        BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727
        EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7
        068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743
        CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5
        FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE4
        7C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB0000058149
        44415478DA95956B6C145514C7FF77667677BAEDB6CB6E5B5E35E9136A1BEA07
        128C1A4A42021A1E4562C3232E15C5A0224850D2C20728ED561EDDF205AD42B0
        3C634B814A08213151A0F8209AD44440519008460D6D68CB16F63133BB33E399
        9DD9DDB61A126F7B735FB3E777CEB9FF7B2FE300684815E6050AA8E531AAE818
        5BFE6BCCA8AA406C2AF0F72CBB1DBD8A823F8CF924A0BD6C124EFFDEBF64667E
        F62C0DCCA6EB3AE8DFAA661FE3C6A35B467FF1B82A7F1B952E11E0E278004780
        AE75F5F5CBF0E40CD325CDF8A566F6A9358C9873BAD94FB69AD15ADFC5140C5F
        B884FA8347F612607312202C72F22BCFB6F98F8D543D034442D055CD326EBAAD
        6B29D72DC3DAA8B1664546719335214344B0F304AA3B7BE612E012F350CEB796
        E5B7BCB3BDE99591387DA9C64779691A1A0BA068346D1CD088C4748AD96C1007
        EEA36ECFBE96733AFC2C17287AAF24AFF9EDF51B7C614E20EF55F363724B0D47
        A051D84266662A2D2690D629C79A2283B33BA033967686E3E01C1CC2DA03C7DB
        CE68D861A8A6706351AE7FCDE21A5FFFD5AB88DD1FA0C4E9883D94E05EBA14F6
        A766E26EF376E488242C8E2554A38615705533A02D588AD0876D70C91298C025
        F683399DC8CBCDC7E6CB7D813371AD89E5F2ACF00DAFD3BF109A2F188C82911D
        5506DC8B5F40E5912ED8DC6EFCD4DA823B0DDBE016C986441AAE2C01FFFE5E8C
        8819D07FF81E7A60175C52941C3083F450BB47E62C80C00A5767F2FE798AEA0B
        5B0257241D95470FA3B46E35E49111D87372F06360377EA9DF8ADC8AE9C86C6D
        43D010423C0E7BB60BF736AE87E7E62DF0369610939722DD1743E0B31801BC14
        81CFC9FBE7489A2FA2990423DF0F1D229EFDB413E59426291844988CFD7CF810
        F4C222841C8E8418ECA2889BADADB0F75E06D9491DBA3CEA1F04023D0A013C04
        5829F2FEB9B24E80E479A654D06607491173BABB91377B36EEDDBD8B07910846
        86861222B0931C6F05DAC0F5F6229F3656471A904F804F9816386D002670AC70
        39016A342E0DB08EBE01192263E5478F422928308DD3828336F236792E92E793
        E85AD0475D1F6604743368F1C0299900391C0A973B04FF7266F349A32F19929E
        4E1EA3A20242531342029F90304FDEE6E479113A7F1EE1DD01DA7831214DF350
        9A805C02EC8D2B815392DAC45C0C85CB08F09A3DC3278F0268649C5556023B77
        E20119D6633138B23291E914E1763931A5A418F73A8EE3CEA6773181CE090C88
        05F01260A71C099C8C12208B00B576C1BFC199E5532C80614C2B2F874C9E0F93
        7166A8C56147FF471FA3AC6621A6ADA88547CC82E870E2467B3BFE6A6840B620
        9851D3EF3D828EC64828D01D2180930EDA4B0EBB7F4BFE449F92F45E92106E6C
        C44069295838041BA521B8FF00BC172F42C8CE46D991C3289EFF7C2ADA2FE6CD
        83E7FA75F0D67E78380D0DF7FBD3805AA7E86F9C36DD1783E901C8EB413234BC
        762DF489F908771CC294BE3E4CA143A7517403B45EB27F3FA65657E3427333E2
        248222FA5EB7E4E186824DBFFD1A381136F68000ABDC99FE6D339FF64996D412
        8F07DD35832E170629BF5E92E8E494012420C3949228A551BA7205A51E0F6587
        A5016A14EBFABE0B748508E0A6CBEECD89D9FEAD73E6BF1CD5D9D8978A3C55A9
        DAACD0C71492AF2CCB7064648C9DA72B3B2716C69A2F3F6FEB7C14DF61009ED8
        5CE06ED952B3A22EA48E7D1093B87F197FDCBA01501E61E5C9AE5D27426AB3F1
        E0D81638F955E75EADEB88E515938264430CFFABE87A9AC83B32A0DDB8828AEE
        F32FDED67036F164D2BABDBDD8DBF3D692DA45F04EB69E46F32D4D3EE82977C7
        B7D6A14C8ED53F6F6253CF99631F0C4AAFD33096041895AF76605595CBF95C94
        AE9A28BD6E11AAC62367DC634615122DA3D39C9C63E935BA41355D93BE7910FD
        FA9A8A936452B13296028000F88AF68DBAC26352FFB8A256F190AFA9E9897F00
        4478C4DFA95E948D0000000049454E44AE426082}
      OnClick = Image19Click
    end
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 128
    object cdsConsultaCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Size = 6
    end
    object cdsConsultaNOME: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 50
      FieldName = 'NOME'
      Size = 150
    end
    object cdsConsultaCARGO_ID: TIntegerField
      FieldName = 'CARGO_ID'
      Visible = False
    end
    object cdsConsultaCARGO_DESCRICAO: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 40
      FieldName = 'CARGO_DESCRICAO'
      Size = 150
    end
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 104
    Top = 128
  end
end
