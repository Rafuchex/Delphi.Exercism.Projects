{**********************************************}
{                                              }
{  uCircularBuffer.pas                         }
{  Programmed by Rafael Perez Marin            }
{  2025-10-12                                  }
{                                              }
{**********************************************}

unit uCircularBuffer;

interface

Uses System.SysUtils, System.Generics.Collections;

Type
  ICircularBuffer<T> = interface
    procedure Clear;
    function Read: T;
    procedure Write (data: T);
    procedure OverWrite (data: T);
    function Count: integer;
  end;

  TCircularBuffer<T> = class (TInterfacedObject, ICircularBuffer<T>)
  private
    FBuffer: TArray<T>;
    FHead: Integer;
    FTail: Integer;
    FWriteCount: integer;
  public
    Constructor Create (size: integer);
    procedure Clear;
    function Read: T;
    procedure Write (data: T);
    procedure OverWrite (data: T);
    function Count: integer;
  end;

implementation

Constructor TCircularBuffer<T>.Create (size: integer);
Begin
  SetLength(FBuffer, size);
  FHead := Low(FBuffer);
  FTail := Low(FBuffer);
  FWriteCount := 0;
End;

procedure TCircularBuffer<T>.Clear;
begin
  FHead := Low(FBuffer);
  FTail := Low(FBuffer);
  FWriteCount := 0;
end;

function TCircularBuffer<T>.Read: T;
begin
  if ((Count = 0) and (FWriteCount = 0)) then
    raise EInvalidOpException.Create('Circular buffer is empty.');

  Result := FBuffer[FHead];

  inc(FHead);
  if (FHead > High(FBuffer)) then FHead := Low(FBuffer);

  Dec(FWriteCount);
end;

procedure TCircularBuffer<T>.Write (data: T);
begin
  if ((FTail = FHead) and (FWriteCount > 0)) then
    raise EInvalidOpException.Create('Circular buffer is full.');

  FBuffer[FTail] := data;

  inc(FTail);
  if (FTail > High(FBuffer)) then FTail := Low(FBuffer);

  Inc(FWriteCount);
end;

procedure TCircularBuffer<T>.OverWrite (data: T);
begin
  if ((FTail = FHead) and (FWriteCount > 0)) then
  begin
    FBuffer[FTail] := data;

    inc(FTail);
    if (FTail > High(FBuffer)) then FTail := Low(FBuffer);

    inc(FHead);
    if (FHead > High(FBuffer)) then FHead := Low(FBuffer);
  end
  else
    Write (data);
end;

function TCircularBuffer<T>.Count: integer;
Begin
  if (FHead <= FTail) then
    Result := FTail - FHead
  else
    Result := Length(FBuffer) - (FHead - FTail);
End;

end.

