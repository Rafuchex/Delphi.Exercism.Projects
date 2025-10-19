unit uLeap;

interface

Type
  TYear = class
    class function IsLeap (year: integer): Boolean;
  end;

implementation

class function TYear.IsLeap (year: integer): Boolean;
begin
  Result := ((year mod 4) = 0);
  if (Result) then
  begin
    if (not ((year mod 100) = 0)) then exit;
    if ((year mod 400) = 0) then
      exit
    else
      Result := false;
  end;
end;

end.