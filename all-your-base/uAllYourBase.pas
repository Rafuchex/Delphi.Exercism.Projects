{**********************************************}
{                                              }
{  uAllYourBase.pas                            }
{  Programmed by Rafael Perez Marin            }
{  2025-10-15                                  }
{                                              }
{**********************************************}

unit uAllYourBase;

interface

uses System.SysUtils, System.Generics.Collections, System.Math;

type
  TBase = class
    class function Rebase(const fromBase: integer; const digits: array of integer; const toBase: integer): TArray<integer>;
  end;

implementation

class function TBase.Rebase(const fromBase: integer; const digits: array of integer; const toBase: integer): TArray<integer>;
var
  i, n, k: integer;
  nums: TList<integer>;
begin
  if (fromBase < 2) then
    raise EArgumentOutOfRangeException.Create('input base must be >= 2');

  if (toBase < 2) then
    raise EArgumentOutOfRangeException.Create('output base must be >= 2');

  for i := Low(digits) to High(digits) do
     if ((digits[i] < 0) or (digits[i] >= fromBase)) then
       raise EArgumentOutOfRangeException.Create('all digits must satisfy 0 <= d < input base');

  nums := TList<integer>.Create;
  nums.Capacity := 16;
  try
    n := 0;
    k := 1;
    for i := High(digits) downto Low(digits) do
    Begin
      Inc (n, digits[i] * k);
      k := k * fromBase;
    End;

    if (n > 0) then
      while (n >= 1) do
      begin
        nums.Insert(0, (n mod toBase));
        n := (n div toBase);
      end
    else
      nums.Add(n);

    Result := nums.ToArray;
  finally
    nums.Free;
  end;
end;

end.

