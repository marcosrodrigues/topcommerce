object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Servidor Top Commerce'
  ClientHeight = 287
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lblEstado: TLabel
    Left = 0
    Top = 0
    Width = 340
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'Executando...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 121
  end
  object bbtIniciarParar: TBitBtn
    Left = 3
    Top = 36
    Width = 105
    Height = 25
    Caption = 'Parar'
    DoubleBuffered = True
    Kind = bkCancel
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = bbtIniciarPararClick
  end
  object gbBancoDados: TGroupBox
    Left = 8
    Top = 67
    Width = 323
    Height = 207
    Caption = ' Banco de Dados '
    TabOrder = 1
    object Label1: TLabel
      Left = 12
      Top = 32
      Width = 44
      Height = 14
      Caption = 'Servidor'
    end
    object Label2: TLabel
      Left = 12
      Top = 62
      Width = 88
      Height = 14
      Caption = 'Banco de Dados'
    end
    object Label3: TLabel
      Left = 12
      Top = 92
      Width = 39
      Height = 14
      Caption = 'Usu'#225'rio'
    end
    object Label4: TLabel
      Left = 12
      Top = 122
      Width = 34
      Height = 14
      Caption = 'Senha'
    end
    object lblStatusBanco: TLabel
      Left = 125
      Top = 153
      Width = 97
      Height = 19
      Caption = 'Desconectado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtServidor: TEdit
      Left = 110
      Top = 29
      Width = 203
      Height = 22
      TabOrder = 0
    end
    object edtBancoDados: TEdit
      Left = 110
      Top = 59
      Width = 203
      Height = 22
      TabOrder = 1
    end
    object edtUsuario: TEdit
      Left = 110
      Top = 89
      Width = 203
      Height = 22
      TabOrder = 2
    end
    object edtSenha: TEdit
      Left = 110
      Top = 119
      Width = 203
      Height = 22
      PasswordChar = '*'
      TabOrder = 3
    end
    object bbtConectar: TBitBtn
      Left = 12
      Top = 153
      Width = 101
      Height = 25
      Caption = 'Conectar'
      DoubleBuffered = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FCFAF8C39173
        A6603CFDFBFAFFFFFFFFFFFFFFFFFFFFFFFFFAFAFAEBEBEBEBEBEBFCFCFCFFFF
        FFFFFFFFFFFFFFFFFFFFCDA17DBF875CB97E56A9653ED3B3A3D8C2B8BAA9A4A2
        9996A19F9FABABABA7A7A7959595989898BFBFBFF5F5F5FFFFFFC58A5DC69268
        CDA280C59670B67B53AB6A46A35E3D9C5235A76B59F1EFEEF4F4F4EFEFEFE2E2
        E2BABABA959595E6E6E6FEFDFBC78E63D1A683CC9F7BCB9E7BC79974C3926CBE
        8D65A86945BA978BD6D6D6C0C0C0C9C9C9E6E6E6C4C4C4959595FFFFFFE9D0BE
        D0A17CD7AE8FC9976FC38F66BD885CC08C64BC886185543FD3D1D0BFBFBFB0B0
        B0B3B3B3DEDEDE999999FFFFFFF3E3D8D7A682DCB699D0A17DCB9A73CFA482C7
        9974896C58878787828282C0C0C0B3B3B3B7B7B7E0E0E09F9F9FFFFFFFF8EDE5
        DDAE8CE2BEA4D8AB89D9B394CF9F7AA47A5B939393A9A9A9696969C3C3C3B8B8
        B8BBBBBBE1E1E1A3A3A3FFFFFFFCF7F3E3B493E8C6ADE3C0A6DBB08FB58F74D9
        CBC19A9A9A7A7A7ADCDCDCC9C9C9BDBDBDBFBFBFE2E2E2A6A6A6FFFFFFFFFEFE
        EAC5AAE8C0A3E5BFA3B69E8CAEAEAEA8A8A8E1E1E1E5E5E5E1E1E1CDCDCDC2C2
        C2C2C2C2E3E3E3A8A8A8FFFFFFFFFFFFFEFDFCF1D2BDCDAF9BB7B7B7BCBCBCAB
        ABABD6D6D6D5D5D5D1D1D1C3C3C3BCBCBCC0C0C0E5E5E5ABABABFFFFFFFFFFFF
        FFFFFFFFFFFFC3BDBAC1C1C1B6B6B6EFEFEFF6F6F6FBFBFBFAFAFAF0F0F0DEDE
        DEC3C3C3E6E6E6ACACACFFFFFFFFFFFFFFFFFFFFFFFFBFBFBFF8F8F8FEFEFEFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFBFBEAEAEAAEAEAEFFFFFFFFFFFF
        FFFFFFFFFFFFCBCBCBE1E1E1FEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFBFBFBCFCFCFC9C9C9FFFFFFFFFFFFFFFFFFFFFFFFF4F4F4C7C7C7D0D0D0E8
        E8E8F3F3F3FDFDFDFCFCFCEDEDEDE0E0E0C2C2C2C0C0C0F6F6F6FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFDFDFDE8E8E8D0D0D0C3C3C3B8B8B8B8B8B8C3C3C3CDCD
        CDEAEAEAFEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentDoubleBuffered = False
      TabOrder = 4
      OnClick = bbtConectarClick
    end
    object chbConectarIniciar: TCheckBox
      Left = 12
      Top = 184
      Width = 271
      Height = 17
      Caption = 'Conectar banco de dados ao iniciar o servidor.'
      TabOrder = 5
    end
  end
end
