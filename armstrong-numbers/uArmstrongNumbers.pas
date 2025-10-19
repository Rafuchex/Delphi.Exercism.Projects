{**********************************************}
{                                              }
{  uArmstrongNumbers.pas                       }
{  Programmed by Rafael Perez Marin            }
{  2025-10-16                                  }
{                                              }
{**********************************************}

unit uArmstrongNumbers;

interface

function isArmstrongNumber (const number: integer): boolean;

implementation

uses System.Math;

function NumberOfDigits (const number: integer): integer;
var
  limits: TArray<integer>;
  n, i: integer;
begin
  n := number;
  if (n < 0) then n := -1 * n;

  SetLength (limits, 9);
  limits[0] := 10;
  for i := Succ(Low(limits)) to High(limits) do
    limits[i] := 10 * limits[i - 1];

  for i := Low(limits) to High(limits) do
    if (limits[i] > n) then
    begin
      Result := Succ(i);
      Exit;
    end;
end;

function isArmstrongNumber (const number: integer): boolean;
var
  n, k, d, sum: integer;
begin
  n := number;
  if ((n >= 0) and (n < 10)) then
  begin
    Result := true;
    Exit;
  end
  else if ((n >= 10) and (n < 100)) then
  begin
    Result := false;
    Exit;
  end
  else
  Begin
    d := NumberOfDigits(n);

    sum := 0;
    while (n > 0) do
    begin
      k := n mod 10;
      sum := sum + Trunc(Power(k, d));
      n := n div 10;
    end;
    Result := (number = sum);
  End;
end;

end.
