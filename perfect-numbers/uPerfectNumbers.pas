{**********************************************}
{                                              }
{  uPerfectNumbers.pas                         }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uPerfectNumbers;

interface

Uses System.SysUtils;

Type
  ENotNaturalNumber = Exception;

  TNumberType = (Perfect, Abundant, Deficient);

  PerfectNumber = class
    class function Classify (const n: integer): TNumberType;
  end;

implementation

class function PerfectNumber.Classify (const n: integer): TNumberType;
var
  i: integer;
  sum: integer;
begin
  if (n <= 0) then raise ENotNaturalNumber.Create('Classification is only possible for natural numbers.');

  sum := 0;
  i := 1;
  while (i <= (n div 2)) do
  begin
    if ((n mod i) = 0) then
      Inc (sum, i);

    Inc (i);
  end;

  if (sum = n) then
    Result := Perfect

  else if (sum > n) then
    Result := Abundant

  else
    Result := Deficient;
end;

end.
