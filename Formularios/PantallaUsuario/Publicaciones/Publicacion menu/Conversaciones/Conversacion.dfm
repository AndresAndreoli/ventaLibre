object formConversaciones: TformConversaciones
  Left = 546
  Top = 192
  Width = 456
  Height = 501
  BorderIcons = []
  Caption = 'formConversaciones'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 25
  object Label1: TLabel
    Left = 24
    Top = 224
    Width = 79
    Height = 25
    Caption = 'Pregunta'
  end
  object Label2: TLabel
    Left = 24
    Top = 328
    Width = 93
    Height = 25
    Caption = 'Respuesta'
  end
  object labelIDMensaje: TLabel
    Left = 152
    Top = 392
    Width = 73
    Height = 13
    Caption = 'labelIDMensaje'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object labelIDCliente: TLabel
    Left = 152
    Top = 424
    Width = 65
    Height = 13
    Caption = 'labelIDCliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object listBoxConversaciones: TListBox
    Left = 24
    Top = 16
    Width = 393
    Height = 185
    Style = lbOwnerDrawVariable
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 30
    ParentFont = False
    TabOrder = 0
    OnDblClick = listBoxConversacionesDblClick
    OnDrawItem = listBoxConversacionesDrawItem
    OnMeasureItem = listBoxConversacionesMeasureItem
  end
  object Edit1: TEdit
    Left = 80
    Top = 344
    Width = 1
    Height = 33
    TabOrder = 1
    Text = 'Edit1'
  end
  object editRespuesta: TEdit
    Left = 32
    Top = 360
    Width = 385
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 60
    ParentFont = False
    TabOrder = 2
  end
  object btnResponder: TButton
    Left = 304
    Top = 400
    Width = 105
    Height = 41
    Caption = 'Responder'
    TabOrder = 3
    OnClick = btnResponderClick
  end
  object btnVolver: TButton
    Left = 32
    Top = 400
    Width = 105
    Height = 41
    Caption = 'Volver'
    TabOrder = 4
    OnClick = btnVolverClick
  end
  object editMensaje: TMemo
    Left = 32
    Top = 256
    Width = 385
    Height = 57
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'editMensaje')
    ParentFont = False
    TabOrder = 5
  end
end
