object formMisVentas: TformMisVentas
  Left = 188
  Top = 99
  Width = 1165
  Height = 598
  BorderIcons = []
  Caption = 'formMisVentas'
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
  object Label1: TLabel
    Left = 160
    Top = 8
    Width = 197
    Height = 46
    Caption = 'Mis Ventas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 528
    Height = 25
    Caption = '________________________________________________'
  end
  object StringGridMisVentas: TStringGrid
    Left = 16
    Top = 136
    Width = 1113
    Height = 385
    ColCount = 6
    DefaultColWidth = 184
    Enabled = False
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnDrawCell = StringGridMisVentasDrawCell
  end
  object GroupBox1: TGroupBox
    Left = 584
    Top = 0
    Width = 529
    Height = 121
    Caption = 'Filtrar'
    TabOrder = 1
    object Label3: TLabel
      Left = 24
      Top = 32
      Width = 100
      Height = 25
      Caption = 'Calificacion'
    end
    object Label4: TLabel
      Left = 256
      Top = 32
      Width = 57
      Height = 25
      Caption = 'Desde'
    end
    object Label5: TLabel
      Left = 256
      Top = 80
      Width = 51
      Height = 25
      Caption = 'Hasta'
    end
    object ComboBoxCalificacion: TComboBox
      Left = 32
      Top = 64
      Width = 193
      Height = 33
      Style = csDropDownList
      ItemHeight = 25
      ItemIndex = 0
      TabOrder = 0
      Text = 'Todos'
      OnCloseUp = ComboBoxCalificacionCloseUp
      Items.Strings = (
        'Todos')
    end
    object DateTimePickerDesde: TDateTimePicker
      Left = 320
      Top = 32
      Width = 186
      Height = 33
      Date = 44594.285526932870000000
      Time = 44594.285526932870000000
      TabOrder = 1
      OnCloseUp = DateTimePickerDesdeCloseUp
    end
    object DateTimePickerHasta: TDateTimePicker
      Left = 320
      Top = 80
      Width = 186
      Height = 33
      Date = 44594.285619884260000000
      Time = 44594.285619884260000000
      TabOrder = 2
      OnCloseUp = DateTimePickerHastaCloseUp
    end
  end
  object MainMenu1: TMainMenu
    Left = 24
    object Salir1: TMenuItem
      Caption = 'Salir'
      OnClick = Salir1Click
    end
  end
end
