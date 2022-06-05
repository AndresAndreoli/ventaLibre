object formPubComprar: TformPubComprar
  Left = 335
  Top = 51
  Width = 820
  Height = 660
  BorderIcons = []
  Caption = 'formPubComprar'
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
  object imgArticulo: TImage
    Left = 24
    Top = 88
    Width = 321
    Height = 241
    Proportional = True
    Stretch = True
  end
  object labelTitulo: TLabel
    Left = 32
    Top = 8
    Width = 146
    Height = 37
    Caption = 'labelTitulo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -33
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 376
    Top = 128
    Width = 63
    Height = 24
    Caption = 'Estado:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelEstado: TLabel
    Left = 384
    Top = 160
    Width = 110
    Height = 24
    Caption = 'labelEstado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 24
    Top = 48
    Width = 759
    Height = 25
    Caption = 
      '________________________________________________________________' +
      '_____'
  end
  object Label4: TLabel
    Left = 16
    Top = 344
    Width = 102
    Height = 25
    Caption = 'Descripcion'
  end
  object Label5: TLabel
    Left = 376
    Top = 272
    Width = 162
    Height = 25
    Caption = 'Dejanos tus dudas'
  end
  object Label6: TLabel
    Left = 376
    Top = 248
    Width = 396
    Height = 25
    Caption = '____________________________________'
  end
  object Label7: TLabel
    Left = 376
    Top = 192
    Width = 165
    Height = 24
    Caption = 'Fecha Vencimiento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelVencimiento: TLabel
    Left = 384
    Top = 224
    Width = 146
    Height = 24
    Caption = 'labelVencimiento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelVendedor: TLabel
    Left = 384
    Top = 104
    Width = 85
    Height = 24
    Caption = 'Vendedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuHighlight
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object labelComprador: TLabel
    Left = 672
    Top = 32
    Width = 51
    Height = 13
    Caption = 'Comprador'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object labeIDArticulo: TLabel
    Left = 688
    Top = 0
    Width = 43
    Height = 13
    Caption = 'idArticulo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object labelIDVendedor: TLabel
    Left = 672
    Top = 16
    Width = 57
    Height = 13
    Caption = 'IDVendedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object labelClaveArticulo: TLabel
    Left = 576
    Top = 8
    Width = 84
    Height = 13
    Caption = 'labelClaveArticulo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label9: TLabel
    Left = 376
    Top = 80
    Width = 90
    Height = 24
    Caption = 'Vendedor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object editDescripcion: TMemo
    Left = 24
    Top = 376
    Width = 321
    Height = 209
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'editDescripcion')
    ParentFont = False
    TabOrder = 0
  end
  object listPreguntas: TListBox
    Left = 376
    Top = 312
    Width = 393
    Height = 201
    Style = lbOwnerDrawVariable
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnDrawItem = listPreguntasDrawItem
    OnMeasureItem = listPreguntasMeasureItem
  end
  object editPreguntar: TEdit
    Left = 376
    Top = 536
    Width = 393
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMedGray
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 60
    ParentFont = False
    TabOrder = 2
    OnClick = editPreguntarClick
  end
  object btnPreguntar: TButton
    Left = 672
    Top = 568
    Width = 91
    Height = 25
    Caption = 'Preguntar'
    TabOrder = 3
    OnClick = btnPreguntarClick
  end
  object panelPrecio: TPanel
    Left = 648
    Top = 136
    Width = 129
    Height = 57
    Caption = '$ 150'
    Color = 8454016
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object btnComprar: TButton
    Left = 648
    Top = 200
    Width = 129
    Height = 57
    Caption = 'Comprar'
    TabOrder = 5
    OnClick = btnComprarClick
  end
  object MainMenu1: TMainMenu
    Left = 744
    Top = 8
    object Volver1: TMenuItem
      Caption = 'Volver'
      OnClick = Volver1Click
    end
  end
end
