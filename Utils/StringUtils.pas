unit StringUtils;

interface

function StrZero(number, width: Integer): string;

implementation

function StrZero(number, width: Integer): string;
begin
  Str(number, Result);
  while (Length(Result) < width) do
    Insert('0', Result, 1);
end;

end.
