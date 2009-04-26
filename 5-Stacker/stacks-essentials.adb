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
		return 0;
	end StackSize;
end Stacks.Essentials;
