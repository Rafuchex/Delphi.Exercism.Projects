{**********************************************}
{                                              }
{  uAcronym.pas                                }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uAcronym;

interface

function abbreviate(const S: string): string;

implementation

function abbreviate(const S: string): string;
var
  buf: string;
  i, len: integer;
  start: boolean;
  Ch: char;
begin
  len := 0;
  start := true;
  SetLength(buf, Length(S));

  for i := 1 to Length(S) do
  begin
    ch := UpCase(S[i]);
    if ((ch >= 'A') and (ch <= 'Z') and start) then
    Begin
      Inc (len);
      buf[len] := ch;
      start := false;
    End
    Else if ((ch = ' ') or (ch = '.') or (ch = '-')) then
    Begin
      start := true;
    End;
  end;

  if (len > 0) then
    Result := Copy(buf, 1, len)
  else
    Result := '';
end;

end.
