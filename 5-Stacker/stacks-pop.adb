--	stacks-push.adb

--	The implementation of the Pop procedure

separate (Stacks)
procedure Pop(S: in out Stack; X: out Integer) is
begin
	X := S.Value;
	S := Stack(S.Next);
end;
