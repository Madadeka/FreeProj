object frmAdd: TfrmAdd
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100
  ClientHeight = 293
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object plAddPerson: TPanel
    Left = 0
    Top = 0
    Width = 414
    Height = 145
    Align = alTop
    TabOrder = 0
    object btAddPerson: TButton
      Left = 320
      Top = 61
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 0
      OnClick = btAddPersonClick
    end
    object plPersonInfo: TPanel
      Left = 1
      Top = 1
      Width = 304
      Height = 143
      Align = alLeft
      TabOrder = 1
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 302
        Height = 13
        Align = alTop
        Caption = #1060#1072#1084#1080#1083#1080#1103
        ExplicitWidth = 44
      end
      object Label2: TLabel
        Left = 1
        Top = 35
        Width = 302
        Height = 13
        Align = alTop
        Caption = #1048#1084#1103
        ExplicitWidth = 19
      end
      object Label3: TLabel
        Left = 1
        Top = 69
        Width = 302
        Height = 13
        Align = alTop
        Caption = #1054#1090#1095#1077#1089#1090#1074#1086
        ExplicitWidth = 49
      end
      object Label4: TLabel
        Left = 1
        Top = 103
        Width = 302
        Height = 13
        Align = alTop
        Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
        ExplicitWidth = 80
      end
      object edtLName: TEdit
        Left = 1
        Top = 14
        Width = 302
        Height = 21
        Align = alTop
        TabOrder = 0
      end
      object edtFName: TEdit
        Left = 1
        Top = 48
        Width = 302
        Height = 21
        Align = alTop
        TabOrder = 1
      end
      object edtPat: TEdit
        Left = 1
        Top = 82
        Width = 302
        Height = 21
        Align = alTop
        TabOrder = 2
      end
      object cpBDate: TCalendarPicker
        Left = 1
        Top = 116
        Width = 302
        Height = 32
        Align = alTop
        CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
        CalendarHeaderInfo.DaysOfWeekFont.Height = -13
        CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
        CalendarHeaderInfo.DaysOfWeekFont.Style = []
        CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
        CalendarHeaderInfo.Font.Color = clWindowText
        CalendarHeaderInfo.Font.Height = -20
        CalendarHeaderInfo.Font.Name = 'Segoe UI'
        CalendarHeaderInfo.Font.Style = []
        Color = clWindow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        TextHint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1072#1090#1091
      end
    end
  end
  object plAddExtra: TPanel
    Left = 0
    Top = 145
    Width = 414
    Height = 148
    Align = alClient
    TabOrder = 1
    object plExtraInfo: TPanel
      Left = 1
      Top = 1
      Width = 303
      Height = 146
      Align = alLeft
      TabOrder = 0
      object Label5: TLabel
        Left = 1
        Top = 1
        Width = 301
        Height = 13
        Align = alTop
        Caption = #1057#1087#1088#1072#1074#1082#1072
        ExplicitWidth = 43
      end
      object mmExtra: TMemo
        Left = 1
        Top = 14
        Width = 301
        Height = 131
        Align = alClient
        TabOrder = 0
      end
    end
    object btnAddExtra: TButton
      Left = 320
      Top = 72
      Width = 75
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = btnAddExtraClick
    end
  end
end
