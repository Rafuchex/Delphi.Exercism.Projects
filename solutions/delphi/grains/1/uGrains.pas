{**********************************************}
{                                              }
{  uGrains.pas                                 }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uGrains;

interface

Uses SysUtils;

Type
  ERangeError = Exception;

  Grains = class
    class function Square (const index: integer): UInt64;
    class function Total: UInt64;
  end;

implementation

var
  Chessboard: array[1..64] of UInt64;
  Totals: array[1..64] of UInt64;

procedure InitChessboard;
Var
  i: integer;
  Sum, Qty: UInt64;
Begin
  i := 1;
  Qty := 1;
  Sum := 1;

  while (i <= 64) do
  Begin
    Chessboard[i] := Qty;
    Totals[i] := Sum;

    Inc (i);

    if (i <= 64) then
    Begin
      Qty := Qty * 2;
      Inc (Sum, Qty);
    End;
  End;
End;

class function Grains.Square (const index: integer): UInt64;
begin
  if ((index <= 0) or (index > 64)) then raise ERangeError.Create('Error Message');
  Result := Chessboard[index];
end;

class function Grains.Total: UInt64;
begin
  Result := Totals[64];
end;

initialization
  InitChessboard;

end.
