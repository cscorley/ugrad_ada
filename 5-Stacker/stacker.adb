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

	procedure stackMenu(S: in out StackItem) is
		option : Natural := 12;
	begin
		BossLoop:
		loop
			WorkerLoop:
			loop
				New_Line;
				Put("What would you like to do to");
				Put(S.Name);
				Put_Line("? (0 to exit)");
				Put_Line(" 1. Create new stack");
				Put_Line(" 2. Push integer to stack");
				Put_Line(" 3. Pop integer from stack");
				Put_Line(" 4. Check for empty stack");
				Put_Line(" 5. Check for full stack");
				Put("Your selection number: ");
				begin
					Get(option);
				exception
					when CONSTRAINT_ERROR => exit WorkerLoop;
				end;
				exit BossLoop when option = 0;
				New_Line;
				case option is
					when 1 =>
						declare
							input : Character;
						begin
							Put("Enter 1 Character to name the stack: ");
							Get(input);
							-- failure
							S.Name := input;
							Reset(S.Item);
						end;
					when 2 =>
						declare
							input : Integer;
						begin
							Put("Enter the integer to be pushed onto ");
							Put(S.Name);
							Put(": ");
							Get(input);
							Push(S.Item, input);
						end;
					when 3 =>
						declare
							output : Integer;
						begin
							Put("The integer popped from");
							Put(S.Name);
							Put(": ");
							Pop(S.Item, output);
							Put(output);
						end;
					when 4 =>
						if (IsEmpty(S.Item)) then
							Put(S.Name);
							Put(" is empty.");
						else
							Put(S.Name);
							Put(" is not empty.");
						end if;
					when 5 =>
						Put(S.Name);
						Put(" has ");
						Put(StackSize(S.Item));
						Put(" integers.");
					when others =>
						Put("Not a valid option, please enter again.");
				end case;
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

	option : Character;
begin
	BossLoop:
	loop
		WorkerLoop:
		loop
			Put_Line("Which stack would you like to work with today? (0 to exit)");
			listNames;
			Put("Your selection: ");
			declare
				input : String(1..80);
				length : Natural;
			begin
				Get_Line(input, length);
				option := input(1);
			exception
			-- dont need
				when CONSTRAINT_ERROR => exit WorkerLoop;
			end;
			exit BossLoop when option = '0';
			New_Line; Put("POO");
		end loop WorkerLoop;
	end loop BossLoop;
end Stacker;
