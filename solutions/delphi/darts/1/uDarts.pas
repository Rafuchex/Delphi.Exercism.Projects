{**********************************************}
{                                              }
{  uDarts.pas                                  }
{  Programmed by Rafael Perez Marin            }
{  2025-10-15                                  }
{                                              }
{**********************************************}

unit uDarts;

interface

Type
  TDarts = class
    class function Score (const x, y: double): integer;
  end;

implementation

class function TDarts.Score (const x, y: double): integer;
var r: double;
begin
  r := Sqrt((x * x) + (y * y));
  if (r > 10.0) then
    Result := 0

  else if ((r > 5.0) and (r <= 10.0)) then
    Result := 1

  else if ((r > 1.0) and (r <= 5.0)) then
    Result := 5

  else if (r <= 1.0) then
    Result := 10;

end;

end.
