object formPubSeleccionada: TformPubSeleccionada
  Left = 121
  Top = 98
  Width = 1297
  Height = 600
  BorderIcons = []
  Caption = 'formPubSeleccionada'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 25
  object labelTitulo: TLabel
    Left = 40
    Top = 8
    Width = 48
    Height = 25
    Caption = 'Titulo'
  end
  object labelDescripcion: TLabel
    Left = 40
    Top = 80
    Width = 102
    Height = 25
    Caption = 'Descripcion'
  end
  object labelCategoria: TLabel
    Left = 40
    Top = 392
    Width = 91
    Height = 25
    Caption = 'Categoria:'
  end
  object labelFechaCierre: TLabel
    Left = 448
    Top = 80
    Width = 213
    Height = 25
    Caption = 'Fecha cierre Publicacion'
  end
  object labelFoto: TLabel
    Left = 848
    Top = 16
    Width = 39
    Height = 25
    Caption = 'Foto'
  end
  object imgPublicacion: TImage
    Left = 856
    Top = 48
    Width = 401
    Height = 281
    Proportional = True
    Stretch = True
  end
  object labelPrecio: TLabel
    Left = 848
    Top = 368
    Width = 55
    Height = 25
    Caption = 'Precio'
  end
  object Label1: TLabel
    Left = 848
    Top = 400
    Width = 15
    Height = 29
    Caption = '$'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelCreacion: TLabel
    Left = 448
    Top = 8
    Width = 134
    Height = 25
    Caption = 'Fecha creacion'
  end
  object labelGuardarImg: TLabel
    Left = 928
    Top = 368
    Width = 97
    Height = 16
    Caption = 'Guardar imagen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object labelPosNodo: TLabel
    Left = 192
    Top = 464
    Width = 60
    Height = 16
    Caption = 'pos Nodo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object LabelCat: TLabel
    Left = 136
    Top = 392
    Width = 79
    Height = 25
    Caption = 'LabelCat'
  end
  object labelIDCategoria: TLabel
    Left = 176
    Top = 480
    Width = 145
    Height = 25
    Caption = 'labelIDCategoria'
    Visible = False
  end
  object editTitulo: TEdit
    Left = 48
    Top = 32
    Width = 361
    Height = 33
    TabOrder = 0
  end
  object editDescripcion: TMemo
    Left = 48
    Top = 120
    Width = 361
    Height = 217
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'editDescripcion')
    MaxLength = 255
    ParentFont = False
    TabOrder = 1
  end
  object ComboBoxCategoria: TComboBox
    Left = 48
    Top = 424
    Width = 361
    Height = 33
    Style = csDropDownList
    ItemHeight = 25
    TabOrder = 2
  end
  object btnVolver: TButton
    Left = 24
    Top = 480
    Width = 105
    Height = 41
    Caption = 'Volver'
    TabOrder = 3
    OnClick = btnVolverClick
  end
  object Calendario: TMonthCalendar
    Left = 464
    Top = 112
    Width = 316
    Height = 273
    Date = 44581.426094548610000000
    TabOrder = 4
  end
  object GroupBox1: TGroupBox
    Left = 440
    Top = 424
    Width = 361
    Height = 105
    Caption = 'Estado del Articulo'
    TabOrder = 5
    object RadioButtonNuevo: TRadioButton
      Left = 40
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Nuevo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object RadioButtonUsado: TRadioButton
      Left = 216
      Top = 48
      Width = 113
      Height = 17
      Caption = 'Usado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object btnCargar: TButton
    Left = 1176
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Cargar'
    TabOrder = 6
    OnClick = btnCargarClick
  end
  object btnModificar: TButton
    Left = 1072
    Top = 464
    Width = 185
    Height = 65
    Caption = 'Modificar'
    TabOrder = 7
    OnClick = btnModificarClick
  end
  object btnEliminar: TButton
    Left = 864
    Top = 464
    Width = 185
    Height = 65
    Caption = 'Eliminar'
    TabOrder = 8
    OnClick = btnEliminarClick
  end
  object editPrecio: TEdit
    Left = 872
    Top = 400
    Width = 121
    Height = 33
    TabOrder = 9
  end
  object editFechaCreacion: TEdit
    Left = 456
    Top = 32
    Width = 321
    Height = 33
    Enabled = False
    ReadOnly = True
    TabOrder = 10
  end
  object CheckBoxMostrarImg: TCheckBox
    Left = 928
    Top = 344
    Width = 177
    Height = 17
    Caption = 'Mostrar Imagen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    Visible = False
  end
end
