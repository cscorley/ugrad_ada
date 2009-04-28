package body Stacks.Essentials is
	function IsEmpty(S: Stack) return Boolean is
	begin
		return (S = null);
	end IsEmpty;
	function AtTop(S: Stack) return Integer is
	begin
		return S.Value;
	end AtTop;
	function StackSize(S: Stack) return Integer is
		TempS : Stack := S;
		Count : Natural := 0;
	begin
		while (TempS /= null) loop
			Count := Count + 1;
			TempS := Stack(TempS.Next);
		end loop;
		return Count;
	end StackSize;
	procedure Reset(S: in out Stack) is
	begin
		S := null;
	end Reset;
end Stacks.Essentials;
