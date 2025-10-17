{**********************************************}
{                                              }
{  uRaindrops.pas                              }
{  Programmed by Rafael Perez Marin            }
{  2025-10-16                                  }
{                                              }
{**********************************************}

unit uRaindrops;

interface

Type
  Raindrops = class
    class function Convert (const n: integer): string;
  end;

implementation

uses SysUtils;

class function Raindrops.Convert (const n: integer): string;
begin
  Result := '';
  if ((n mod 3) = 0) then Result := Result + 'Pling';
  if ((n mod 5) = 0) then Result := Result + 'Plang';
  if ((n mod 7) = 0) then Result := Result + 'Plong';
  if (Result = '') then Result := IntToStr(n);

end;

end.