inherited FrmOperator: TFrmOperator
  Caption = #1040#1056#1052' '#1054#1087#1077#1088#1072#1090#1086#1088#1072
  PixelsPerInch = 96
  TextHeight = 13
  inherited plSearch: TPanel
    inherited plSearchTop: TPanel
      inherited edtSearchText: TEdit
        OnKeyDown = edtSearchTextKeyDown
      end
    end
    inherited Panel1: TPanel
      ExplicitLeft = 1
      ExplicitTop = 42
      inherited btSearch: TButton
        Top = 43
        Height = 60
        OnClick = btSearchClick
        ExplicitLeft = 4
        ExplicitTop = 13
        ExplicitWidth = 128
        ExplicitHeight = 60
      end
      inherited rbLName: TRadioButton
        Enabled = False
        Visible = False
      end
      inherited rbBDate: TRadioButton
        Enabled = False
        Visible = False
      end
      inherited rbRegDate: TRadioButton
        Enabled = False
        Visible = False
        ExplicitLeft = 1
        ExplicitTop = 39
        ExplicitWidth = 134
      end
    end
  end
  inherited plArmInfo: TPanel
    inherited sgExtras: TStringGrid
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing, goRowSelect, goFixedRowDefAlign]
      RowHeights = (
        24
        24
        25
        24
        24)
    end
    inherited sgPerson: TStringGrid
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect, goFixedRowDefAlign]
      OnSelectCell = sgPersonSelectCell
    end
  end
  inherited tbInfo: TToolBar
    inherited tBtnAddPerson: TToolButton
      OnClick = tBtnAddPersonClick
    end
    inherited tBtnAddExtra: TToolButton
      OnClick = tBtnAddExtraClick
    end
    inherited tBtnRefresh: TToolButton
      OnClick = tBtnRefreshClick
    end
  end
  object Timer1: TTimer [4]
    Left = 336
    Top = 313
  end
end
