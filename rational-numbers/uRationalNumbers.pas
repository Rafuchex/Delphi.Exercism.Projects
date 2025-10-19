{**********************************************}
{                                              }
{  uRationalNumbers.pas                        }
{  Programmed by Rafael Perez Marin            }
{  2025-10-16                                  }
{                                              }
{**********************************************}

unit uRationalNumbers;

interface

Type
  TFraction = record
  private
    FNum, FDenom: Int64;
    class procedure Simplify (var aNum, aDenom: Int64); static;
  public
    constructor Create (const aNum, aDenom: Int64);
    class operator Explicit(a: TFraction): string; overload;
    class operator Explicit(a: TFraction): double; overload;
    class operator Explicit(a: double): TFraction; overload;
    class operator Implicit(a: TFraction): double;
    class operator Negative(a: TFraction) : TFraction;
    class operator Positive(a: TFraction): TFraction;

    class operator Add(a: TFraction; b: TFraction): TFraction;
    class operator Subtract(a: TFraction; b: TFraction) : TFraction;
    class operator Multiply(a: TFraction; b: TFraction) : TFraction;
    class operator Divide(a: TFraction; b: TFraction) : TFraction;

    class operator Add(a: integer; b: TFraction): TFraction;
    class operator Subtract(a: integer; b: TFraction) : TFraction;
    class operator Multiply(a: integer; b: TFraction) : TFraction;
    class operator Divide(a: integer; b: TFraction) : TFraction;

    class operator Add(a: double; b: TFraction): TFraction;
    class operator Subtract(a: double; b: TFraction) : TFraction;
    class operator Multiply(a: double; b: TFraction) : TFraction;
    class operator Divide(a: double; b: TFraction) : TFraction;

    class operator Add(a: TFraction; b: integer): TFraction;
    class operator Subtract(a: TFraction; b: integer) : TFraction;
    class operator Multiply(a: TFraction; b: integer) : TFraction;
    class operator Divide(a: TFraction; b: integer) : TFraction;

    class operator Add(a: TFraction; b: double): TFraction;
    class operator Subtract(a: TFraction; b: double) : TFraction;
    class operator Multiply(a: TFraction; b: double) : TFraction;
    class operator Divide(a: TFraction; b: double) : TFraction;

    class function CreateFrom (const number: double): TFraction; overload; static;
    class function CreateFrom (const aNum, aDenom: Int64): TFraction; overload; static;

    function Reduced: TFraction;
  end;

implementation

Uses SysUtils, Math;

function NumberOfDigits (const number: integer): integer; overload;
var
  limit, n: integer;
begin
  n := number;
  if (n < 0) then n := -1 * n;

  Result := 1;
  limit := 10;
  while ((limit < n) and (Result < 10)) do
  begin
    Inc (Result);
    limit := limit * 10;
  end;
end;

function NumberOfDigits (const number: Int64): integer; overload;
var
  limit, n, i: integer;
begin
  n := number;
  if (n < 0) then n := -1 * n;

  Result := 1;
  limit := 10;
  while ((limit < n) and (Result < 19)) do
  begin
    Inc (Result);
    limit := limit * 10;
  end;
end;

constructor TFraction.Create (const aNum, aDenom: Int64);
begin
  FNum := aNum;
  FDenom := aDenom;
  if (FDenom < 0) then
  begin
    FDenom := -1 * FDenom;
    FNum := -1 * FNum;
  end;

  if (FNum = 0) then
  begin
    FDenom := 1;
  end
  else
    Simplify (FNum, FDenom);
end;

class function TFraction.CreateFrom (const number: double): TFraction;
var
  num, denom: Int64;
  d: double;
  sgn, digits: integer;
begin
  d := Abs(number);
  sgn := Math.Sign(number);
  num := Trunc(d);
  denom := 1;
  digits := NumberOfDigits(num);

  while ((Frac(d) > 0) and (digits < 19)) do
  begin
    d := d * 10.0;
    denom := denom * 10;
  end;
  num := Round(d);

  Result := TFraction.Create(sgn * num, denom);
end;

class function TFraction.CreateFrom (const aNum, aDenom: Int64): TFraction;
begin
  Result := TFraction.Create(aNum, aDenom);
end;

class operator TFraction.Explicit(a: TFraction): string;
begin
  Result := Format('%d/%d', [a.FNum, a.FDenom]);
end;

class operator TFraction.Explicit(a: TFraction): double;
begin
  Result := (1.0 * a.FNum) / (1.0 * a.FDenom);
end;

class operator TFraction.Implicit(a: TFraction): double;
begin
  Result := (1.0 * a.FNum) / (1.0 * a.FDenom);
end;

