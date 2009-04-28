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

	ar : array (1..5) of StackItem;
	procedure createNewStack (S: in out StackItem) is
		input : Character;
	begin
		Put("Enter 1 Character to name the stack: ");
		Get(input); -- this really needs to be a Get_Line
		S.Name := input;
		Reset(S.Item);
	exception
		when DATA_ERROR | CONSTRAINT_ERROR =>
			Put_Line("[!] Please enter only 1 character.");
			createNewStack(S); -- hopefully they get it right this time.
	end createNewStack;

	procedure pushValue (S: in out StackItem) is
		input : Integer;
	begin
		Put("Enter the integer to be pushed onto ");
		Put(S.Name);
		Put(": ");
		Get(input);
		Push(S.Item, input);
	end pushValue;

	procedure popValue (S: in out StackItem) is
		output : Integer;
	begin
		Put("The integer popped from ");
		Put(S.Name);
		Put(": ");
		Pop(S.Item, output);
		Put(output);
	end popValue;

	procedure emptyCheck (S: in out StackItem) is
	begin
		if (IsEmpty(S.Item)) then
			Put(S.Name);
			Put(" is empty.");
		else
			Put(S.Name);
			Put(" is not empty.");
		end if;
	end emptyCheck;

	procedure displaySize (S: in out StackItem) is
	begin
		Put(S.Name);
		Put(" has ");
		Put(StackSize(S.Item));
		Put(" integers.");
	end;

	procedure stackMenu(S: in out StackItem) is
		option : Natural := 6;
	begin
		BossLoop:
		loop
			WorkerLoop:
			loop
				New_Line;
				if S.Name /= ' ' then
					Put_Line("What would you like to do to " & S.Name & "?");
					Put_Line(" 1. Create/Name new stack");
					Put_Line(" 2. Push integer to stack");
					Put_Line(" 3. Pop integer from stack");
					Put_Line(" 4. Check for empty stack");
					Put_Line(" 5. Check for full stack");
					Put_Line(" 0. Exit to main menu");
					Put("Your selection number: ");
					begin
						Get(option); -- this really needs to be a Get_Line
						exit BossLoop when option = 0;
					exception
						when CONSTRAINT_ERROR => exit WorkerLoop;
					end;
				else
					option := 1; -- force to name the new stack first
				end if;
				New_Line;
				case option is
					when 1 =>
						createNewStack(S);
					when 2 =>
						pushValue(S);
					when 3 =>
						popValue(S);
					when 4 =>
						emptyCheck(S);
					when 5 =>
						displaySize(S);
					when others =>
						Put("[!] Not a valid option, please enter again.");
				end case;
				option := 6;
			end loop WorkerLoop;
		end loop BossLoop;
	end stackMenu;

	procedure listNames is
	begin
		for I in 1..5 loop
			exit when ar(I).Name = ' ';
			Put_Line("" & ar(I).Name);
		end loop;
	end listNames;

	function verifyName (Name : Character) return Integer is
	begin
		for I in 1..5 loop
			if ar(I).Name = Name then
				return I;
			end if;
		end loop;
		raise CONSTRAINT_ERROR;
	end verifyName;
	option : Character;
	ArPos : Positive;
begin
	BossLoop:
	loop
		WorkerLoop:
		loop
			Put_Line("Which stack would you like to work with today? (0 to exit)");
			Put_Line("Enter a space to use the first unused stack.");
			listNames;
			Put("Your selection: ");
			begin
				Get(option); -- this really needs to be a Get_Line
				exit BossLoop when option = '0';
				ArPos := verifyName(option);
			exception
				when CONSTRAINT_ERROR => exit WorkerLoop;
			end;
			New_Line;
			stackMenu(ar(ArPos));
		end loop WorkerLoop;
	end loop BossLoop;
end Stacker;
