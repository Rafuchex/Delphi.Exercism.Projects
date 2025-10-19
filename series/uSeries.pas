{**********************************************}
{                                              }
{  uSeries.pas                                 }
{  Programmed by Rafael Perez Marin            }
{  2025-10-15                                  }
{                                              }
{**********************************************}

unit uSeries;

interface

Type
  TSlice = class
  private
    FStr: string;
  public
    Constructor Create(const S: string);
    function Slices(const n: integer): TArray<string>;
  end;

implementation

uses SysUtils;

Constructor TSlice.Create(const S: string);
Begin
  FStr := S;
End;

function TSlice.Slices(const n: integer): TArray<string>;
var i: integer;
begin
  if (FStr = '') then
    raise EArgumentException.Create('series cannot be empty')

  else if (n = 0) then
    raise EArgumentOutOfRangeException.Create('slice length cannot be zero')

  else if (n < 0) then
    raise EArgumentOutOfRangeException.Create('slice length cannot be negative')

  else if (n > Length(FStr)) then
    raise EArgumentOutOfRangeException.Create('slice length cannot be greater than series length')

  else
  Begin
    SetLength(Result, Length(FStr) - n + 1);
    For i := 1 to (Length(FStr) - n + 1) do
      Result[Pred(i)] := Copy(FStr, i, n);
  End;
end;

end.

