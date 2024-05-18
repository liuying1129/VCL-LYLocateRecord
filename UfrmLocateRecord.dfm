object frmLocateRecord: TfrmLocateRecord
  Left = 372
  Top = 142
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26597#25214
  ClientHeight = 251
  ClientWidth = 182
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 20
    Width = 52
    Height = 13
    Caption = #26597#25214#26465#20214
  end
  object Label2: TLabel
    Left = 10
    Top = 56
    Width = 65
    Height = 13
    Caption = #38656#26597#25214#30340#20540
  end
  object btnFirst: TBitBtn
    Left = 11
    Top = 216
    Width = 80
    Height = 25
    Caption = #26597#25214'(F3)'
    TabOrder = 0
    OnClick = btnFirstClick
  end
  object btnClose: TBitBtn
    Left = 92
    Top = 216
    Width = 80
    Height = 25
    Cancel = True
    Caption = #20851#38381'(Esc)'
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object cmbField: TComboBox
    Left = 83
    Top = 16
    Width = 94
    Height = 21
    Color = clInfoBk
    Ctl3D = True
    DropDownCount = 20
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 2
  end
  object edtFieldValue: TEdit
    Left = 83
    Top = 56
    Width = 94
    Height = 19
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 3
    OnChange = edtFieldValueChange
  end
  object CheckBox1: TCheckBox
    Left = 13
    Top = 192
    Width = 159
    Height = 17
    Caption = #20445#23384#26597#35810#26465#20214
    TabOrder = 4
  end
  object CheckBox2: TCheckBox
    Left = 13
    Top = 168
    Width = 159
    Height = 17
    Caption = #26597#25214#20540#37096#20998#21305#37197
    TabOrder = 5
  end
  object ActionList1: TActionList
    Left = 8
    Top = 104
    object Action_Find: TAction
      Caption = 'Action_Find'
      ShortCut = 114
      OnExecute = btnFirstClick
    end
  end
end
