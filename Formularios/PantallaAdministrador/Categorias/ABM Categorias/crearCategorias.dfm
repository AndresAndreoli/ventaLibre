object formCrearCategoria: TformCrearCategoria
  Left = 581
  Top = 240
  Width = 364
  Height = 288
  BorderIcons = []
  Caption = 'formCrearCategoria'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object Label1: TLabel
    Left = 112
    Top = 16
    Width = 119
    Height = 25
    Caption = 'Alta categoria'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelNombreRubro: TLabel
    Left = 48
    Top = 56
    Width = 119
    Height = 20
    Caption = 'Nombre de rubro'
  end
  object labelComision: TLabel
    Left = 48
    Top = 120
    Width = 65
    Height = 20
    Caption = 'Comisi'#243'n'
  end
  object Label2: TLabel
    Left = 152
    Top = 144
    Width = 15
    Height = 24
    Caption = '%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object editNombreRubro: TEdit
    Left = 48
    Top = 80
    Width = 249
    Height = 28
    TabOrder = 0
  end
  object editComision: TMaskEdit
    Left = 48
    Top = 144
    Width = 94
    Height = 28
    EditMask = '99;1;_'
    MaxLength = 2
    TabOrder = 1
    Text = '  '
  end
  object btnCrear: TButton
    Left = 216
    Top = 192
    Width = 105
    Height = 33
    Caption = 'Crear'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnCrearClick
  end
  object btnVolver: TButton
    Left = 24
    Top = 192
    Width = 105
    Height = 33
    Caption = 'Volver'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnVolverClick
  end
end
