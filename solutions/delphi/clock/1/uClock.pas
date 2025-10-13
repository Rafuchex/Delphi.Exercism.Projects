{**********************************************}
{                                              }
{  uClock.pas                                  }
{  Programmed by Rafael Perez Marin            }
{  2025-10-13                                  }
{                                              }
{**********************************************}

unit uClock;

interface

uses System.SysUtils, System.DateUtils;

Type
  Clock = Class(TInterfacedObject)
  Private
    FTime: TDateTime;
  Public
    Property Time: TDateTime read FTime;
    class function SetHands (hours: integer): Clock; overload;
    class function SetHands (hours: integer; minutes: integer): Clock; overload;
    Constructor Create (hours: integer; minutes: integer);
    function Add (minutes: integer): Clock;
    function Subtract (minutes: integer): Clock;
    Function ToString: string;
    Function Equal (Value: Clock): Boolean;
  end;

implementation

Constructor Clock.Create (hours: integer; minutes: integer);
Var Temp: TDateTime;
Begin
  Temp := (IncHour(IncMinute(0, minutes), hours));
  FTime := (IncHour(IncMinute(0, MinuteOf(Temp)), HourOf(Temp)));
End;

class function Clock.SetHands (hours: integer): Clock;
begin
  Result := Clock.Create(hours, 0);
end;

class function Clock.SetHands (hours: integer; minutes: integer): Clock;
begin
  Result := Clock.Create(hours, minutes);
end;

Function Clock.ToString: string;
begin
  Result := FormatDateTime('hh:nn', Time);
end;

function Clock.Add (minutes: integer): Clock;
Var Temp: TDateTime;
begin
  Temp := (System.DateUtils.IncMinute(Time, minutes));
  FTime := (IncHour(IncMinute(0, MinuteOf(Temp)), HourOf(Temp)));
  Result := Self;
end;

function Clock.Subtract (minutes: integer): Clock;
Var Temp: TDateTime;
begin
  Temp := (System.DateUtils.IncMinute(Time, -minutes));
  FTime := (IncHour(IncMinute(0, MinuteOf(Temp)), HourOf(Temp)));
  Result := Self;
end;

Function Clock.Equal (Value: Clock): Boolean;
Begin
  If (Value = nil) Then
    Result := false

  Else
  Begin
    Result := (Frac(Value.FTime) = Frac(FTime));
  End;
End;

end.
