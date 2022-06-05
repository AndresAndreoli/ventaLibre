object formHerramientas: TformHerramientas
  Left = 171
  Top = 35
  Width = 1185
  Height = 759
  BorderIcons = []
  Caption = 'formHerramientas'
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
  object labeltitulo: TLabel
    Left = 128
    Top = 8
    Width = 218
    Height = 46
    Caption = 'Herramienta'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 40
    Top = 48
    Width = 462
    Height = 25
    Caption = '__________________________________________'
  end
  object btnUsuarios: TButton
    Left = 536
    Top = 8
    Width = 129
    Height = 65
    Caption = 'Test de dispersion'
    TabOrder = 0
    WordWrap = True
    OnClick = btnUsuariosClick
  end
  object testDispercion: TStringGrid
    Left = 16
    Top = 88
    Width = 1124
    Height = 585
    ColCount = 80
    DefaultColWidth = 13
    DefaultRowHeight = 13
    Enabled = False
    FixedCols = 0
    RowCount = 41
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -5
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnDrawCell = testDispercionDrawCell
  end
  object btnCategoria: TButton
    Left = 688
    Top = 8
    Width = 129
    Height = 65
    Caption = 'Categoria'
    TabOrder = 2
    OnClick = btnCategoriaClick
  end
  object CheckBoxColor: TCheckBox
    Left = 424
    Top = 16
    Width = 97
    Height = 17
    Caption = 'Color'
    TabOrder = 3
    Visible = False
  end
  object btnVendedor: TButton
    Left = 840
    Top = 8
    Width = 129
    Height = 65
    Caption = 'Vendedor'
    TabOrder = 4
    OnClick = btnVendedorClick
  end
  object btnConversaciones: TButton
    Left = 984
    Top = 8
    Width = 153
    Height = 65
    Caption = 'Conversaciones'
    TabOrder = 5
    Visible = False
    OnClick = btnConversacionesClick
  end
  object MainMenu1: TMainMenu
    Left = 40
    object Salir1: TMenuItem
      Caption = 'Salir'
      OnClick = Salir1Click
    end
  end
end
