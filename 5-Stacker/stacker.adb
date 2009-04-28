--	stacker.adb

--	Chris Corley
--	Assignment 5 - "Stacker"
--	CS390 - Dr. Roden
--	Due Tuesday, April 28, 2009

--	Purpose:

--	Input:

--	Output:

with Ada.Text_IO, Ada.Integer_Text_IO;
with Stacks, Stacks.Essentials;

procedure Stacker is
	use Ada.Text_IO, Ada.Integer_Text_IO;
	use Stacks, Stacks.Essentials;
	type StackItem is
	record
		Name : Character := ' ';
		Item : Stack;
	end record;
	MaxStacks : constant Natural := 5;
	StackList : array (1..MaxStacks) of StackItem;


	procedure Get_Option(X: out Character) is
		subtype CharLen is Integer range 0..1;


		input : String(1..80);
		length : CharLen := 0;
	begin
		Get_Line(input, length);
		X := input(1);
	exception
		when CONSTRAINT_ERROR =>
			Put_Line("[!] Please enter only 1 character.");
			Put("Your selection: ");
			Get_Option(X); -- hopefully they get it right this time.
	end Get_Option;

	procedure createNewStack (S: in out StackItem) is
		input : Character;
	begin
		Put("Enter 1 Character to name the stack: ");
		Get_Option(input);
		if input /= ' ' and input /= '0' then
			S.Name := input;
			Reset(S.Item);
		else
			Put_Line("[!] Cannot use space or 0 as a stack name.");
			createNewStack(S); -- try, try again!
		end if;
	end createNewStack;

	procedure pushValue (S: in out StackItem) is
		input : Integer;
	begin
		Put("Enter the integer to be pushed onto " & S.Name & ": ");
		Get(input);
		Push(S.Item, input);
	end pushValue;

	procedure popValue (S: in out StackItem) is
		output : Integer;
	begin
		Put("The integer popped from " & S.Name & ": ");
		Pop(S.Item, output);
		Put(output);
	exception
		when CONSTRAINT_ERROR =>
			if (IsEmpty(S.Item)) then
				New_Line;
				Put_Line("[!] The stack " & S.Name & " is empty! Cannot pop.");
			end if;
	end popValue;

	procedure emptyCheck (S: in out StackItem) is
	begin
		if (IsEmpty(S.Item)) then
			Put(S.Name & " is empty.");
		else
			Put(S.Name & " is not empty.");
		end if;
	end emptyCheck;

	procedure displaySize (S: in out StackItem) is
	begin
		Put(S.Name & " has" & Integer'Image(StackSize(S.Item)) & " integers.");
	end;


	procedure stackMenu(S: in out StackItem) is
		option : Character := ' ';
	begin
		BossLoop:
		loop
			WorkerLoop:
			loop
				if S.Name /= ' ' then
					New_Line;
					Put_Line("What would you like to do to " & S.Name & "?");
					Put_Line(" 1. Create/Name new stack");
					Put_Line(" 2. Push integer to stack");
					Put_Line(" 3. Pop integer from stack");
					Put_Line(" 4. Check for empty stack");
					Put_Line(" 5. Display stack size");
					Put_Line(" 0. Exit to main menu");
					Put("Your selection number: ");
					begin
						Get_Option(option);
						exit BossLoop when option = '0';
					exception
						when CONSTRAINT_ERROR => exit WorkerLoop;
					end;
					New_Line;
				else
					option := '1'; -- force to name the new stack first
				end if;
				case option is
					when '1' =>
						createNewStack(S);
					when '2' =>
						pushValue(S);
					when '3' =>
						popValue(S);
					when '4' =>
						emptyCheck(S);
					when '5' =>
						displaySize(S);
					when others =>
						Put_Line("[!] Not valid, please enter again.");
				end case;
				option := ' ';
			end loop WorkerLoop;
		end loop BossLoop;
		New_Line;
	end stackMenu;

	procedure listNames is
	begin
		for I in 1..MaxStacks loop
			exit when StackList(I).Name = ' ';
			Put_Line("" & StackList(I).Name);
		end loop;
	end listNames;

	function verifyName (Name : Character) return Integer is
	begin
		for I in 1..MaxStacks loop
			if StackList(I).Name = Name then
				return I;
			end if;
		end loop;
		raise CONSTRAINT_ERROR;
	end verifyName;

	function stackCount return Integer is
		temp : Integer;
	begin
		for I in reverse 1..MaxStacks loop
			temp := I;
			exit when StackList(I).Name = ' ';
		end loop;
		return temp;
	end stackCount;

begin
	BossLoop:
	loop
		WorkerLoop:
		loop
			Put_Line("Which stack would you like to work with today? (0 to exit)");
			Put_Line("Enter a space to use the first unused stack.");
			Put_Line("Available stacks (" & Integer'Image(stackCount) & " free): ");
			listNames;
			New_Line;
			Put("Your selection: ");
			declare
				option : Character;
				SelectedStack : Positive;
			begin
				Get_Option(option); -- this really needs to be a Get_Line
				exit BossLoop when option = '0';
				SelectedStack := verifyName(option);
				New_Line;
				stackMenu(StackList(SelectedStack));
			exception
				when CONSTRAINT_ERROR => exit WorkerLoop;
			end;
		end loop WorkerLoop;
		New_Line(2);
	end loop BossLoop;
end Stacker;
