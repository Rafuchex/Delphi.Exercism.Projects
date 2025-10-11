unit uSpaceAge;

interface

uses System.Math;

type
  TPlanet = (plEarth, plMercury, plVenus, plMars, plJupiter, plSaturn, plUranus, plNeptune);

  ISpaceAge = interface
    function OnEarth: double;
    function OnMercury: double;
    function OnVenus: double;
    function OnMars: double;
    function OnJupiter: double;
    function OnSaturn: double;
    function OnUranus: double;
    function OnNeptune: double;
  end;

  TSpaceAge = class (TInterfacedObject, ISpaceAge)
  private
    FAge: Integer;
    FFactors: Array[TPlanet] of double;
    function GetAgeOnPlanet (planet: TPlanet): double;
  public
    Constructor Create (age: integer);
    function OnEarth: double;
    function OnMercury: double;
    function OnVenus: double;
    function OnMars: double;
    function OnJupiter: double;
    function OnSaturn: double;
    function OnUranus: double;
    function OnNeptune: double;
  end;

function NewSpaceAge (age: integer): ISpaceAge;

implementation

function NewSpaceAge (age: integer): ISpaceAge;
begin
  Result := TSpaceAge.Create(age);
end;

Constructor TSpaceAge.Create (age: integer);
Begin
  FAge := age;

  FillChar(FFactors, SizeOf(FFactors), 0);
  FFactors[plEarth] := 1.0;
  FFactors[plMercury] := 0.2408467;
  FFactors[plVenus] := 0.61519726;
  FFactors[plMars] := 1.8808158;
  FFactors[plJupiter] := 11.862615;
  FFactors[plSaturn] := 29.447498;
  FFactors[plUranus] := 84.016846;
  FFactors[plNeptune] := 164.79132;
End;

function TSpaceAge.GetAgeOnPlanet (planet: TPlanet): double;
Begin
  Result := System.Math.RoundTo((((1.0 * FAge) / 31557600.0) / FFactors[planet]), -2);
End;

function TSpaceAge.OnEarth: double;
Begin
  Result := GetAgeOnPlanet(plEarth);
End;

function TSpaceAge.OnMercury: double;
Begin
  Result := GetAgeOnPlanet(plMercury);
End;

function TSpaceAge.OnVenus: double;
Begin
  Result := GetAgeOnPlanet(plVenus);
End;

function TSpaceAge.OnMars: double;
Begin
  Result := GetAgeOnPlanet(plMars);
End;

function TSpaceAge.OnJupiter: double;
Begin
  Result := GetAgeOnPlanet(plJupiter);
End;

function TSpaceAge.OnSaturn: double;
Begin
  Result := GetAgeOnPlanet(plSaturn);
End;

function TSpaceAge.OnUranus: double;
Begin
  Result := GetAgeOnPlanet(plUranus);
End;

function TSpaceAge.OnNeptune: double;
Begin
  Result := GetAgeOnPlanet(plNeptune);
End;

end.

