unit Main.View;

interface

uses
{$REGION '  Emb .. '}
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
{$ENDREGION}
//
  API.Font.Tools;

type
  TMainView = class(TForm)
  {$REGION '  Comp .. '}
    Memo_Log: TMemo;
    Lbl_Test: TLabel;
    BtnSetupFont: TButton;
    BtnApplyFont: TButton;
    PnlStatusBar: TPanel;
    GrdPnlClient: TGridPanel;
    GrdPnlBtns: TGridPanel;
  {$ENDREGION}
    procedure BtnSetupFontClick(Sender: TObject);
    procedure BtnApplyFontClick(Sender: TObject);
  strict private
    fFontMgr: IFontTool;

    function GetFontMgr: IFontTool;
    procedure LogProc(aLog: string);
    procedure LogStatus(const aStatus: string);
  private
    property FontMgr: IFontTool read GetFontMgr;
  end;

implementation

{$R *.dfm}

{ TMainView }

procedure TMainView.LogProc(aLog: string);
begin
  Memo_Log.Lines.Append(aLog);
end;

procedure TMainView.LogStatus(const aStatus: string);
begin
  PnlStatusBar.Caption := aStatus;
end;

function TMainView.GetFontMgr: IFontTool;
begin
  if not Assigned(fFontMgr) then
    fFontMgr := GetTFontTool(LogProc);

  Result := fFontMgr;
end;

procedure TMainView.BtnSetupFontClick(Sender: TObject);
begin
  Memo_Log.Clear;
  try
    LogStatus(' [' + FontMgr.LoadFromFile.GetName + '] Is Loaded..');
  finally
    BtnApplyFont.Enabled := FontMgr.IsFontLoaded;
  end;

end;

procedure TMainView.BtnApplyFontClick(Sender: TObject);
begin
  if FontMgr.IsFontLoaded then begin
    Font.Name := FontMgr.GetName;
    BtnApplyFont.Enabled := False;
  end;

end;

end.
