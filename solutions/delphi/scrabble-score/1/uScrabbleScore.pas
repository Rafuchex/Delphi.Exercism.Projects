{**********************************************}
{                                              }
{  uScrabbleScore.pas                          }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uScrabbleScore;

interface

Type
  TScrabble = class
    class function Score (const S: string): integer;
  end;

implementation

Uses System.SysUtils;

class function TScrabble.Score (const S: string): integer;
var
  scores: array of integer;
  sets: array of TSysCharSet;
  j, i: integer;
begin
  Result := 0;
  scores := [1, 2, 3, 4, 5, 8, 10];
  sets := [
    ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'],
    ['D', 'G'],
    ['B', 'C', 'M', 'P'],
    ['F', 'H', 'V', 'W', 'Y'],
    ['K'],
    ['J', 'X'],
    ['Q', 'Z']
  ];
  for i := 1 to Length(S) do
    for j := Low(sets) to High(sets) do
    begin
      if (CharInSet(UpCase(S[i]), sets[j])) then
        Inc (Result, scores[j]);
    end;
end;

end.
