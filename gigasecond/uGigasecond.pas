unit uGigasecond;

interface

uses SysUtils, System.DateUtils;

Type
  TGigasecond = class
    class function Add(arg: string): string;
  end;

implementation

class function TGigasecond.Add(arg: string): string;
var
  i: integer;
  d, t: TDateTime;
  settings: TFormatSettings;
begin
  settings := TFormatSettings.Create;
  settings.DateSeparator := '-';
  settings.ShortDateFormat := 'yyyy-mm-dd';
  settings.ShortTimeFormat := 'hh:nn:ss';

  i := Pos('T', arg);
  if (i > 0) then
  begin
    d := StrToDate(Copy(arg, 1, i - 1), settings);
    t := StrToTime(Copy(arg, i + 1, Length(arg) - i), settings);
    d := d + t;
  end
  else
    d := StrToDate(arg, settings);

  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', System.DateUtils.IncSecond(d, 1000000000));
end;

end.

