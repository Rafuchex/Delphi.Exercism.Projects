{**********************************************}
{                                              }
{  uCollatzConjecture.pas                      }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uCollatzConjecture;

interface

Uses System.SysUtils;

Type
  EIllegalNumber = class(Exception)
    Constructor Create (const msg: string);
  end;

function collatzSteps (const n: integer): integer;

implementation

Constructor EIllegalNumber.Create (const msg: string);
Begin
  Inherited;
End;

function collatzSteps (const n: integer): integer;
var
  i: integer;
Begin
  if (n <= 0) then raise EIllegalNumber.Create('error: Only positive numbers are allowed');

  Result := 0;
  i := n;

  while (i > 1) do
  begin
    if (Odd(i)) then
      i := (3 * i) + 1

    else
      i := i div 2;

    Inc (Result);
  end;
End;

end.