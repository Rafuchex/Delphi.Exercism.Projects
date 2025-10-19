{**********************************************}
{                                              }
{  uRobotName.pas                              }
{  Programmed by Rafael Perez Marin            }
{  2025-10-12                                  }
{                                              }
{**********************************************}

unit uRobotName;

interface

Uses System.Classes, System.SysUtils;

Type
  TRobot = class
  private
    FName: string;
  public
    Constructor Create;
    procedure Reset;
    property Name: string read FName;
  end;

implementation

var
  RobotNames: TStringList;

Constructor TRobot.Create;
begin
  Reset;
end;

procedure TRobot.Reset;
var
  NewName: string;
  index: integer;
begin
  repeat
    { Creates a new robot name. }
    NewName := Char(Ord('A') + Random(26)) +
             Char(Ord('A') + Random(26)) +
             Char(Ord('0') + Random(10)) +
             Char(Ord('0') + Random(10)) +
             Char(Ord('0') + Random(10));

    { Check for duplicates. Recreate name if it already exists. }
  until (not RobotNames.Contains(NewName));

  { Add name to list. }
  RobotNames.Add(NewName);

  if (FName <> '') then
  begin
    { Removes old name from list -- make it available for other robots }
    index := RobotNames.IndexOf(FName);
    RobotNames.Delete(index);
  end;

  { Assign new name. }
  FName := NewName;
end;

initialization
  Randomize;
  RobotNames := TStringList.Create(dupIgnore, True, True);

finalization
  RobotNames.Free;
  RobotNames := nil;

end.
