{**********************************************}
{                                              }
{  uTournament.pas                             }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uTournament;

interface

uses
  System.Classes, System.Generics.Collections, System.Generics.Defaults,
  System.SysUtils, System.StrUtils;

type
  TTournament = class
    class function Tally(input: array of const): TArray<string>;
  end;

implementation

{
******
Input
******
Allegoric Alaskans;Blithering Badgers;win
Devastating Donkeys;Courageous Californians;draw
Devastating Donkeys;Allegoric Alaskans;win
Courageous Californians;Blithering Badgers;loss
Blithering Badgers;Devastating Donkeys;loss
Allegoric Alaskans;Courageous Californians;win
}

{
******
Output
******
Team                           | MP |  W |  D |  L |  P
Devastating Donkeys            |  3 |  2 |  1 |  0 |  7
Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6
Blithering Badgers             |  3 |  1 |  0 |  2 |  3
Courageous Californians        |  3 |  0 |  1 |  2 |  1
}

{ Output sorted by points (desc), name (asc) }

{ Shell sort implementation }

Type
  TScore = class
    name: string;
    played: integer;
    wins: integer;
    draws: integer;
    losses: integer;
    function Score: integer;
  end;

  TScoreComparer = class(TInterfacedObject, IComparer<TScore>)
    function Compare(const Left, Right: TScore): Integer;
  end;

{ Convert items of (array of const) to string }

function VarRecToStr(AVarRec: TVarRec): string;
const
  Bool: array[Boolean] of string = ('False', 'True');
begin
  case AVarRec.VType of
    vtInteger: Result := IntToStr(AVarRec.VInteger);
    vtBoolean: Result := Bool[AVarRec.VBoolean];
    vtChar: Result := AVarRec.VChar;
    vtExtended: Result := FloatToStr(AVarRec.VExtended^);
    vtString: Result := AVarRec.VString^; // For ShortString
    vtPChar: Result := AVarRec.VPChar;
    vtObject: Result := AVarRec.VObject.ClassName;
    vtClass: Result := AVarRec.VClass.ClassName;
    vtAnsiString: Result := string(AVarRec.VAnsiString);
    vtCurrency: Result := CurrToStr(AVarRec.VCurrency^);
    vtVariant: Result := string(AVarRec.VVariant^);
    vtWideString: Result := WideString(AVarRec.VWideString);
    vtInt64: Result := IntToStr(AVarRec.VInt64^);
    vtUnicodeString: Result := UnicodeString(AVarRec.VUnicodeString);
    else
      Result := ''; // Handle unknown or unhandled types
  end;
end;

{************* TScore ************}

function TScore.Score: integer;
begin
  Result := (wins * 3) + draws;
end;

{************* TScoreComparer ************}

function TScoreComparer.Compare(const Left, Right: TScore): Integer;
begin
  if (Left.Score < Right.Score) then
    Result := 1
  else if (Left.Score > Right.Score) then
    Result := -1
  else
    Result := CompareStr(Left.Name, Right.Name);
end;

{************* TTournament ************}

class function TTournament.Tally(input: array of const): TArray<string>;
var
  teamList: TDictionary<string,TScore>;
  scoreList: TObjectList<TScore>;
  fields: TArray<string>;
  s: string;
  aIdx, bIdx, i, j: integer;
  scoreA, scoreB: TScore;
  teamName: string;
begin
  teamList := TDictionary<string,TScore>.Create;
  scoreList := TObjectList<TScore>.Create(TScoreComparer.Create, true);
  try
    for i := Low(input) to High(input) do
    Begin
      S := VarRecToStr(input[i]);
      if (Pos(';', S) > 0) then
      begin
        fields := SplitString(S, ';');
        if (Length(fields) >= 2) then
        begin
          if (not teamList.ContainsKey(fields[0])) then
          begin
            teamName := fields[0];
            teamList.Add(teamName, TScore.Create);
            scoreList.Add(teamList[teamName]);
            teamList[teamName].Name := teamName;
          end;
          if (not teamList.ContainsKey(fields[1])) then
          begin
            teamName := fields[1];
            teamList.Add(teamName, TScore.Create);
            scoreList.Add(teamList[teamName]);
            teamList[teamName].Name := teamName;
          end;
        end;
      end;
    End;

    for i := Low(input) to High(input) do
    Begin
      S := VarRecToStr(input[i]);
      if (Pos(';', S) > 0) then
      begin
        fields := SplitString(S, ';');
        if (Length(fields) >= 2) then
        begin
          scoreA := teamList[fields[0]];
          scoreB := teamList[fields[1]];

          Inc(scoreA.played);
          Inc(scoreB.played);

          If (LowerCase(fields[2]) = 'win') then
          Begin
            Inc(scoreA.wins);
            Inc(scoreB.losses);
          End
          Else If (LowerCase(fields[2]) = 'loss') then
          Begin
            Inc(scoreB.wins);
            Inc(scoreA.losses);
          End
          Else If (LowerCase(fields[2]) = 'draw') then
          Begin
            Inc(scoreA.draws);
            Inc(scoreB.draws);
          End;
        end;
      end;
    End;

    scoreList.Sort;

    SetLength (Result, scoreList.Count + 1);
    Result[0] := 'Team                           | MP |  W |  D |  L |  P';

    for i := 0 to Pred(scoreList.Count) do
      Result[Succ(i)] := Format('%-30s | %2d | %2d | %2d | %2d | %2d',
        [scoreList[i].name,
         scoreList[i].played,
         scoreList[i].wins,
         scoreList[i].draws,
         scoreList[i].losses,
         scoreList[i].Score]);
  finally
    scoreList.Free;
    teamList.Free;
  end;
end;

end.
