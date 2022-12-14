object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 190
    Width = 505
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btnClose: TButton
      AlignWithMargins = True
      Left = 426
      Top = 8
      Width = 75
      Height = 25
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alRight
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = btnCloseClick
      ExplicitTop = 9
    end
    object btnNewWindow: TButton
      AlignWithMargins = True
      Left = 345
      Top = 8
      Width = 75
      Height = 25
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alRight
      Caption = #1053#1086#1074#1086#1077' '#1086#1082#1085#1086
      TabOrder = 1
      OnClick = btnNewWindowClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 505
    Height = 190
    Align = alClient
    TabOrder = 1
    object pcMainPages: TPageControl
      Left = 1
      Top = 1
      Width = 503
      Height = 188
      Align = alClient
      TabOrder = 0
    end
  end
end
