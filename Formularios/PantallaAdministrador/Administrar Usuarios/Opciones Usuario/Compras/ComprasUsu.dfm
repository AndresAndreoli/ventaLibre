object formComprasAdmin: TformComprasAdmin
  Left = 231
  Top = 146
  Width = 1164
  Height = 564
  BorderIcons = []
  Caption = 'formComprasAdmin'
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
    Left = 504
    Top = 16
    Width = 162
    Height = 46
    Caption = 'Compras'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 232
    Top = 64
    Width = 704
    Height = 25
    Caption = '________________________________________________________________'
  end
  object StringGridCompras: TStringGrid
    Left = 16
    Top = 112
    Width = 1113
    Height = 369
    ColCount = 6
    DefaultColWidth = 184
    FixedCols = 0
    TabOrder = 0
    OnDrawCell = StringGridComprasDrawCell
  end
  object MainMenu1: TMainMenu
    Left = 168
    Top = 16
    object Salir1: TMenuItem
      Caption = 'Salir'
      OnClick = Salir1Click
    end
  end
end
