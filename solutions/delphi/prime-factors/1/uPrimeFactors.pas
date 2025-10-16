{**********************************************}
{                                              }
{  uPrimeFactors.pas                           }
{  Programmed by Rafael Perez Marin            }
{  2025-10-16                                  }
{                                              }
{**********************************************}

unit uPrimeFactors;

interface

uses System.Generics.Collections, System.Math;

Type
  TPrimeFactors = class
    class function factors(const number: Int64): TArray<Int64>;
  end;

implementation

class function TPrimeFactors.factors(const number: Int64): TArray<Int64>;
var
  factors: TList<Int64>;
  n, f, m: Int64;
begin
  factors := TList<Int64>.Create;
  try
    n := number;
    f := 2;
    m := Trunc(Sqrt(n));
    while ((f <= m)) do
    begin
      while (((n mod f) = 0) and (n > 1)) do
      begin
        factors.Add(f);
        n := n div f;
      end;

      inc (f);
    end;

    if (n <> 1) then factors.Add(n);
  finally
    Result := factors.ToArray;
    factors.Free;
  end;
end;

end.
