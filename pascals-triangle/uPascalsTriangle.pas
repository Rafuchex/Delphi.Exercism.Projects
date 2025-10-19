{**********************************************}
{                                              }
{  uPascalsTriangle.pas                        }
{  Programmed by Rafael Perez Marin            }
{  2025-10-16                                  }
{                                              }
{**********************************************}

unit uPascalsTriangle;

interface

Type
  PascalsTriangle = class
    class function Calculate (const rows: integer): TArray<TArray<integer>>;
  end;

implementation

class function PascalsTriangle.Calculate (const rows: integer): TArray<TArray<integer>>;
var i, j, k: integer;
begin
  SetLength (Result, rows);

  for i := 0 to Pred(rows) do
  begin
    if (i = 0) then
      Result[i] := [1]

    else
    Begin
      SetLength (Result[i], Succ(i));
      Result[i][0] := 1;
      Result[i][i] := 1;

      j := 1;
      while (j < i) do
      Begin
        Result[i][j] := Result[Pred(i)][j] + Result[Pred(i)][j - 1];
        Inc (j);
      End;
    End;
  end;
end;

end.
