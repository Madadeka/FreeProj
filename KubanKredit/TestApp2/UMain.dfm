object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 290
  ClientWidth = 552
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 249
    Width = 552
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 190
    ExplicitWidth = 505
    object btnParse: TButton
      AlignWithMargins = True
      Left = 473
      Top = 8
      Width = 75
      Height = 25
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alRight
      Caption = #1056#1072#1089#1087#1072#1088#1089#1080#1090#1100
      TabOrder = 0
      OnClick = btnParseClick
      ExplicitLeft = 426
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 552
    Height = 249
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 505
    ExplicitHeight = 190
    object Splitter1: TSplitter
      Left = 356
      Top = 1
      Height = 247
      Align = alRight
      ExplicitLeft = 272
      ExplicitTop = 104
      ExplicitHeight = 100
    end
    object mmXmlStrings: TMemo
      Left = 1
      Top = 1
      Width = 355
      Height = 247
      Align = alClient
      Lines.Strings = (
        '<?xml version="1.0"?>'
        '<test>'
        '  <animals>'
        '    <animal id="1">'
        '       <name>'#1057#1086#1073#1072#1082#1072'</name>'
        '       <age>4</age>'
        '    </animal>'
        '    <animal id="2">'
        '       <name>'#1050#1086#1096#1082#1072'</name>'
        '       <age>2</age>'
        '    </animal>'
        '    <animal id="3">'
        '       <name>'#1057#1086#1073#1072#1082#1072'</name>'
        '       <age>6</age>'
        '    </animal>'
        '  </animals>'
        '</test>')
      TabOrder = 0
      ExplicitWidth = 308
      ExplicitHeight = 188
    end
    object lbFormatStrings: TListBox
      Left = 359
      Top = 1
      Width = 192
      Height = 247
      Align = alRight
      ItemHeight = 13
      TabOrder = 1
      ExplicitLeft = 312
      ExplicitHeight = 188
    end
  end
  object XMLDocument1: TXMLDocument
    XML.Strings = (
      '<?xml version="1.0"?>'
      '<test>'
      #9'<animals>'
      #9#9'<animal id="1">'
      #9#9#9'<name>'#1057#1086#1073#1072#1082#1072'</name>'
      #9#9#9'<age>4</age>'
      #9#9'</animal>'
      #9'</animals>'
      '</test>')
    Left = 296
    Top = 6
  end
end
