object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 375
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 334
    Width = 617
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btnStart: TButton
      AlignWithMargins = True
      Left = 538
      Top = 4
      Width = 75
      Height = 33
      Align = alRight
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      AlignWithMargins = True
      Left = 457
      Top = 4
      Width = 75
      Height = 33
      Align = alRight
      Caption = 'Stop'
      TabOrder = 1
      OnClick = btnStopClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 617
    Height = 334
    Align = alClient
    TabOrder = 1
    object mMainInfo: TMemo
      Left = 1
      Top = 1
      Width = 615
      Height = 332
      Align = alClient
      TabOrder = 0
    end
  end
end
