--	stacker.adb

--	Chris Corley
--	Assignment 5 - "Stacker"
--	CS390 - Dr. Roden
--	Due Tuesday, April 28, 2009

--	Purpose:  Utilizes the Stacks package, allowing the user to perform various operations
--	on up to 5 different stacks which the user has named.


with Ada.Text_IO, Ada.Integer_Text_IO;
with Stacks, Stacks.Essentials;

procedure Stacker is
	use Ada.Text_IO, Ada.Integer_Text_IO;
	use Stacks, Stacks.Essentials;

	MaxStacks : constant Natural := 5;

	-- Our named stacks will be handled by an array of records
	type StackItem is
	record
		Name : Character := ' ';
		Item : Stack;
	end record;
	StackList : array (1..MaxStacks) of StackItem;

	-- Get_Option simply grabs 1 character at a time from the input line, and if it raises
	--	a constraint_error it will call itself again to refetch input.
	-- Input: Character type
	-- Output: Stores the read character into the parameter passed, and will only print to screen
	--	upon error.
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


	-- stackMenu helper procedures

	-- createNewStack is to get from user the StackItem's name, and to reset the stack to a new
	--	blank (null) stack.  Since space and 0 are used for navigating elsewhere, names of
	--	those two characters is disallowed.
	-- Input: StackItem type
	-- Output: Modified StackItem parameter with new name and a blank stack
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

	-- pushValue utilizes the Stack packages Push procedure and pushes a read value to the stack.
	-- Input: StackItem type
	-- Output: Modified StackItem parameter with the pushed item.
	procedure pushValue (S: in out StackItem) is
		input :  String (1..80) := (others => ' ');
		length : Natural; -- really only here to satisfy the Get_Line call..
	begin
		Put("Enter the integer to be pushed onto " & S.Name & ": ");
		-- This removes everything from the input buffer
		Get_Line(input,length);
		-- and this will raise an exception if what was in that buffer is bad.
		Push(S.Item, Integer'Value(input));
	exception
		when DATA_ERROR | CONSTRAINT_ERROR =>
			Put_Line("[!] Only integers can be pushed onto the stack.");
			New_Line;
			pushValue(S);
	end pushValue;









	-- popValue utilizes the Stack packages Pop procedure and pops a value from the stack and
	--	prints it to screen.  This proceure relies on the Stacks.Essentials child package
	--	to check for an empty stack on error.
	-- Input: StackItem type
	-- Output: Modified StackItem parameter without the popped item. Prints to screen the value.
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

	-- emptyCheck relies on the Stacks.Essentials package to check if the stack is empty.
	-- Input: StackItem type
	-- Output: Prints to screen if the stack is empty.
	procedure emptyCheck (S: in StackItem) is
	begin
		if (IsEmpty(S.Item)) then
			Put(S.Name & " is empty.");
		else
			Put(S.Name & " is not empty.");
		end if;
	end emptyCheck;

	-- displaySize relies on the Stacks.Essentials package to output the number of items in the
	--	given stack
	-- Input: StackItem type
	-- Output: Prints to screen the size of the stack.
	procedure displaySize (S: in StackItem) is
	begin
		Put(S.Name & " has" & Integer'Image(StackSize(S.Item)) & " integers.");
	end;









	-- stackMenu is our main interface with the user, and calls all of the above helper procedures
	--	when a user selects an option from here.  Note, this must remain 'in out' due to
	--	helper functions needing to modify the StackItem
	-- Input: StackItem type
	-- Output: Prints the screen a basic menu for stack operations.
	procedure stackMenu(S: in out StackItem) is
		option : Character := ' ';
	begin
		BossLoop:
		loop
			WorkerLoop:
			loop
				New_Line;
				Put_Line("[*] Stacker - Stack Operation");
				if S.Name /= ' ' then
					Put_Line("What would you like to do to " & S.Name & "?");
					Put_Line(" 1. Replace stack with a new stack");
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
						-- this will cause us to simply 'skip' the rest of the
						--\loop if any mishaps occur.
					end;
					New_Line;
				else
					option := '1'; -- force to name the new stack first
				end if;
				case option is
					when '1' => createNewStack(S);
					when '2' => pushValue(S);
					when '3' => popValue(S);
					when '4' => emptyCheck(S);
					when '5' => displaySize(S);
					when others => Put_Line("[!] Not valid, please enter again.");
				end case;
				option := ' ';
			end loop WorkerLoop;
		end loop BossLoop;
		New_Line;
	end stackMenu;

	-- Main Stacker helper procedures

	-- listNames helps our main Stacker procedure by printing out the list of names until we
	--	reach a blank stack (denoted by having a space for the Name).
	-- Input: <none>
	-- Output: Prints to screen the Names of stacks
	procedure listNames is
	begin
		for I in 1..MaxStacks loop
			exit when StackList(I).Name = ' ';
			Put_Line("" & StackList(I).Name);
		end loop;
	end listNames;

	-- verifyName helps our main Stacker procedure by returning the position in our array the
	--	stack name given is located.  If it cannot be found, it raises a DATA_ERROR.
	-- Input: Character name value
	-- Output: <none>
	-- Return: Integer position of stack in array
	function verifyName (Name : Character) return Integer is
	begin
		for I in 1..MaxStacks loop
			if StackList(I).Name = Name then
				return I;
			end if;
		end loop;
		raise DATA_ERROR;
	end verifyName;

	-- freeStackCount helps our main Stacker procedure by returning the number of free (empty)
	--	stacks in the array.
	-- Input: <none>
	-- Output: <none>
	-- Return: Integer count of free stacks in array
	function freeStackCount return Integer is
		temp : Integer := MaxStacks;
	begin
		for I in 1..MaxStacks loop
			exit when StackList(I).Name = ' ';
			temp := temp - 1;
		end loop;
		return temp;
	end freeStackCount;




begin -- Stacker
	BossLoop:
	loop
		WorkerLoop:
		loop
			Put_Line("[*] Stacker - Main");
		if freeStackCount = MaxStacks then
			New_Line;
			Put_Line("No previous stacks found, proceeding to create new stack...");
			stackMenu(StackList(1));
		else
			Put_Line("Which stack would you like to work with today? (0 to exit)");
			Put_Line("Enter a space to use the first unused stack.");
			Put_Line("Available stacks (" & Integer'Image(freeStackCount) & " free): ");
			listNames;
			New_Line;
			Put("Your selection: ");
			declare
				option : Character;
				SelectedStack : Positive;
			begin
				Get_Option(option);
				exit BossLoop when option = '0';
				SelectedStack := verifyName(option);
				New_Line;
				stackMenu(StackList(SelectedStack));
			exception
				when CONSTRAINT_ERROR | DATA_ERROR => exit WorkerLoop;
			end;
		end if;
		end loop WorkerLoop;
		New_Line(2);
	end loop BossLoop;
end Stacker;
