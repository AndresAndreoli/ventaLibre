object formRegistrarse: TformRegistrarse
  Left = 541
  Top = 106
  Width = 595
  Height = 629
  BorderIcons = []
  Caption = 'formRegistrarse'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 25
  object Label1: TLabel
    Left = 200
    Top = 32
    Width = 162
    Height = 37
    Caption = 'Registrarse'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelEmail: TLabel
    Left = 40
    Top = 104
    Width = 48
    Height = 25
    Caption = 'Email'
  end
  object labelClave: TLabel
    Left = 40
    Top = 144
    Width = 102
    Height = 25
    Caption = 'Contrase'#241'a'
  end
  object labelConfClave: TLabel
    Left = 40
    Top = 184
    Width = 154
    Height = 25
    Caption = 'Conf. Contrase'#241'a'
  end
  object labelNombre: TLabel
    Left = 40
    Top = 224
    Width = 69
    Height = 25
    Caption = 'Nombre'
  end
  object labelApellido: TLabel
    Left = 40
    Top = 264
    Width = 70
    Height = 25
    Caption = 'Apellido'
  end
  object labelDomicilio: TLabel
    Left = 40
    Top = 304
    Width = 78
    Height = 25
    Caption = 'Domicilio'
  end
  object labelProvincia: TLabel
    Left = 40
    Top = 344
    Width = 80
    Height = 25
    Caption = 'Provincia'
  end
  object labelFoto: TLabel
    Left = 40
    Top = 392
    Width = 39
    Height = 25
    Caption = 'Foto'
  end
  object imgPerfil: TImage
    Left = 200
    Top = 392
    Width = 105
    Height = 105
    Proportional = True
    Stretch = True
  end
  object editEmail: TEdit
    Left = 200
    Top = 104
    Width = 329
    Height = 33
    CharCase = ecLowerCase
    TabOrder = 0
  end
  object editClave: TEdit
    Left = 200
    Top = 144
    Width = 329
    Height = 33
    PasswordChar = '*'
    TabOrder = 1
  end
  object editConfClave: TEdit
    Left = 200
    Top = 184
    Width = 329
    Height = 33
    PasswordChar = '*'
    TabOrder = 2
  end
  object editNombre: TEdit
    Left = 200
    Top = 224
    Width = 329
    Height = 33
    CharCase = ecLowerCase
    TabOrder = 3
  end
  object editApellido: TEdit
    Left = 200
    Top = 264
    Width = 329
    Height = 33
    CharCase = ecLowerCase
    TabOrder = 4
  end
  object editDomicilio: TEdit
    Left = 200
    Top = 304
    Width = 329
    Height = 33
    CharCase = ecLowerCase
    TabOrder = 5
  end
  object comboBoxProvincias: TComboBox
    Left = 200
    Top = 344
    Width = 329
    Height = 33
    Style = csDropDownList
    ItemHeight = 25
    TabOrder = 6
  end
  object btnRegistrar: TButton
    Left = 408
    Top = 520
    Width = 121
    Height = 41
    Caption = 'Registrar'
    TabOrder = 7
    OnClick = btnRegistrarClick
  end
  object btnBuscarFoto: TButton
    Left = 320
    Top = 472
    Width = 89
    Height = 25
    Caption = 'Buscar foto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnBuscarFotoClick
  end
  object btnVolver: TButton
    Left = 40
    Top = 528
    Width = 121
    Height = 41
    Caption = 'Volver'
    TabOrder = 9
    OnClick = btnVolverClick
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 320
    Top = 432
  end
end
