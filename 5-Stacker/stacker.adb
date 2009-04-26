--	stacker.adb

--	Chris Corley
--	Assignment 5 - "Stacker"
--	CS390 - Dr. Roden
--	Due Tuesday, April 28, 2009

--	Purpose:

--	Input:

--	Output:

with Ada.Text_IO, Ada.Integer_Text_IO;
with Stacks;

procedure Stacker is
	use Ada.Text_IO, Ada.Integer_Text_IO;
	procedure stackMenu is
		option : Natural := 12;
	begin
		loop
			New_Line;
			Put_Line("What would you like to do to this stack? (0 to exit)");
			Put_Line(" 1. Create new stack");
			Put_Line(" 2. Push integer to stack");
			Put_Line(" 3. Pop integer from stack");
			Put_Line(" 4. Check for empty stack");
			Put_Line(" 5. Check for full stack");
			Put("Your selection number: ");
			declare
				input : String (1..80) := (others => ' ');
				length : Natural := 0;
			begin
				Get_Line(input, length);
				option := Integer'Value(input);
			end;
			exit when option = 0;
			New_Line;
			case option is
				when 1 => null;
				when 2 => null;
				when 3 => null;
				when 4 => null;
				when 5 => null;
				when others => null;
			end case;
		end loop;
	end stackMenu;


	option : Natural := 12;
	userEntry : String(1..16);
	length : Natural;
begin
	loop
		Put_Line("Which stack would you like to work with today? (0 to exit)");
		Put_Line(" 1. ");
		Put_Line(" 2. ");
		Put_Line(" 3. ");
		Put_Line(" 4. ");
		Put_Line(" 5. ");
		Put("Your selection number: ");
		declare
			input : String (1..80) := (others => ' ');
			length : Natural := 0;
		begin
			Get_Line(input, length);
			option := Integer'Value(input);
		end;
		exit when option = 0;
		New_Line;
		case option is
			when 1 => null;
			when 2 => null;
			when 3 => null;
			when 4 => null;
			when 5 => null;
			when others => null;
		end case;
	end loop;
end Stacker;
