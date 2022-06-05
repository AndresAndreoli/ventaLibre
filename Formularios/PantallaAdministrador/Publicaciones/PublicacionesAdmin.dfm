object formPublicacionesAdmin: TformPublicacionesAdmin
  Left = 189
  Top = 115
  Width = 1184
  Height = 586
  BorderIcons = []
  Caption = 'formPublicacionesAdmin'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object Label1: TLabel
    Left = 128
    Top = 16
    Width = 197
    Height = 37
    Caption = 'Publicaciones'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 48
    Width = 432
    Height = 20
    Caption = '________________________________________________'
  end
  object StringGridPublicaciones: TStringGrid
    Left = 16
    Top = 120
    Width = 1121
    Height = 385
    ColCount = 9
    DefaultColWidth = 100
    FixedCols = 0
    ScrollBars = ssVertical
    TabOrder = 0
    OnDblClick = StringGridPublicacionesDblClick
    OnDrawCell = StringGridPublicacionesDrawCell
  end
  object GroupBox1: TGroupBox
    Left = 480
    Top = 8
    Width = 273
    Height = 73
    Caption = 'Listar'
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 32
      Width = 63
      Height = 20
      Caption = 'Usuarios'
    end
    object ComboBoxUsuarios: TComboBox
      Left = 80
      Top = 32
      Width = 185
      Height = 24
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 16
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'Todos'
      OnCloseUp = ComboBoxUsuariosCloseUp
      Items.Strings = (
        'Todos')
    end
  end
  object GroupBox2: TGroupBox
    Left = 768
    Top = 8
    Width = 377
    Height = 105
    Caption = 'Buscar'
    TabOrder = 2
    object Label4: TLabel
      Left = 16
      Top = 32
      Width = 47
      Height = 20
      Caption = 'Desde'
    end
    object Label5: TLabel
      Left = 16
      Top = 72
      Width = 43
      Height = 20
      Caption = 'Hasta'
    end
    object fechaDesde: TDateTimePicker
      Left = 72
      Top = 24
      Width = 186
      Height = 28
      Date = 44587.350378692130000000
      Time = 44587.350378692130000000
      TabOrder = 0
    end
    object fechaHasta: TDateTimePicker
      Left = 72
      Top = 64
      Width = 186
      Height = 28
      Date = 44587.351084814810000000
      Time = 44587.351084814810000000
      TabOrder = 1
    end
    object btnRealizadas: TButton
      Left = 272
      Top = 24
      Width = 89
      Height = 25
      Caption = 'Realizadas'
      TabOrder = 2
      OnClick = btnRealizadasClick
    end
    object btnCaducadas: TButton
      Left = 272
      Top = 64
      Width = 89
      Height = 25
      Caption = 'Caducadas'
      TabOrder = 3
      OnClick = btnCaducadasClick
    end
  end
  object btnConversacion: TButton
    Left = 536
    Top = 88
    Width = 145
    Height = 25
    Caption = 'Conversaciones'
    TabOrder = 3
    OnClick = btnConversacionClick
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object btnSalir: TMenuItem
      Caption = 'Salir'
      OnClick = btnSalirClick
    end
  end
end
