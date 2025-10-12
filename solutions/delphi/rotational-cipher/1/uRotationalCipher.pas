{**********************************************}
{                                              }
{  uRotationalCipher.pas                       }
{  Programmed by Rafael Perez Marin            }
{  2025-10-12                                  }
{                                              }
{**********************************************}

unit uRotationalCipher;

interface

Type
  RotationalCipher = class
    class function rotate(s: string; k: integer): string;
  end;

implementation

class function RotationalCipher.rotate(s: string; k: integer): string;
var
  idx, i: integer;

Begin
  Result := Copy(S, 1, Length(S));
  while (k < 0) do k := 26 + k;

  for i := 1 to Length(S) do
    if ((S[i] >= 'A') and (S[i] <= 'Z')) then
    begin
      idx := Ord(S[i]) - Ord('A');
      idx := (idx + k) mod 26;
      Result[i] := Char(Ord('A') + idx);
    end
    else if ((S[i] >= 'a') and (S[i] <= 'z')) then
    begin
      idx := Ord(S[i]) - Ord('a');
      idx := (idx + k) mod 26;
      Result[i] := Char(Ord('a') + idx);
    end;
End;

end.
