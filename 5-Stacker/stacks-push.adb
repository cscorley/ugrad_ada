separate (Stacks)
procedure Push(S: in out Stack; X: in Integer) is
begin
	S:= new Cell'(S,X);
	Length := Length + 1;
end;
