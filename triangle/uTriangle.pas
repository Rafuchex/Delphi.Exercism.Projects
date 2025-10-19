{**********************************************}
{                                              }
{  uTriangle.pas                               }
{  Programmed by Rafael Perez Marin            }
{  2025-10-16                                  }
{                                              }
{**********************************************}

unit uTriangle;

interface

Type
  TTriangleType = (Equilateral, Isosceles, Scalene);

  Triangle = class
    class function Sides (triangleType: TTriangleType; const sideA, sideB, sideC: double): boolean;
  end;

implementation

//
// Max of 3 numbers
//
function Max (const a, b, c: double): double;
begin
  Result := a;
  if (Result < b) then Result := b;
  if (Result < c) then Result := c;
end;

class function Triangle.Sides (triangleType: TTriangleType; const sideA, sideB, sideC: double): boolean;
begin
  Result := (sideA > 0.0) and (sideB > 0.0) and (sideC > 0.0);
  if Result then
  begin
    //
    // Mathematical expression of the constraint on the sides of a triangle
    // https://en.wikipedia.org/wiki/Triangle_inequality
    //
    Result := Max(sideA, sideB, sideC) < ((sideA + sideB + sideC) - Max(sideA, sideB, sideC));

    if Result then
    Begin
      if (triangleType = Equilateral) then
        Result := (sideA = sideB) and (sideB = sideC)

      else if (triangleType = Isosceles) then
        Result := (sideA = sideB) or (sideB = sideC) or (sideA = sideC)

      else
        Result := (sideA <> sideB) and (sideB <> sideC) and (sideA <> sideC);
    End;
  end;
end;

end.
