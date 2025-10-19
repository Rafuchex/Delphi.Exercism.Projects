{**********************************************}
{                                              }
{  uMeetup.pas                                 }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uMeetup;

interface

Uses System.SysUtils, System.DateUtils;

Type
  TWeekDescriptor = (First, Second, Third, Fourth, Last, Teenth);
  TWeekDay = (Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday);

  TMeetup = class
    class function Meetup(year: integer; month: integer; descriptor: TWeekDescriptor; weekday: TWeekDay): string;
  end;

implementation

class function TMeetup.Meetup(year: integer; month: integer; descriptor: TWeekDescriptor; weekday: TWeekDay): string;
var
  CurrentDate: TDateTime;
  targetDay: Word;
  targetIndex: Integer;
  currIndex: Integer;
begin
  CurrentDate := EncodeDate(year, month, 1);
  targetDay := Succ(Ord(weekday));
  targetIndex := Succ(Ord(descriptor));

  if (descriptor = Last) then
  begin
    CurrentDate := DateOf(EndOfTheMonth(CurrentDate));
    while (DayOfWeek(CurrentDate) <> targetDay) do
      CurrentDate := CurrentDate - 1;
  end
  else if (descriptor = Teenth) then
  begin
    CurrentDate := EncodeDate(year, month, 13);
    while ((DayOfWeek(CurrentDate) <> targetDay) and (DayOf(CurrentDate) <= 19)) do
      CurrentDate := CurrentDate + 1;
  end
  else
  begin
    currIndex := 1;
    while (MonthOf(CurrentDate) = month) do
    begin
      if (targetDay = DayOfWeek(CurrentDate)) then
      Begin
        if (currIndex = targetIndex) then break;

        Inc (currIndex);
      End;

      CurrentDate := CurrentDate + 1;
    end;
  end;

  Result := FormatDateTime('yyyy-mm-dd', CurrentDate);
end;

end.
