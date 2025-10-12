{**********************************************}
{                                              }
{  uGradeSchool.pas                            }
{  Programmed by Rafael Perez Marin            }
{  2025-10-12                                  }
{                                              }
{**********************************************}

unit uGradeSchool;

interface

uses System.Generics.Collections, System.SysUtils, System.Classes;

Type
  TRoster = TList<string>;

  ISchool = interface
    procedure Add (name: string; grade: integer);
    function Roster: TList<string>;
    function Grade (num: integer): TList<string>;
  end;

  TSchool = class (TInterfacedObject, ISchool)
  private
    FStudents: TDictionary<string,integer>;
    FMinGrade, FMaxGrade: integer;
  public
    Constructor Create;
    Destructor Destroy; override;
    procedure Add (name: string; grade: integer);
    function Roster: TList<string>;
    function Grade (num: integer): TList<string>;
  end;

function NewSchool: ISchool;

implementation

function NewSchool: ISchool;
begin
  Result := TSchool.Create;
end;

Constructor TSchool.Create;
begin
  FStudents := TDictionary<string,integer>.Create;
  FMaxGrade := Low(integer);
  FMinGrade := High(integer);
end;

Destructor TSchool.Destroy;
begin
  FStudents.Free;

  Inherited;
end;

procedure TSchool.Add (name: string; grade: integer);
begin
  if (not FStudents.ContainsKey(name)) then
    FStudents.Add(name, grade)
  else
    FStudents[name] := grade;

  if (grade > FMaxGrade) then FMaxGrade := grade;
  if (grade < FMinGrade) then FMinGrade := grade;
end;

function TSchool.Roster: TList<string>;
var
  grade: integer;
  list: TStringList;
  name: string;
begin
  list := TStringList.Create(dupIgnore, true, true);
  Try
    Result := TList<string>.Create;
    for grade := FMinGrade to FMaxGrade do
    Begin
      list.Clear;
      for name in FStudents.Keys do
        if (FStudents[name] = grade) then
          list.Add(name);

      for name in list do
        result.Add(name);
    End;
  Finally
    list.Free;
  End;
end;

function TSchool.Grade (num: integer): TList<string>;
var
  name: string;
  i: integer;
begin
  Result := TList<string>.Create;
  for name in FStudents.Keys do
    if (FStudents[name] = num) then
      Result.Add(name);
end;

end.
