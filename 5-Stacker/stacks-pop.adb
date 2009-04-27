separate (Stacks)
procedure Pop(S: in out Stack; X: out Integer) is
begin
	X := S.Value;
	S := Stack(S.Next);
	Length := Length - 1;
end;
