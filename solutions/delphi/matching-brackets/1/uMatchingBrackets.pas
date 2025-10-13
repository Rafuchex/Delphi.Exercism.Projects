{**********************************************}
{                                              }
{  uMatchingBrackets.pas                       }
{  Programmed by Rafael Perez Marin            }
{  2025-10-13                                  }
{                                              }
{**********************************************}

unit uMatchingBrackets;

interface

Type
  TMatchingBrackets = class
    class function IsPaired(msg: string): boolean;
  end;

implementation

Type
  TLinkedListNode<T> = class
    Data: T;
    Next: TLinkedListNode<T>;
    Prev: TLinkedListNode<T>;
  end;

  TLinkedList<T> = class(TInterfacedObject)
  Private
    FHead: TLinkedListNode<T>;
    FTail: TLinkedListNode<T>;
  Public
    Constructor Create;
    Destructor Destroy; override;
    Function First: T;
    Function Last: T;
    Procedure Add (data: T);
    function RemoveLast: boolean;
    function Empty: boolean;
  end;

Constructor TLinkedList<T>.Create;
Begin

End;

Destructor TLinkedList<T>.Destroy;
Begin
  while (RemoveLast) do
  Begin
  End;
End;

Function TLinkedList<T>.First: T;
Begin
  if Empty then
    Result := default(T)
  else
    Result := FHead.Data;
End;

Function TLinkedList<T>.Last: T;
Begin
  if Empty then
    Result := default(T)
  else
    Result := FTail.Data;
End;

Procedure TLinkedList<T>.Add (data: T);
var node: TLinkedListNode<T>;
Begin
  node := TLinkedListNode<T>.Create;
  node.Data := data;

  if Empty then
  Begin
    FHead := node;
    FTail := node;
  End
  Else
  Begin
    node.Prev := FTail;
    FTail.Next := node;
    FTail := node;
  End;
End;

function TLinkedList<T>.RemoveLast: boolean;
var node: TLinkedListNode<T>;
Begin
  Result := false;

  if (FTail <> nil) then
  begin
    node := FTail;
    FTail := node.Prev;

    if (FTail <> nil) then
      FTail.Next := nil
    else
      FHead := nil;

    node.Prev := nil;
    node.Next := nil;
    node.Free;

    Result := true;
  end;
End;

function TLinkedList<T>.Empty: boolean;
begin
  Result := FHead = nil;
end;

class function TMatchingBrackets.IsPaired(msg: string): boolean;
var
  bracketList: TLinkedList<char>;
  i: integer;
begin
  bracketList := TLinkedList<char>.Create;
  Try
    for i := 1 to Length(msg) do
    Begin
      if ((msg[i] = '(') or (msg[i] = '{') or (msg[i] = '[')) then
        bracketList.Add(msg[i])

      else if ((msg[i] = ')') or (msg[i] = '}') or (msg[i] = ']')) then
      Begin
        if not bracketList.Empty then
          if (((bracketList.Last = '(') and (msg[i] = ')')) or
              ((bracketList.Last = '[') and (msg[i] = ']')) or
              ((bracketList.Last = '{') and (msg[i] = '}')))  then
          begin
             bracketList.RemoveLast;
             continue;
          end;

        Result := false;
        Exit;
      End;
    End;

    Result := bracketList.Empty;
  Finally
    bracketList.Free;
  End;
end;

end.
