{**********************************************}
{                                              }
{  uSumOfMultiples.pas                         }
{  Programmed by Rafael Perez Marin            }
{  2025-10-15                                  }
{                                              }
{**********************************************}

unit uSumOfMultiples;

interface

Type
  TMultiplesOf = class
    class function Sum(const n: integer; const factors: array of integer): integer;
  end;

implementation

uses System.Generics.Collections, System.Generics.Defaults;

function MyCustomIntegerComparer(const Left, Right: Integer): Integer;
begin
  if Left > Right then
    Result := 1
  else if Left < Right then
    Result := -1
  else
    Result := 0;
end;

class function TMultiplesOf.Sum(const n: integer; const factors: array of integer): integer;
var
  numSet: TList<integer>;
  i, k: Integer;
begin
  Result := 0;
  if (Length(factors) > 0) Then
  Begin
    numSet := TList<integer>.Create(TDelegatedComparer<integer>.Create(MyCustomIntegerComparer));
    Try
      for i := Low(factors) to High(factors) do
        if (factors[i] > 0) then
        begin
          k := factors[i];
          while (k < n) do
          begin
            if (not numSet.Contains(k)) then
              numSet.Add(k);
            Inc (k, factors[i]);
          end;
        end;

      for i := 0 to Pred(numSet.Count) do
        Inc (Result, numSet[i]);
    Finally
      numSet.Free;
    End;
  End;
end;

end.
