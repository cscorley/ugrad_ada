package Stacks.Essentials is
	function IsEmpty(S: Stack) return Boolean;
	function AtTop(S: Stack) return Integer;
	function StackSize(S: Stack) return Integer;
	procedure Reset(S: in out Stack);
end Stacks.Essentials;
