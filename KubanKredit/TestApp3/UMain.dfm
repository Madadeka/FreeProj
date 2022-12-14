object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 231
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 190
    Width = 514
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 196
    ExplicitWidth = 505
    object btnGetData: TButton
      AlignWithMargins = True
      Left = 397
      Top = 8
      Width = 113
      Height = 25
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alRight
      Caption = #1055#1086#1083#1091#1095#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      TabOrder = 0
      OnClick = btnGetDataClick
      ExplicitLeft = 56
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 514
    Height = 190
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 72
    ExplicitTop = 88
    ExplicitWidth = 185
    ExplicitHeight = 41
    object dbgMainData: TDBGrid
      Left = 1
      Top = 1
      Width = 512
      Height = 188
      Align = alClient
      DataSource = dsMainData
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'store'
          Title.Caption = #1052#1072#1075#1072#1079#1080#1085
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'address'
          Title.Caption = #1040#1076#1088#1077#1089
          Width = 230
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'product'
          Title.Caption = #1055#1088#1086#1076#1091#1082#1090
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'price'
          Title.Caption = #1062#1077#1085#1072
          Visible = True
        end>
    end
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\12\bin\libpq.dll'
    Left = 447
    Top = 3
  end
  object taConn: TFDConnection
    Params.Strings = (
      'Database=postgres'
      'User_Name=postgres'
      'Password=252800'
      'Server=127.0.0.1'
      'Port=5434'
      'DriverID=PG')
    Connected = True
    Left = 447
    Top = 51
  end
  object taQuery: TFDQuery
    Connection = taConn
    SQL.Strings = (
      'select v.store, v.address, v.product, v.price '
      'from view_store_product v')
    Left = 447
    Top = 99
  end
  object dsMainData: TDataSource
    DataSet = taQuery
    Left = 448
    Top = 144
  end
end
