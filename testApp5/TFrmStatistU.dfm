inherited FrmStatist: TFrmStatist
  Caption = #1040#1056#1052' '#1057#1090#1072#1090#1080#1089#1090#1072
  PixelsPerInch = 96
  TextHeight = 13
  inherited plSearch: TPanel
    inherited plSearchTop: TPanel
      inherited cbSearchFull: TCheckBox
        Checked = True
        Enabled = False
        State = cbChecked
      end
    end
    inherited gbCondition: TGroupBox
      inherited plSerchCond: TPanel
        inherited plCondRegDate: TPanel
          inherited cpFromRegDate: TCalendarPicker
            ExplicitLeft = 22
            ExplicitTop = -6
          end
        end
        inherited plCondBDate: TPanel
          inherited cpFromBDate: TCalendarPicker
            ExplicitLeft = 22
          end
          inherited cpToBDate: TCalendarPicker
            ExplicitLeft = 188
          end
        end
      end
    end
    inherited Panel1: TPanel
      inherited rbLName: TRadioButton
        Checked = True
        TabStop = True
        OnClick = rbLNameClick
      end
      inherited rbBDate: TRadioButton
        Top = 35
        OnClick = rbBDateClick
        ExplicitTop = 41
      end
      inherited rbRegDate: TRadioButton
        Top = 18
        OnClick = rbRegDateClick
        ExplicitLeft = 1
        ExplicitTop = 23
        ExplicitWidth = 134
      end
    end
  end
  inherited tbInfo: TToolBar
    inherited tBtnAddPerson: TToolButton
      Enabled = False
      Visible = False
    end
    inherited tBtnAddExtra: TToolButton
      Enabled = False
      Visible = False
    end
    inherited ToolButton3: TToolButton
      Enabled = False
      Visible = False
    end
  end
end
