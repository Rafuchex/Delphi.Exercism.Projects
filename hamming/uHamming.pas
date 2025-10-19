{**********************************************}
{                                              }
{  uHamming.pas                                }
{  Programmed by Rafael Perez Marin            }
{  2025-10-11                                  }
{                                              }
{**********************************************}

unit uHamming;

interface

uses System.SysUtils, System.Classes;

Type
  THamming = class
    class function Distance (S1: string; S2: string): integer;
  end;

implementation

class function THamming.Distance (S1: string; S2: string): integer;
var i: integer;
Begin
  if ((Length(S1) = 0) and (Length(S2) > 0)) then raise EArgumentException.Create('error: left strand must not be empty');
  if ((Length(S1) > 0) and (Length(S2) = 0)) then raise EArgumentException.Create('error: right strand must not be empty');
  if (Length(S1) <> Length(S2)) then raise EArgumentException.Create('error: left and right strands must be of equal length');

  Result := 0;
  for i := 1 to Length(S1) do
    if S1[i] <> S2[i] then
      Inc (Result);
End;

end.

