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
    Destructor Destroy; override;
    procedure Clear;
    function Read: T;
    procedure Write (data: T);
    procedure OverWrite (data: T);
    function Count: integer;
    function IsFull: boolean;
    function IsEmpty: boolean;
  end;

implementation

Constructor TCircularBuffer<T>.Create (size: integer);
Begin
  SetLength(FBuffer, size);
  FHead := Low(FBuffer);
  FTail := Low(FBuffer);
  FWriteCount := 0;
End;

Destructor TCircularBuffer<T>.Destroy;
Begin
  Clear;
  SetLength(FBuffer, 0);
  Inherited;
End;

procedure TCircularBuffer<T>.Clear;
begin
  FHead := Low(FBuffer);
  FTail := Low(FBuffer);
  FWriteCount := 0;
end;

function TCircularBuffer<T>.Read: T;
begin
  if (IsEmpty) then
    raise EInvalidOpException.Create('Circular buffer is empty.');

  Result := FBuffer[FHead];

  inc(FHead);
  if (FHead > High(FBuffer)) then FHead := Low(FBuffer);

  Dec(FWriteCount);
end;

procedure TCircularBuffer<T>.Write (data: T);
begin
  if (IsFull) then
    raise EInvalidOpException.Create('Circular buffer is full.');

  FBuffer[FTail] := data;

  inc(FTail);
  if (FTail > High(FBuffer)) then FTail := Low(FBuffer);

  Inc(FWriteCount);
end;

procedure TCircularBuffer<T>.OverWrite (data: T);
begin
  if (IsFull) then
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

function TCircularBuffer<T>.IsFull: boolean;
begin
  Result := ((FTail = FHead) and (FWriteCount > 0));
end;

function TCircularBuffer<T>.IsEmpty: boolean;
Begin
  Result := (Count = 0) and (FWriteCount = 0);
End;

end.

