{**********************************************}
{                                              }
{  uBob.pas                                    }
{  Programmed by Rafael Perez Marin            }
{  2025-10-13                                  }
{                                              }
{**********************************************}

unit uBob;

interface

uses SysUtils, DateUtils, StrUtils;

Type
  TBob = class
    class function Response (msg: string): string;
  end;

implementation

class function TBob.Response (msg: string): string;
var
  isYelling, isQuestion, hasLetters, hasNumbers: boolean;
  i: Integer;
Begin
  // Bob answers 'Sure.' if you ask him a question, such as "How are you?".
  // He answers 'Whoa, chill out!' if you YELL AT HIM (in all capitals).
  // He answers 'Calm down, I know what I'm doing!' if you yell a question at him.
  // He says 'Fine. Be that way!' if you address him without actually saying anything.
  // He answers 'Whatever.' to anything else.
  hasLetters := false;
  hasNumbers := false;

  if (Length(Trim(msg)) > 0) then
  Begin
    for i := 1 to Length(msg) do
      if ((UpCase(msg[i]) >= 'A') and (UpCase(msg[i]) <= 'Z')) then
      begin
        hasLetters := true;
        break;
      end;

    for i := 1 to Length(msg) do
      if ((msg[i] >= '0') and (msg[i] <= '9')) then
      begin
        hasNumbers := true;
        break;
      end;
  End;

  isYelling := hasLetters and (msg = UpperCase(msg));
  isQuestion := EndsText('?', Trim(msg));

  if (isYelling and isQuestion) then
    Result := 'Calm down, I know what I''m doing!'

  else if (isYelling) then
    Result := 'Whoa, chill out!'

  else if (isQuestion) then
    Result := 'Sure.'

  else if ((not hasLetters) and (not hasNumbers)) then
    Result := 'Fine. Be that way!'

  else
    Result := 'Whatever.';
End;

end.
