program FontSetup;

uses
  Vcl.Forms,
  Main.View in 'Main.View.pas' {MainView},
  API.Font.Tools in 'API\API.Font.Tools.pas',
  API.Vcl.Files in 'API\API.Vcl.Files.pas';

{$R *.res}

var
  MainView: TMainView;
begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
