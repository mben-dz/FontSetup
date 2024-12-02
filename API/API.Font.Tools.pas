unit API.Font.Tools;

interface

uses
  System.SysUtils,
  system.Classes;

type
  TFontType = (ftTTF, ftOTF, ftUnknown);

//  TcRefProc<T> = reference to procedure (const T);
  TLogProc = TProc<string>;

  IFontTool = interface ['{A5CAC58A-A4A6-47D0-878C-8BAAEDF02314}']
    function LoadFromFile: IFontTool;
    function IsFontLoaded: Boolean;
    function GetName: string;
    function Unload: Boolean;
  end;

  function GetTFontTool(aLogProc: TLogProc): IFontTool;

implementation
uses
  Winapi.Windows,
  System.Threading,
  System.SyncObjs,
//
  API.Vcl.Files;

const
  FR_PRIVATE = $10;
  GFRI_DESCRIPTION = 1;
  GFRI_LOGFONTS = 2;
  GFRI_NUMFACES = 3;

function GetFontResourceInfoW(lpszFilename: PWideChar; var cbBuffer: DWORD;
                              lpBuffer: Pointer; dwQueryType: DWORD): BOOL; stdcall;
                              external gdi32 name 'GetFontResourceInfoW';

type
  TFormatSValues<T> = array of T;

  TFontTool = class(TInterfacedObject, IFontTool)
  strict private
    fLock: TCriticalSection;

    fLogProc: TLogProc;
    fIsLoaded: Boolean;
    fName,
    fFileName: string;

    procedure ResetFields;
    procedure Log(const aMsg: string; const aFormatValues: array of const);
    function Setup(const aFontFileName: string): Boolean;
    function GetWinApiFontName(const aFontFileName: string): string;
  private
    function LoadFromFile: IFontTool;
    function IsFontLoaded: Boolean;
    function GetName: string;
    function Unload: Boolean;

    constructor Create(aLogProc: TLogProc);
    destructor Destroy; override;
  end;

function GetTFontTool(aLogProc: TLogProc): IFontTool; begin
  Result := TFontTool.Create(aLogProc);
end;

{ TFontTool }

constructor TFontTool.Create(aLogProc: TLogProc);
begin
  fLogProc  := aLogProc;

  fIsLoaded := False;
  fName     := '';
  fFileName := '';

  fLock     := TCriticalSection.Create;
end;

destructor TFontTool.Destroy;
begin
  fLock.Free;
  Unload; // Unload if Any ..

  inherited;
end;

procedure TFontTool.Log(const aMsg: string; const aFormatValues: array of const);
var
  LFormatValues: TArray<TVarRec>;
  I: Integer;
begin
  if Assigned(fLogProc) then
  begin
    SetLength(LFormatValues, Length(aFormatValues));
    for I := 0 to High(aFormatValues) do
      LFormatValues[I] := aFormatValues[I];

    TThread.Queue(nil, procedure
    var
      LFormattedMsg: string;
    begin
      fLock.Acquire;
      try
        LFormattedMsg := Format(aMsg, LFormatValues);
        fLogProc(LFormattedMsg);
      finally
        fLock.Release;
      end;
    end);
  end;
end;

procedure TFontTool.ResetFields;
begin
  fIsLoaded := False;
  fName     := '';
  fFileName := '';
end;

function TFontTool.GetWinApiFontName(const aFontFileName: string): string;
var
  LFontPath  : PChar;
  LBuffer    : array[0..255] of Char;
  LBufferSize: DWORD;

  LResult    : string;
begin
  LResult := '';

  LFontPath   := PChar(aFontFileName);
  LBufferSize := SizeOf(LBuffer);

  if GetFontResourceInfoW(LFontPath, LBufferSize, @LBuffer, GFRI_DESCRIPTION) then
  begin
    SetString(LResult, LBuffer, LBufferSize div SizeOf(Char));
    LResult := Trim(LResult);
    Log(' [%s] Font Name Loaded Successfully from this file: %s %s', [LResult, sLineBreak, aFontFileName]);
  end else begin
    Log('Failed to get font Name for this file: %s %s', [sLineBreak, aFontFileName]);
  end;

  Result := LResult;
end;

function TFontTool.Setup(const aFontFileName: string): Boolean;
var
  LResult: Boolean;
begin
  LResult := False;

  if AddFontResourceEx(PChar(aFontFileName), FR_PRIVATE, nil) <> 0 then begin
    LResult := True;
    fName   := GetWinApiFontName(fFileName);
    Log(' [%s] Successfully Installed...', [fName]);
  end else Log('Failed to install local font for this file:%s %s', [sLineBreak, aFontFileName]);

  Result := LResult;
end;

function TFontTool.Unload: Boolean;
var
  LResult: Boolean;
begin
  LResult := False;

  if fIsLoaded then
    if FileExists(fFileName) then
      LResult := RemoveFontResourceEx(PChar(fFileName), FR_PRIVATE, nil);

  Result := LResult;
end;

function TFontTool.LoadFromFile: IFontTool;
begin
  Result := Self;

  Unload; // Unload if Any ..

  ResetFields; // Prepare fields for new call.

  try
    fFileName := GetFileFileName('Font Files (*.ttf; *.otf)|*.ttf;*.otf|All Files (*.*)|*.*');
  finally
    if Setup(fFileName) then begin
      fIsLoaded := True;
    end;
  end;
end;

function TFontTool.IsFontLoaded: Boolean;
begin
  Result := fIsLoaded;
end;

function TFontTool.GetName: string;
begin
  Result := fName;
end;

end.
