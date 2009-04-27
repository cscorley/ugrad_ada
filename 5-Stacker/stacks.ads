package Stacks is
	type Stack is limited private;
	procedure Push(S: in out Stack; X: in Integer);
	procedure Pop(S: in out Stack; X: out Integer);

private
	type Cell is
	record
		Next: access Cell;
		Value: Integer;
	end record;
	type Stack is access all Cell;
	Length : Integer := 0;
end;
