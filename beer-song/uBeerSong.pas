{**********************************************}
{                                              }
{  uBeerSong.pas                               }
{  Programmed by Rafael Perez Marin            }
{  2025-10-17                                  }
{                                              }
{**********************************************}

unit uBeerSong;

interface

Type
  Beer = class
    class function Recite(const startBottles, takeDown: integer): string;
  end;

implementation

uses SysUtils;

class function Beer.Recite(const startBottles, takeDown: integer): string;
var
  pending: integer;
  current: integer;
begin
  Result := '';
  pending := takeDown;
  current := startBottles;

  while (pending > 0) do
  begin
    if (Result <> '') then
      Result := Result + '\n';

    if (current > 1) then
      Result := Result + Format('%d bottles of beer on the wall, %d bottles of beer.\nTake one down and pass it around, ', [current, current])

    else if (current = 1) then
      Result := Result + '1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, '

    else if (current = 0) then
    begin
      Result := Result + 'No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n';
      Exit;
    end;

    Dec (current);
    if (current > 1) then
      Result := Result + Format('%d bottles of beer on the wall.', [current])

    else if (current = 1) then
      Result := Result + '1 bottle of beer on the wall.'

    else if (current = 0) then
      Result := Result + 'no more bottles of beer on the wall.';

    Result := Result + '\n';
    Dec (pending);
  end;
end;

end.