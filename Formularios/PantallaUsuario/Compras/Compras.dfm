object formMisCompras: TformMisCompras
  Left = 89
  Top = 118
  Width = 1329
  Height = 541
  BorderIcons = []
  Caption = 'formMisCompras'
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
    Left = 528
    Top = 16
    Width = 235
    Height = 46
    Caption = 'Mis Compras'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -40
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 120
    Top = 56
    Width = 1056
    Height = 25
    Caption = 
      '________________________________________________________________' +
      '________________________________'
  end
  object stringgridCompras: TStringGrid
    Left = 24
    Top = 112
    Width = 1257
    Height = 353
    ColCount = 7
    DefaultColWidth = 184
    FixedCols = 0
    RowCount = 2
    ScrollBars = ssVertical
    TabOrder = 0
    OnDblClick = stringgridComprasDblClick
    OnDrawCell = stringgridComprasDrawCell
  end
  object MainMenu1: TMainMenu
    Left = 48
    object Salir1: TMenuItem
      Caption = 'Salir'
      OnClick = Salir1Click
    end
  end
end
