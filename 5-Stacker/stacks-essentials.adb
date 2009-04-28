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
	begin
		return Length;
	end StackSize;
	procedure Reset(S: in out Stack) is
	begin
		S := null;
		Length := 0;
	end Reset;
end Stacks.Essentials;
