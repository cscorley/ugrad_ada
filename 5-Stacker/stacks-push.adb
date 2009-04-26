separate (Stacks)
procedure Push(S: in out Stack; X: in Integer) is
begin
	S:= new Cell'(S,X);
end;
