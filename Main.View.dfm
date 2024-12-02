object MainView: TMainView
  Left = 0
  Top = 0
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  Caption = 'Font Tool Demo'
  ClientHeight = 502
  ClientWidth = 904
  Color = 10700641
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clInactiveCaption
  Font.Height = -30
  Font.Name = 'Segoe UI'
  Font.Style = []
  Font.Quality = fqClearTypeNatural
  PixelsPerInch = 144
  DesignSize = (
    904
    502)
  TextHeight = 41
  object Lbl_Test: TLabel
    Left = 10
    Top = 323
    Width = 604
    Height = 123
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akLeft, akBottom]
    Caption = 
      #1593#1585#1576#1610' English Fran'#231'ais '#26085#26412#35486' '#20013#25991#13#10'The quick brown fox jumps over the' +
      ' lazy dog.'#13#10'0123456789!@#$%^&*()-_=+[]{}|;:'#39'",.<>?/\`~'
  end
  object GrdPnlClient: TGridPanel
    Left = 10
    Top = 10
    Width = 884
    Height = 304
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = GrdPnlBtns
        Row = 0
      end
      item
        Column = 0
        Control = Memo_Log
        Row = 1
      end>
    RowCollection = <
      item
        Value = 25.000000000000000000
      end
      item
        Value = 75.000000000000000000
      end>
    TabOrder = 0
    object GrdPnlBtns: TGridPanel
      Left = 0
      Top = 0
      Width = 882
      Height = 76
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 62.000000000000000000
        end
        item
          Value = 37.999999999999990000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = BtnSetupFont
          Row = 0
        end
        item
          Column = 1
          Control = BtnApplyFont
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 0
      ExplicitLeft = 570
      ExplicitTop = 32
      ExplicitWidth = 185
      ExplicitHeight = 40
      object BtnSetupFont: TButton
        Left = 0
        Top = 0
        Width = 546
        Height = 74
        Cursor = crHandPoint
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Caption = 'Install Font from File'
        TabOrder = 0
        OnClick = BtnSetupFontClick
        ExplicitLeft = 12
        ExplicitTop = 10
        ExplicitWidth = 481
        ExplicitHeight = 51
      end
      object BtnApplyFont: TButton
        Left = 546
        Top = 0
        Width = 334
        Height = 74
        Cursor = crHandPoint
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alClient
        Caption = 'Apply Font'
        Enabled = False
        TabOrder = 1
        OnClick = BtnApplyFontClick
        ExplicitLeft = 38
        ExplicitTop = 8
        ExplicitWidth = 366
        ExplicitHeight = 51
      end
    end
    object Memo_Log: TMemo
      Left = 0
      Top = 76
      Width = 882
      Height = 226
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      Color = 5777205
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clInactiveCaption
      Font.Height = -26
      Font.Name = 'Segoe UI'
      Font.Style = []
      Font.Quality = fqClearTypeNatural
      Lines.Strings = (
        'Log goes here ..')
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 71
      ExplicitHeight = 158
    end
  end
  object PnlStatusBar: TPanel
    Left = 0
    Top = 461
    Width = 904
    Height = 41
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alBottom
    Alignment = taLeftJustify
    Anchors = []
    BevelOuter = bvNone
    Caption = 'Status..'
    Color = 16755413
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clPurple
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    Font.Quality = fqClearTypeNatural
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 1
    ExplicitTop = 228
    ExplicitWidth = 882
  end
end
