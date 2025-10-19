unit uResistorColor;

interface

uses SysUtils;

Type
  TResistor = class
    class function colorCode(color: string): integer;
    class function colors: TArray<string>;
  end;

implementation

var
  colorTable: TArray<string>;

class function TResistor.colorCode(color: string): integer;
var i: integer;
begin
  Result := -1;
  for i := Low(colorTable) to High(colorTable) do
    if (colorTable[i] = color) then
    begin
      Result := i;
      Exit;
    end;
end;

class function TResistor.colors: TArray<string>;
begin
  Result := colorTable;
end;

initialization
  colorTable := ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white'];

end.
