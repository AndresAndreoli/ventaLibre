object formPerfilUsuario: TformPerfilUsuario
  Left = 557
  Top = 129
  Width = 435
  Height = 580
  BorderIcons = []
  Caption = 'PerfilUsuario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object imgFotoPerfil: TImage
    Left = 40
    Top = 24
    Width = 105
    Height = 105
    Proportional = True
    Stretch = True
  end
  object labelNombre: TLabel
    Left = 168
    Top = 24
    Width = 49
    Height = 16
    Caption = 'Nombre'
  end
  object labelApellido: TLabel
    Left = 168
    Top = 80
    Width = 50
    Height = 16
    Caption = 'Apellido'
  end
  object labelMail: TLabel
    Left = 40
    Top = 168
    Width = 25
    Height = 16
    Caption = 'Mail'
  end
  object labelClave: TLabel
    Left = 40
    Top = 224
    Width = 35
    Height = 16
    Caption = 'Clave'
  end
  object labelConfClave: TLabel
    Left = 40
    Top = 280
    Width = 93
    Height = 16
    Caption = 'Confirmar clave'
  end
  object labelDomicilio: TLabel
    Left = 40
    Top = 336
    Width = 56
    Height = 16
    Caption = 'Domicilio'
  end
  object labelProvincia: TLabel
    Left = 40
    Top = 392
    Width = 56
    Height = 16
    Caption = 'Provincia'
  end
  object labelGuardarImagen: TLabel
    Left = 144
    Top = 168
    Width = 124
    Height = 16
    Caption = 'labelGuardarImagen'
    Visible = False
  end
  object btnVolver: TButton
    Left = 16
    Top = 472
    Width = 105
    Height = 33
    Caption = 'Volver'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnVolverClick
  end
  object editNombre: TEdit
    Left = 168
    Top = 48
    Width = 209
    Height = 24
    CharCase = ecLowerCase
    TabOrder = 2
  end
  object editApellido: TEdit
    Left = 168
    Top = 104
    Width = 209
    Height = 24
    CharCase = ecLowerCase
    TabOrder = 3
  end
  object editEmail: TEdit
    Left = 40
    Top = 192
    Width = 337
    Height = 24
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object btnCargar: TButton
    Left = 56
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Cargar'
    TabOrder = 1
    OnClick = btnCargarClick
  end
  object editClave: TEdit
    Left = 40
    Top = 248
    Width = 337
    Height = 24
    PasswordChar = '*'
    TabOrder = 5
  end
  object editConfClave: TEdit
    Left = 40
    Top = 304
    Width = 337
    Height = 24
    PasswordChar = '*'
    TabOrder = 6
  end
  object editDomicilio: TEdit
    Left = 40
    Top = 360
    Width = 337
    Height = 24
    CharCase = ecLowerCase
    TabOrder = 7
  end
  object comboBoxProvincias: TComboBox
    Left = 40
    Top = 416
    Width = 337
    Height = 24
    Style = csDropDownList
    ItemHeight = 16
    TabOrder = 8
  end
  object btnGuardarCambios: TButton
    Left = 240
    Top = 472
    Width = 161
    Height = 33
    Caption = 'Guardar Cambios'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnClick = btnGuardarCambiosClick
  end
  object btnMostrar: TButton
    Left = 304
    Top = 280
    Width = 75
    Height = 17
    Caption = 'Mostrar'
    TabOrder = 10
    OnClick = btnMostrarClick
  end
  object checkBoxModificar: TCheckBox
    Left = 136
    Top = 136
    Width = 97
    Height = 25
    Caption = 'Modificar'
    TabOrder = 11
    Visible = False
  end
  object checkBoxMostrarClave: TCheckBox
    Left = 136
    Top = 280
    Width = 161
    Height = 17
    Caption = 'checkBoxMostrarClave'
    TabOrder = 12
    Visible = False
  end
  object MainMenu1: TMainMenu
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    Left = 328
    Top = 16
    object EliminarCuenta1: TMenuItem
      Caption = 'Eliminar cuenta'
      OnClick = EliminarCuenta1Click
    end
  end
end
