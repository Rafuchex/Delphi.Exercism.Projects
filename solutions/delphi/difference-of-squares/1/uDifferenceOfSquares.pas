{**********************************************}
{                                              }
{  uDifferenceOfSquares.pas                    }
{  Programmed by Rafael Perez Marin            }
{  2025-10-15                                  }
{                                              }
{**********************************************}

unit uDifferenceOfSquares;

interface

function squareOfSum (const n: integer): integer;
function sumOfSquares (const n: integer): integer;
function differenceOfSquares(const n: integer): integer;

implementation

function squareOfSum (const n: integer): integer;
var i: integer;
begin
  Result := 0;
  for i := 1 to n do Inc(Result, i);
  Result := Result * Result;
end;

function sumOfSquares (const n: integer): integer;
begin
  Result := (n * (n + 1) * ((2 * n) + 1)) div 6;
end;

function differenceOfSquares(const n: integer): integer;
begin
  Result := squareOfSum(n) - sumOfSquares(n);
end;

end.
