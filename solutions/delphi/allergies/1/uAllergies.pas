{**********************************************}
{                                              }
{  uAllergies.pas                              }
{  Programmed by Rafael Perez Marin            }
{  2025-10-12                                  }
{                                              }
{**********************************************}

unit uAllergies;

interface

uses System.SysUtils, System.Generics.Collections, System.Classes;

Type
  IAllergies = interface
    function AllergicTo (id: string): boolean;
    function List: TList<string>;
  end;

  TAllergies = class (TInterfacedObject, IAllergies)
  private
    FScore: integer;
    FList: TList<string>;
  public
    Constructor Create (score: integer);
    Destructor Destroy; override;
    function AllergicTo (id: string): boolean;
    function List: TList<string>;
  end;

implementation

Constructor TAllergies.Create (score: integer);
var
  ids: TArray<string>;
  idx, i: integer;
begin
  FScore := score;
  FList := TList<string>.Create;
  ids := ['eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'];
  for i := Low(ids) to High(ids) do
  begin
    idx := 1 shl i;
    if ((score and idx) <> 0) then
      FList.Add(ids[i]);
  end;
end;

Destructor TAllergies.Destroy;
begin
  FList.Free;

  Inherited;
end;

function TAllergies.AllergicTo (id: string): boolean;
begin
  Result := FList.Contains(id);
end;

function TAllergies.List: TList<string>;
begin
  Result := FList;
end;

end.
