object formListadoPublicaciones: TformListadoPublicaciones
  Left = 263
  Top = 138
  Width = 1044
  Height = 598
  BorderIcons = []
  Caption = 'formListadoPublicaciones'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 25
  object labelRealizadas: TLabel
    Left = 152
    Top = 16
    Width = 266
    Height = 37
    Caption = 'Ventas Realizadas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelRow: TLabel
    Left = 32
    Top = 496
    Width = 79
    Height = 25
    Caption = 'labelRow'
    Visible = False
  end
  object Label2: TLabel
    Left = 72
    Top = 48
    Width = 440
    Height = 25
    Caption = '________________________________________'
  end
  object labelCaducadas: TLabel
    Left = 144
    Top = 16
    Width = 272
    Height = 37
    Caption = 'Ventas Caducadas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelTotal: TLabel
    Left = 728
    Top = 464
    Width = 131
    Height = 25
    Caption = 'Total Comision'
  end
  object labelCobrada: TLabel
    Left = 680
    Top = 496
    Width = 179
    Height = 25
    Caption = 'Comision Combrada'
  end
  object StringGridVentas: TStringGrid
    Left = 24
    Top = 88
    Width = 977
    Height = 361
    ColCount = 7
    DefaultColWidth = 174
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object StringGridCaducado: TStringGrid
    Left = 24
    Top = 88
    Width = 977
    Height = 361
    DefaultColWidth = 217
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 600
    Top = 0
    Width = 289
    Height = 81
    Caption = 'Categoria'
    TabOrder = 2
    Visible = False
    object ComboBoxCategorias: TComboBox
      Left = 24
      Top = 32
      Width = 241
      Height = 33
      Style = csDropDownList
      ItemHeight = 25
      ItemIndex = 0
      TabOrder = 0
      Text = 'Todas'
      OnCloseUp = ComboBoxCategoriasCloseUp
      Items.Strings = (
        'Todas')
    end
  end
  object editTotal: TEdit
    Left = 880
    Top = 464
    Width = 121
    Height = 28
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object editCobrada: TEdit
    Left = 880
    Top = 496
    Width = 121
    Height = 28
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object GroupBoxCalificacion: TGroupBox
    Left = 600
    Top = 0
    Width = 289
    Height = 81
    Caption = 'Filtro'
    TabOrder = 5
    object ComboBoxCalificacion: TComboBox
      Left = 24
      Top = 32
      Width = 225
      Height = 33
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 25
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'Todos'
      OnCloseUp = ComboBoxCalificacionCloseUp
      Items.Strings = (
        'Todos'
        'Sin Clasificar'
        'Recomendable'
        'Neutral'
        'No Recomendable')
    end
  end
  object CheckBoxEstro: TCheckBox
    Left = 40
    Top = 464
    Width = 97
    Height = 17
    Caption = 'Entro'
    TabOrder = 6
    Visible = False
  end
  object MainMenu1: TMainMenu
    Left = 168
    Top = 464
    object btnSalir: TMenuItem
      Caption = 'Salir'
      OnClick = btnSalirClick
    end
  end
end
