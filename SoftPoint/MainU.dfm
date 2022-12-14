object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 334
  ClientWidth = 691
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 691
    Height = 334
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 490
      Top = 1
      Width = 200
      Height = 332
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 7
        Width = 194
        Height = 13
        Margins.Top = 7
        Align = alTop
        Caption = 'SQL Server'
        ExplicitWidth = 54
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 51
        Width = 194
        Height = 13
        Margins.Top = 7
        Align = alTop
        Caption = 'Port'
        ExplicitWidth = 20
      end
      object Label3: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 95
        Width = 194
        Height = 13
        Margins.Top = 7
        Align = alTop
        Caption = 'User'
        ExplicitWidth = 22
      end
      object Label4: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 139
        Width = 194
        Height = 13
        Margins.Top = 7
        Align = alTop
        Caption = 'Password'
        ExplicitWidth = 46
      end
      object Label5: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 196
        Width = 194
        Height = 13
        Margins.Top = 20
        Align = alTop
        Caption = 'Update period, ms'
        ExplicitWidth = 88
      end
      object eServer: TEdit
        Left = 0
        Top = 23
        Width = 200
        Height = 21
        Align = alTop
        TabOrder = 0
        OnExit = EditExit
      end
      object ePort: TEdit
        Tag = 1
        Left = 0
        Top = 67
        Width = 200
        Height = 21
        Align = alTop
        NumbersOnly = True
        TabOrder = 1
        OnExit = EditExit
      end
      object eUser: TEdit
        Tag = 2
        Left = 0
        Top = 111
        Width = 200
        Height = 21
        Align = alTop
        TabOrder = 2
        OnExit = EditExit
      end
      object ePass: TEdit
        Tag = 3
        Left = 0
        Top = 155
        Width = 200
        Height = 21
        Align = alTop
        PasswordChar = '*'
        TabOrder = 3
        OnExit = EditExit
      end
      object ePeriod: TEdit
        Tag = 4
        Left = 0
        Top = 212
        Width = 200
        Height = 21
        Align = alTop
        NumbersOnly = True
        TabOrder = 4
        OnExit = EditExit
      end
      object btnStop: TButton
        AlignWithMargins = True
        Left = 20
        Top = 301
        Width = 160
        Height = 25
        Margins.Left = 20
        Margins.Right = 20
        Margins.Bottom = 6
        Align = alBottom
        Caption = 'Stop'
        TabOrder = 5
        OnClick = btnStopClick
      end
      object btnStart: TButton
        AlignWithMargins = True
        Left = 20
        Top = 270
        Width = 160
        Height = 25
        Margins.Left = 20
        Margins.Right = 20
        Align = alBottom
        Caption = 'Start'
        TabOrder = 6
        OnClick = btnStartClick
      end
    end
    object sgTestObjects: TStringGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 483
      Height = 326
      Align = alClient
      ColCount = 4
      DefaultColWidth = 120
      FixedCols = 3
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
      TabOrder = 1
      ExplicitTop = 7
    end
  end
  object tUpdateQuery: TTimer
    Enabled = False
    OnTimer = tUpdateQueryTimer
    Left = 432
    Top = 288
  end
end
