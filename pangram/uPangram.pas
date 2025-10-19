{**********************************************}
{                                              }
{  uPangram.pas                                }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uPangram;

interface

function isPangram (const S: string): boolean;

implementation

uses System.Generics.Collections;

function isPangram (const S: string): boolean;
var
  dict: array['A'..'Z'] of integer;
  ch: char;
  i: integer;
begin
  Result := false;

  if (Length(S) > 0) then
  Begin
    FillChar(dict, SizeOf(dict), 0);

    for i := 1 to Length(S) do
    begin
      ch := UpCase(S[i]);
      if ((ch >= 'A') and (ch <= 'Z')) then Inc(dict[ch]);
    end;

    for ch := 'A' to 'Z' do
      if (dict[ch] = 0) then
      Begin
        Result := false;
        Exit;
      End;

    Result := true;
  end;
end;

end.
