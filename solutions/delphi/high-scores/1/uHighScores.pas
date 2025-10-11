{**********************************************}
{                                              }
{  uHighScores.pas                             }
{  Programmed by Rafael Perez Marin            }
{  2025-10-11                                  }
{                                              }
{**********************************************}

unit uHighScores;

interface

uses System.SysUtils, System.Math, System.Generics.Collections;

Type
  IScores = interface
    function Scores: TList<integer>;
    function Highest: integer;
    function Latest: integer;
    function personalTopThree: TList<integer>;
    function Report: string;
  end;

  TScores = class (TInterfacedObject, IScores)
  private
    FScores: TArray<integer>;
  public
    Constructor Create (scores: TArray<integer>);
    function Scores: TList<integer>;
    function Highest: integer;
    function Latest: integer;
    function personalTopThree: TList<integer>;
    function Report: string;
  end;

function NewScores (scores: TArray<integer>): IScores;

implementation

function NewScores (scores: TArray<integer>): IScores;
begin
  Result := TScores.Create(scores);
end;

Constructor TScores.Create (scores: TArray<integer>);
Begin
  FScores := scores;
End;

function TScores.Scores: TList<integer>;
Begin
  Result := TList<integer>.Create(FScores);
End;

function TScores.Highest: integer;
var i: integer;
Begin
  Result := Low(integer);
  for I := Low(FScores) to High(FScores) do
    if (Result < FScores[i]) then
      Result := FScores[i];
End;

function TScores.Latest: integer;
Begin
  Result := FScores[High(FScores)];
End;

function TScores.personalTopThree: TList<integer>;
begin
  Result := TList<integer>.Create();
  Result.AddRange(FScores);
  Result.Sort();

  if (Result.Count > 3) then
    Result.DeleteRange(0, Result.Count - 3);

  Result.Reverse();
end;

function TScores.Report: string;
var
  msg: string;
  lastScore: integer;
  highScore: integer;
begin
  lastScore := Latest;
  highScore := Highest;
  if highScore > lastScore then
    msg := 'Your latest score was %d. That''s %d short of your personal best!'
  else
    msg := 'Your latest score was %d. That''s your personal best!';
  Result := Format(msg, [lastScore, highScore - lastScore]);
end;

end.
