object formAdministrador: TformAdministrador
  Left = 571
  Top = 169
  Width = 425
  Height = 435
  BorderIcons = []
  Caption = 'formAdministrador'
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
  object btnCategorias: TButton
    Left = 88
    Top = 104
    Width = 241
    Height = 73
    Caption = 'Categorias'
    TabOrder = 0
    OnClick = btnCategoriasClick
  end
  object btnPublicaciones: TButton
    Left = 88
    Top = 192
    Width = 241
    Height = 73
    Caption = 'Publicaciones'
    TabOrder = 1
    OnClick = btnPublicacionesClick
  end
  object btnUsuarios: TButton
    Left = 88
    Top = 16
    Width = 241
    Height = 73
    Caption = 'Usuarios'
    TabOrder = 2
    OnClick = btnUsuariosClick
  end
  object btnHerramientas: TButton
    Left = 88
    Top = 280
    Width = 241
    Height = 73
    Caption = 'Herramientas'
    TabOrder = 3
    OnClick = btnHerramientasClick
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object Salir1: TMenuItem
      Caption = 'Salir'
      OnClick = Salir1Click
    end
  end
end