class operator TFraction.Explicit(a: double): TFraction;
begin
  Result := CreateFrom(a);
end;

class procedure TFraction.Simplify (var aNum, aDenom: Int64);
var
  i, dNum, dDenom: Integer;
begin
  if ((aNum = 0) or (aDenom <= 1)) then Exit;

  if ((aDenom mod aNum) = 0) then
  begin
    aDenom := aDenom div Abs(aNum);
    aNum := Sign(aNum);
    Exit;
  end
  else if ((aNum mod aDenom) = 0) then
  begin
    aNum := aNum div aDenom;
    aDenom := 1;
    Exit;
  end
  else
  begin
    dNum := Trunc(Sqrt(1.0 * Abs(aNum)));
    dDenom := Trunc(Sqrt(1.0 * Abs(aDenom)));

    i := 2;
    while ((i <= dNum) and (i <= dDenom)) do
    begin
      while (((aNum mod i) = 0) and ((aDenom mod i) = 0)) do
      begin
        aNum := aNum div i;
        aDenom := aDenom div i;
      end;
      Inc (i);
    end;
  end;
end;

class operator TFraction.Negative(a: TFraction) : TFraction;
begin
  Result := CreateFrom(-a.FNum, a.FDenom);
end;

class operator TFraction.Positive(a: TFraction): TFraction;
begin
  Result := CreateFrom(a.FNum, a.FDenom);
end;

class operator TFraction.Add(a: TFraction; b: TFraction): TFraction;
begin
  Result := CreateFrom((a.FNum * b.FDenom) + (b.FNum * a.FDenom), (a.FDenom * b.FDenom));
end;

class operator TFraction.Subtract(a: TFraction; b: TFraction) : TFraction;
begin
  Result := CreateFrom((a.FNum * b.FDenom) - (b.FNum * a.FDenom), (a.FDenom * b.FDenom));
end;

class operator TFraction.Multiply(a: TFraction; b: TFraction) : TFraction;
begin
  Result := CreateFrom((a.FNum * b.FNum), (a.FDenom * b.FDenom));
end;

class operator TFraction.Divide(a: TFraction; b: TFraction) : TFraction;
begin
  Result := CreateFrom((a.FNum * b.FDenom), (a.FDenom * b.FNum));
end;

class operator TFraction.Add(a: integer; b: TFraction): TFraction;
Begin
  Result := CreateFrom(a) + b;
End;

class operator TFraction.Subtract(a: integer; b: TFraction) : TFraction;
Begin
  Result := CreateFrom(a) - b;
End;

class operator TFraction.Multiply(a: integer; b: TFraction) : TFraction;
Begin
  Result := CreateFrom(a) * b;
End;

class operator TFraction.Divide(a: integer; b: TFraction) : TFraction;
Begin
  Result := CreateFrom(a) / b;
End;

class operator TFraction.Add(a: double; b: TFraction): TFraction;
Begin
  Result := CreateFrom(a) + b;
End;

class operator TFraction.Subtract(a: double; b: TFraction) : TFraction;
Begin
  Result := CreateFrom(a) - b;
End;

class operator TFraction.Multiply(a: double; b: TFraction) : TFraction;
Begin
  Result := CreateFrom(a) * b;
End;

class operator TFraction.Divide(a: double; b: TFraction) : TFraction;
Begin
  Result := CreateFrom(a) / b;
End;

class operator TFraction.Add(a: TFraction; b: integer): TFraction;
Begin
  Result := a + CreateFrom(b, 1);
End;

class operator TFraction.Subtract(a: TFraction; b: integer) : TFraction;
Begin
  Result := a - CreateFrom(b, 1);
End;

class operator TFraction.Multiply(a: TFraction; b: integer) : TFraction;
Begin
  Result := a * CreateFrom(b, 1);
End;

class operator TFraction.Divide(a: TFraction; b: integer) : TFraction;
Begin
  Result := a / CreateFrom(b, 1);
End;

class operator TFraction.Add(a: TFraction; b: double): TFraction;
Begin
  Result := a + CreateFrom(b);
End;

class operator TFraction.Subtract(a: TFraction; b: double) : TFraction;
Begin
  Result := a - CreateFrom(b);
End;

class operator TFraction.Multiply(a: TFraction; b: double) : TFraction;
Begin
  Result := a * CreateFrom(b);
End;

class operator TFraction.Divide(a: TFraction; b: double) : TFraction;
Begin
  Result := a / CreateFrom(b);
End;

function TFraction.Reduced: TFraction;
var num, denom: Int64;
begin
  num := FNum;
  denom := FDenom;
  Simplify (num, denom);
  Result := CreateFrom(num, denom);
end;

end.
