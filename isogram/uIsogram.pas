{**********************************************}
{                                              }
{  uIsogram.pas                                }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uIsogram;

interface

function isIsogram(S: string): boolean;

implementation

function isIsogram(S: string): boolean;
var
  dict: array['A'..'Z'] of integer;
  ch: char;
  i: integer;
begin
  Result := True;

  if (Length(S) > 0) then
  Begin
    FillChar(dict, SizeOf(dict), 0);
    for i := 1 to Length(S) do
    begin
      ch := UpCase(S[i]);
      if ((ch >= 'A') and (ch <= 'Z')) then
      Begin
        Inc(dict[ch]);
        if (dict[ch] > 1) then
        Begin
          Result := False;
          Exit;
        End;
      End;
    end;
  End;
end;

end.