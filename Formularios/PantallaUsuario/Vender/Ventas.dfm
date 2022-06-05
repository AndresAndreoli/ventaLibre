object formVentas: TformVentas
  Left = 129
  Top = 131
  Width = 1297
  Height = 583
  BorderIcons = []
  Caption = 'formVentas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNone
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
  object labelFoto: TLabel
    Left = 848
    Top = 8
    Width = 39
    Height = 25
    Caption = 'Foto'
  end
  object imgArticulo: TImage
    Left = 856
    Top = 40
    Width = 401
    Height = 273
    Proportional = True
    Stretch = True
  end
  object labelDescripcion: TLabel
    Left = 40
    Top = 88
    Width = 102
    Height = 25
    Caption = 'Descripcion'
  end
  object labelCategoria: TLabel
    Left = 40
    Top = 352
    Width = 85
    Height = 25
    Caption = 'Categoria'
  end
  object labelPrecio: TLabel
    Left = 856
    Top = 360
    Width = 55
    Height = 25
    Caption = 'Precio'
  end
  object Label1: TLabel
    Left = 864
    Top = 392
    Width = 15
    Height = 29
    Caption = '$'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object labelGuardarImagen: TLabel
    Left = 976
    Top = 8
    Width = 177
    Height = 25
    Caption = 'labelGuardarImagen'
    Visible = False
  end
  object labelFechaVencimiento: TLabel
    Left = 456
    Top = 8
    Width = 213
    Height = 25
    Caption = 'Fecha cierra Publicacion'
  end
  object editTitulo: TEdit
    Left = 48
    Top = 40
    Width = 369
    Height = 33
    TabOrder = 0
  end
  object btnCargar: TButton
    Left = 1184
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Cargar'
    TabOrder = 3
    OnClick = btnCargarClick
  end
  object editDescripcion: TMemo
    Left = 48
    Top = 120
    Width = 369
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
  object btnVolver: TButton
    Left = 32
    Top = 480
    Width = 105
    Height = 41
    Caption = 'Volver'
    TabOrder = 6
    OnClick = btnVolverClick
  end
  object comboBoxCategoria: TComboBox
    Left = 48
    Top = 384
    Width = 369
    Height = 33
    Style = csDropDownList
    ItemHeight = 25
    TabOrder = 2
  end
  object RadioGroupUsado: TRadioGroup
    Left = 448
    Top = 360
    Width = 377
    Height = 113
    Caption = 'Estado del articulo'
    TabOrder = 7
  end
  object RadioButtonNuevo: TRadioButton
    Left = 488
    Top = 416
    Width = 113
    Height = 17
    Caption = 'Nuevo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  object radiobuttonUsado: TRadioButton
    Left = 672
    Top = 416
    Width = 113
    Height = 17
    Caption = 'Usado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object btnPublicar: TButton
    Left = 1088
    Top = 464
    Width = 169
    Height = 57
    Caption = 'Publicar'
    TabOrder = 5
    OnClick = btnPublicarClick
  end
  object editPrecio: TEdit
    Left = 888
    Top = 392
    Width = 121
    Height = 33
    TabOrder = 4
  end
  object Calendario: TMonthCalendar
    Left = 472
    Top = 40
    Width = 316
    Height = 273
    Date = 44581.489810636570000000
    TabOrder = 10
  end
end
