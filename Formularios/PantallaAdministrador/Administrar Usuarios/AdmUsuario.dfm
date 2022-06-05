object formAdmUsuarios: TformAdmUsuarios
  Left = 77
  Top = 170
  Width = 1429
  Height = 540
  BorderIcons = []
  Caption = 'formAdmUsuarios'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -17
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object Label1: TLabel
    Left = 400
    Top = 16
    Width = 158
    Height = 46
    Caption = 'Usuarios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 128
    Top = 64
    Width = 702
    Height = 20
    Caption = 
      '________________________________________________________________' +
      '______________'
  end
  object StringGridUsuarios: TStringGrid
    Left = 32
    Top = 112
    Width = 1340
    Height = 337
    ColCount = 9
    DefaultColWidth = 211
    FixedCols = 0
    RowCount = 2
    TabOrder = 0
    OnDblClick = StringGridUsuariosDblClick
    OnDrawCell = StringGridUsuariosDrawCell
    ColWidths = (
      211
      127
      211
      211
      211
      211
      211
      211
      211)
  end
  object GroupBox1: TGroupBox
    Left = 936
    Top = 16
    Width = 225
    Height = 73
    Caption = 'Listar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object ComboBoxListar: TComboBox
      Left = 16
      Top = 32
      Width = 185
      Height = 28
      Style = csDropDownList
      ItemHeight = 20
      ItemIndex = 0
      TabOrder = 0
      Text = 'Todos'
      OnCloseUp = ComboBoxListarCloseUp
      Items.Strings = (
        'Todos'
        'Mas ventas'
        'Bloqueados')
    end
  end
  object btnAyuda: TBitBtn
    Left = 1264
    Top = 8
    Width = 25
    Height = 25
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnAyudaClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF976667B77B67EBA779EAB391EDBDA3F0
      C9B9F2D2C7F3DBD6F6E1DFF9E9ECBB92939F6766FF00FFFF00FFFF00FFFF00FF
      9C6765BE8777E3A986E2AD8FE2B298E3B5A0E4B9A6E5BCAAE5BEAEE8C2B3CB99
      87AF786FFF00FFFF00FFFF00FFFF00FF9C605BEBBEA3FFF8CBFFEBBDFFE8B7FF
      E4AFFFE1A8FFDCA1FFD89BFFD694FFDE97DCA281FF00FFFF00FFFF00FFFF00FF
      9A5F58E8BDA6FFFFDCFFF8CFFFF5C9F27134DD571AFFD1A1FFEAB3FFE6ADFFE9
      A9D7A186FF00FFFF00FFFF00FFFF00FF9A5E57E8C1ADFFFFEAFFFFDCFFFCD6FF
      5807FF5100FFD4A8FFF1C2FFEDBCFFF1B9D2A08AFF00FFFF00FFFF00FFFF00FF
      9A5E57EAC4B5FFFFF9FFFFEBFFFFE6FFFFE6FFF7D1FFF7D1FFF9D1FFF6CBFFF8
      C9CE9C8CFF00FFFF00FFFF00FFFF00FF9A5E56EAC8BBFFFFFFFFFFF8FFFFF2FF
      5D11FF5001E6C3A5FFFFDEFFFDD8FFFFD7C99A8DFF00FFFF00FFFF00FFFF00FF
      9A5D55EBCDC3FFFFFFFFFFFFFFFFFFFF9960FF5100E94F0CE3C0A3FFFFE8FFFF
      E6C4958DFF00FFFF00FFFF00FFFF00FF9A5D55EBCFC9FFFFFFFFFFFFFFFFFFFF
      FFFFFF9F69FF5100F24F0BF09F76FFFFF1C1928CFF00FFFF00FFFF00FFFF00FF
      9A5D54ECD2CEFFD0ADFC6322D65B23FFFFFDFFFFFFFF5708FF5100FD6C2EFFFF
      FCBC8E8AFF00FFFF00FFFF00FFFF00FF9A5D54ECD4D1FFC7A0FF5D0FFF5100CA
      6536DD7747FF5100FF5202FF9563FFFFFFB98A87FF00FFFF00FFFF00FFFF00FF
      9A5D55ECD4D1FFFFFFFFEBD4FF5604FF5100FF5100FF5502FFC2A1FFFFFFFFFF
      FFB48584FF00FFFF00FFFF00FFFF00FF9A5E56EDD5D2FFFFFFFFFFFFFFD6B6FF
      9C65FFA06AFFDFC2FFFFFFFFFFFFFFFFFFAF7F7FFF00FFFF00FFFF00FFFF00FF
      A16966CAA3A2EAD2D2E6CDCDE6CDCDE6CDCDE6CDCDE6CDCDE6CDCDE8CECEE2C4
      C4AF7F7FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 48
    object btnSalir: TMenuItem
      Caption = 'Salir'
      OnClick = btnSalirClick
    end
  end
end
