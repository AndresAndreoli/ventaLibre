object formUsuario: TformUsuario
  Left = 201
  Top = 108
  Width = 1217
  Height = 591
  BorderIcons = []
  Caption = 'formUsuario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowFrame
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object labelMail: TLabel
    Left = 104
    Top = 496
    Width = 103
    Height = 25
    Caption = 'Modo Visita'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 24
    Top = 496
    Width = 78
    Height = 25
    Caption = 'Usuario: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 496
    Top = 1
    Width = 187
    Height = 47
    Caption = 'VentaLibre'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'Cambria'
    Font.Style = []
    ParentFont = False
  end
  object labelContador: TLabel
    Left = 32
    Top = 16
    Width = 42
    Height = 13
    Caption = 'contador'
    Visible = False
  end
  object Label9: TLabel
    Left = 184
    Top = 40
    Width = 813
    Height = 13
    Caption = 
      '________________________________________________________________' +
      '____________________________________________________'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object checkBoxTipoUsuario: TCheckBox
    Left = 80
    Top = 16
    Width = 97
    Height = 17
    Caption = 'Tipo Usuario'
    TabOrder = 0
    Visible = False
  end
  object btnRegistrarse: TButton
    Left = 992
    Top = 0
    Width = 153
    Height = 41
    Caption = 'Registrarse'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
    OnClick = btnRegistrarseClick
  end
  object StringGridPublicaciones: TStringGrid
    Left = 24
    Top = 72
    Width = 873
    Height = 409
    ColCount = 4
    DefaultColWidth = 164
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
    OnDblClick = StringGridPublicacionesDblClick
    OnDrawCell = StringGridPublicacionesDrawCell
  end
  object GroupBox1: TGroupBox
    Left = 920
    Top = 64
    Width = 257
    Height = 457
    Caption = 'Buscar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object labelTitulo: TLabel
      Left = 8
      Top = 32
      Width = 38
      Height = 20
      Caption = 'Titulo'
    end
    object Label3: TLabel
      Left = 8
      Top = 160
      Width = 69
      Height = 20
      Caption = 'Categoria'
    end
    object labelProvincia: TLabel
      Left = 8
      Top = 96
      Width = 63
      Height = 20
      Caption = 'Provincia'
    end
    object Label4: TLabel
      Left = 8
      Top = 224
      Width = 51
      Height = 20
      Caption = 'Estado'
    end
    object Label5: TLabel
      Left = 8
      Top = 288
      Width = 44
      Height = 20
      Caption = 'Precio'
    end
    object Label6: TLabel
      Left = 8
      Top = 352
      Width = 48
      Height = 20
      Caption = 'Rango'
    end
    object Label7: TLabel
      Left = 120
      Top = 384
      Width = 9
      Height = 20
      Caption = 'a'
    end
    object Label8: TLabel
      Left = 64
      Top = 352
      Width = 11
      Height = 20
      Caption = '$'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object editTitulo: TEdit
      Left = 16
      Top = 56
      Width = 225
      Height = 28
      TabOrder = 0
    end
    object ComboBoxCategoria: TComboBox
      Left = 16
      Top = 184
      Width = 225
      Height = 28
      Style = csDropDownList
      ItemHeight = 20
      ItemIndex = 0
      TabOrder = 1
      Text = 'Todas'
      Items.Strings = (
        'Todas')
    end
    object ComboBoxProvincias: TComboBox
      Left = 16
      Top = 120
      Width = 225
      Height = 28
      Style = csDropDownList
      ItemHeight = 20
      ItemIndex = 0
      TabOrder = 2
      Text = 'Todas'
      Items.Strings = (
        'Todas')
    end
    object ComboBoxEstado: TComboBox
      Left = 16
      Top = 248
      Width = 225
      Height = 28
      Style = csDropDownList
      ItemHeight = 20
      ItemIndex = 0
      TabOrder = 3
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'Usado'
        'Nuevo')
    end
    object ComboBoxPrecio: TComboBox
      Left = 16
      Top = 312
      Width = 225
      Height = 28
      Style = csDropDownList
      ItemHeight = 20
      ItemIndex = 0
      TabOrder = 4
      Text = 'Ninguno'
      Items.Strings = (
        'Ninguno'
        'Mayor - Menor'
        'Menor - Mayor')
    end
    object editPrecioMenor: TEdit
      Left = 16
      Top = 376
      Width = 89
      Height = 28
      TabOrder = 5
      Text = 'min'
      OnClick = editPrecioMenorClick
    end
    object editPrecioMayor: TEdit
      Left = 144
      Top = 376
      Width = 97
      Height = 28
      TabOrder = 6
      Text = 'max'
      OnClick = editPrecioMayorClick
    end
    object btnBuscar: TButton
      Left = 152
      Top = 416
      Width = 89
      Height = 33
      Caption = 'Buscar'
      TabOrder = 7
      OnClick = btnBuscarClick
    end
    object btnLimpiar: TButton
      Left = 16
      Top = 416
      Width = 89
      Height = 33
      Caption = 'Limpiar'
      TabOrder = 8
      OnClick = btnLimpiarClick
    end
  end
  object BitBtn1: TBitBtn
    Left = 1160
    Top = 8
    Width = 25
    Height = 25
    TabOrder = 4
    OnClick = BitBtn1Click
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
    Left = 216
    Top = 16
    object btnMenuSalir: TMenuItem
      Caption = 'Salir'
      OnClick = btnMenuSalirClick
    end
    object btnMenuPerfil: TMenuItem
      Caption = 'Perfil'
      OnClick = btnMenuPerfilClick
    end
    object btnMainVender: TMenuItem
      Caption = 'Vender'
      OnClick = btnMainVenderClick
    end
    object btnMainPublicaciones: TMenuItem
      Caption = 'Mis Publicaciones'
      OnClick = btnMainPublicacionesClick
    end
    object btnMisCompras: TMenuItem
      Caption = 'Mis compras'
      OnClick = btnMisComprasClick
    end
    object btnMisVentas: TMenuItem
      Caption = 'Mis Ventas'
      OnClick = btnMisVentasClick
    end
  end
end
