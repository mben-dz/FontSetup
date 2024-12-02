unit API.Vcl.Files;

interface
uses
  System.Classes,
  Vcl.Dialogs;

  function GetFileFileName(const aFilter: string; aOwner: TComponent = nil): string;

implementation
uses
  System.IOUtils;

function GetFileFileName(const aFilter: string; aOwner: TComponent = nil): string;
var
  LResult: string;
begin
  LResult := '';

  with TOpenDialog.Create(aOwner) do
  begin
    try
      // Set the filter to show only Filtered files ..
      Filter := aFilter;

      // Set the default directory to the Documents folder
      InitialDir := TPath.GetDocumentsPath;

      if Execute then
        LResult := FileName;
    finally
      Free;
    end;
  end;

  Result := LResult;
end;

end.
