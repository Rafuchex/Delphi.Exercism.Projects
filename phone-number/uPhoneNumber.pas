{**********************************************}
{                                              }
{  uPhoneNumber.pas                            }
{  Programmed by Rafael Perez Marin            }
{  2025-10-14                                  }
{                                              }
{**********************************************}

unit uPhoneNumber;

interface

Type
  IPhoneNumber = interface
    function Clean: string;
    function Area: string;
    function Exchange: string;
    function ToString: string;
  end;

  TPhoneNumber = class (TInterfacedObject, IPhoneNumber)
  private
    FNumber, FArea, FExchange: string;
  public
    constructor Create (number: string);
    function Clean: string;
    function Area: string;
    function Exchange: string;
    function ToString: string;
  end;

function NewPhoneNumber (const number: string): IPhoneNumber;

implementation

function NewPhoneNumber (const number: string): IPhoneNumber;
Begin
  Result := TPhoneNumber.Create(number);
End;

constructor TPhoneNumber.Create (number: string);
Begin
  FNumber := number;
End;

function TPhoneNumber.Clean: string;
var
  buf: string;
  i, len: integer;
  valid: boolean;
begin
  Result := '';
  if (Length(FNumber) > 0) then
  Begin
    len := 0;
    SetLength (buf, Length(FNumber));

    for i := 1 to Length(FNumber) do
      if ((FNumber[i] >= '0') and (FNumber[i] <= '9')) then
      Begin
        Inc (len);
        buf[len] := FNumber[i];
      End;

    if ((len >= 10) and (len <= 11)) then
    Begin
      buf := Copy(buf, 1, len);

      if (len = 11) then
      Begin
        valid := (buf[1] = '1') and (buf[2] >= '2') and (buf[5] >= '2');
        if (valid) then Result := Copy(buf, 2, Length(buf) - 1);
      End
      Else if (len = 10) then
      Begin
        valid := (buf[1] >= '2') and (buf[4] >= '2');
        if (valid) then Result := buf;
      End;
    End;
  End;
end;

function TPhoneNumber.Area: string;
Begin
  Result := Clean;
  if (Length(Result) = 10) then
    Result := Copy(Result, 1, 3)
  Else
    Result := '';
End;

function TPhoneNumber.Exchange: string;
Begin
  Result := Clean;
  if (Length(Result) = 10) then
    Result := Copy(Result, 4, 3)
  Else
    Result := '';
End;

function TPhoneNumber.ToString: string;
var
  Temp: String;
  i, j: integer;
begin
  Result := '';
  Temp := Clean;
  if (Length(Temp) = 10) then
  Begin
    i := 1;
    j := 1;
    Result := '(XXX) XXX-XXXX';
    while (true) do
    Begin
      while (Result[i] <> 'X') do
      Begin
        Inc (i);
        if (i > Length(Result)) then Exit;
      End;

      If (i <= Length(Result)) then
      Begin
        Result[i] := Temp[j];
        Inc (i);
        Inc (j);
        if (i > Length(Result)) then Exit;
        if (j > Length(Temp)) then Exit;
      End
      Else
        Exit;
    End;
  End;
end;

end.

