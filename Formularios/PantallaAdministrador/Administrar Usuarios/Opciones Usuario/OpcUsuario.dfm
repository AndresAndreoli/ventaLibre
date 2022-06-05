object formOpcionesUsuario: TformOpcionesUsuario
  Left = 957
  Top = 262
  Width = 194
  Height = 182
  Caption = 'formOpcionesUsuario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 25
  object labelMail: TLabel
    Left = 16
    Top = 72
    Width = 77
    Height = 25
    Caption = 'labelMail'
    Visible = False
  end
  object btnBloquear: TButton
    Left = 16
    Top = 16
    Width = 145
    Height = 49
    Caption = 'Bloquear'
    TabOrder = 0
    OnClick = btnBloquearClick
  end
  object btnDesbloquear: TButton
    Left = 16
    Top = 16
    Width = 145
    Height = 49
    Caption = 'Desbloquear'
    TabOrder = 1
    OnClick = btnDesbloquearClick
  end
  object btnCompras: TButton
    Left = 16
    Top = 80
    Width = 145
    Height = 49
    Caption = 'Compras'
    TabOrder = 2
    OnClick = btnComprasClick
  end
end
