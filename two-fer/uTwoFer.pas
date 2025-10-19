unit utwofer;

interface

uses SysUtils;

function twoFer: string; overload;
function twoFer (name: string): string; overload;

implementation

function twoFer: string;
begin
  Result := twoFer('you');
end;

function twoFer (name: string): string;
begin
  Result := Format('One for %s, one for me.', [name]);
end;

end.

