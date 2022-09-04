object MainForm: TMainForm
  Left = 194
  Top = 111
  Caption = 'TestApp'
  ClientHeight = 441
  ClientWidth = 834
  Color = clAppWorkSpace
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Default'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object plChoiseARM: TPanel
    Left = 0
    Top = 0
    Width = 834
    Height = 70
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object plChLeft: TPanel
      Left = 1
      Top = 1
      Width = 425
      Height = 68
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object btnARMOperator: TButton
        AlignWithMargins = True
        Left = 245
        Top = 3
        Width = 150
        Height = 62
        Margins.Right = 30
        Align = alRight
        Caption = #1040#1056#1052' '#1054#1087#1077#1088#1072#1090#1086#1088#1072
        TabOrder = 0
        OnClick = BtnClic
      end
    end
    object plChClient: TPanel
      Left = 426
      Top = 1
      Width = 407
      Height = 68
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object btnARMStatist: TButton
        Tag = 1
        AlignWithMargins = True
        Left = 30
        Top = 3
        Width = 150
        Height = 62
        Margins.Left = 30
        Align = alLeft
        Caption = #1040#1056#1052' '#1057#1090#1072#1090#1080#1089#1090#1072
        TabOrder = 0
        OnClick = BtnClic
      end
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 24
    Top = 392
    object File1: TMenuItem
      Caption = #1042#1099#1073#1086#1088' '#1040#1056#1052
      Hint = 'File related commands'
      object miOperator: TMenuItem
        Caption = #1040#1056#1052' &'#1054#1087#1077#1088#1072#1090#1086#1088#1072
        ImageIndex = 0
        ShortCut = 16463
        OnClick = BtnClic
      end
      object miStatist: TMenuItem
        Tag = 1
        Caption = #1040#1056#1052' '#1057#1090'&'#1072#1090#1080#1089#1090#1072
        ImageIndex = 1
        ShortCut = 16449
        OnClick = BtnClic
      end
    end
  end
  object ImageList1: TImageList
    Left = 64
    Top = 392
    Bitmap = {
      494C010102001400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000000000000000000000000000FEFE
      FE01FBFBFB04FAFAFA05FBFBFB04FCFCFC03FCFCFC03FBFBFB04FBFBFB04FDFD
      FD0200000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F0F0
      F00FB5B5B54A7F7F7F805A5A5AA54B4B4BB4505050AF6A6A6A9598989867D3D3
      D32C00000000000000000000000000000000F3F3F30C0C0C0CF3DFDFDF20EEEE
      EE11F3F3F30C0C0C0CF3DFDFDF20EEEEEE11F3F3F30C0C0C0CF3DFDFDF20EEEE
      EE11F3F3F30C0C0C0CF3DFDFDF20EDEDED120000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF030303FC040404FB040404FB030303FC030303FC040404FB040404FB0000
      00FF030303FC363636C9FEFEFE0100000000FFFFFF000D0D0DF2EEEEEE11FDFD
      FD02FFFFFF000D0D0DF2EEEEEE11FDFDFD02FFFFFF000D0D0DF2EEEEEE11FDFD
      FD02FFFFFF000D0D0DF2EEEEEE11FDFDFD020000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF040404FB86868679FBFBFB0400000000FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE01FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFC038181817E0606
      06F9000000FF000000FF000000FF000000FF000000FF000000FF000000FF0101
      01FE000000FF000000000000000000000000FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE01FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE016D6D
      6D92010101FE030303FC000000FF000000FF000000FF000000FF020202FD0000
      00FFFDFDFD02FEFEFE010000000000000000FFFFFF00111111EE0D0D0DF20D0D
      0DF20D0D0DF2000000FFEEEEEE11FEFEFE01FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FC0300000000424242BD010101FE040404FB020202FD000000FFC1C1C13E0000
      0000FEFEFE01000000000000000000000000FFFFFF00EFEFEF10EFEFEF10EFEF
      EF10F3F3F30C0C0C0CF3EFEFEF10FEFEFE01FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFD0200000000000000FF99999966333333CC5E5E5EA1FAFAFA05FEFE
      FE0100000000000000000000000000000000FFFFFF00FEFEFE01FEFEFE01FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE01FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EBEBEB14EFEFEF10111111EE050505FA000000FF000000FF00000000F3F3
      F30CFEFEFE01000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000D0D0DF2EFEFEF10FEFEFE01FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE013B3B
      3BC46161619E000000FF020202FD010101FE000000FF000000FFE9E9E9160000
      00FF00000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000D0D0DF2EFEFEF10FEFEFE01FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF000D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002828
      28D767676798000000FF000000FF000000FF000000FF030303FCBDBDBD420000
      00FFFBFBFB04FEFEFE010000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000D0D0DF2EFEFEF10FEFEFE01FFFFFF000D0D0DF2EEEEEE11FDFD
      FD02FFFFFF000D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC03B4B4
      B44B6363639C000000FF000000FF000000FF000000FF030303FCC3C3C33C0000
      00FF00000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000D0D0DF2EFEFEF10FEFEFE01FFFFFF000D0D0DF2DFDFDF20EEEE
      EE11F3F3F30C0D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002C2C2CD3333333CC060606F9000000FF010101FE000000FF000000009797
      9768FBFBFB04000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000D0D0DF2EFEFEF10FEFEFE01FFFFFF00111111EE0D0D0DF20D0D
      0DF20D0D0DF20D0D0DF2EFEFEF10FEFEFE010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FDFD
      FD02525252AD00000000565656A9000000FF0F0F0FF0DEDEDE213C3C3CC30000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000D0D0DF2EEEEEE11FDFDFD02FFFFFF000D0D0DF2EFEFEF10FEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006262629D262626D98D8D8D7267676798020202FDF4F4F40BFEFE
      FE0100000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000D0D0DF2DFDFDF20EEEEEE11F3F3F30C0C0C0CF3EFEFEF10FEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FCFCFC0300000000000000000000000000000000FEFEFE010000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00111111EE010101FE000000FF000000FF000000FFEEEEEE11FEFE
      FE01FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00F000000000000E00F000000000000
      C001000000000000C0010000000000008007000000000000C003000000000000
      E817000000000000F40F000000000000F027000000000000C00F000000000000
      E003000000000000C00F000000000000F027000000000000E41F000000000000
      F80F000000000000FBDF00000000000000000000000000000000000000000000
      000000000000}
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files (x86)\PostgreSQL\12\bin\libpq.dll'
    Left = 103
    Top = 391
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
    Left = 143
    Top = 391
  end
end
