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
  i, d: integer;
  sum: integer;
begin
  if (n <= 0) then raise ENotNaturalNumber.Create('Classification is only possible for natural numbers.');

  i := 1;
  d := n;
  while (i < n) do
  begin
    if ((d mod i) = 0) then
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
