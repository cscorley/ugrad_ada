--	driver.adb

--	Chris Corley
--	Assignment 4 - "Numbers"
--	CS390 - Dr. Roden
--	Due Tuesday, April 7, 2009

--	Purpose:  A basic calculator with various operations upon Complex and Rational numbers.

--	Input:  Accepts as input Complex or Rational numbers.

--	Output:  Prints the results of the selected operation upon the input.

with Complex_Numbers, Rational_Numbers, Ada.Text_IO;

-- Prints a small menu for the user to choose which number type to work with.
procedure Driver is
	use Ada.Text_IO;

	-- Prints the menu and handles interfacing with the Complex_Numbers package.
	procedure doComplex is
		use Complex_Numbers;
		option : Natural := 11;
		Left, Right : Complex;
	begin -- doComplex
		loop
			New_Line;
			Put_Line("Please select your operation for Complex");
			Put_Line(" 1. Set positive (+)");
			Put_Line(" 2. Set negative (-)");
			Put_Line(" 3. Add (+)");
			Put_Line(" 4. Subtract (-)");
			Put_Line(" 5. Multiply (*)");
			Put_Line(" 6. Divide (/)");
			Put_Line(" 7. Equality (=)");
			Put_Line(" 8. Conjugate");
			Put_Line(" 9. Absolute");
			Put_Line("10. Convert to Polar form");
			Put_Line(" 0. Exit program");
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
			Put("Your first operand (a + bi form): ");
			Get_Line(Left);
			case option is
				when 3..7 =>
					New_Line;
					Put("Your second operand (a + bi form): ");
					Get_Line(Right);
				when others => null;
			end case;
			Put("Solution: ");
			case option is
				when 1 => Put_Line(+Left);
				when 2 => Put_Line(-Left);
				when 3 => Put_Line(Left + Right);
				when 4 => Put_Line(Left - Right);
				when 5 => Put_Line(Left * Right);
				when 6 => Put_Line(Left / Right);
				when 7 => if (Left = Right) then
						Put_Line("Equal");
					else
						Put_Line("False");
					end if;
				when 8 => Put_Line(Conjugate(Left));
				when 9 => Put_Line(Float'Image(Absolute(Left)));
				when 10 => Put_Line(ToPolar(Left));
				when others => null;
			end case;
		end loop;
	end doComplex;

	-- Prints the menu and handles interfacing with the Rational_Numbers package.
	procedure doRational is
		use Rational_Numbers;
		option : Natural := 9;
		Left, Right : Rational;
	begin -- doRational
		loop
			New_Line;
			Put_Line("Please select your operation");
			Put_Line("1. Set positive (+)");
			Put_Line("2. Set negative (-)");
			Put_Line("3. Add (+)");
			Put_Line("4. Subtract (-)");
			Put_Line("5. Multiply (*)");
			Put_Line("6. Divide (/)");
			Put_Line("7. Equality (=)");
			Put_Line("8. Reduce");
			Put_Line("0. Exit program");
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
			Put("Your first operand (a/b form): ");
			Get_Line(Left);
			case option is
				when 3..7 =>
					New_Line;
					Put("Your second operand (a/b form): ");
					Get_Line(Right);
				when others => null;
			end case;
			Put("Solution: ");
			case option is
				when 1 => Put_Line(+Left);
				when 2 => Put_Line(-Left);
				when 3 => Put_Line(Left + Right);
				when 4 => Put_Line(Left - Right);
				when 5 => Put_Line(Left * Right);
				when 6 => Put_Line(Left / Right);
				when 7 => if (Left = Right) then
						Put_Line("True");
					else
						Put_Line("False");
					end if;
				when 8 => Put_Line(Simplify(Left));
				when others => null;
			end case;
		end loop;
	end doRational;

	userEntry : String(1..16);
	length : Natural;
begin -- Driver
	Put_Line("What would you like to work with today?");
	Put_Line("(C)omplex Numbers");
	Put_Line("(R)ational Numbers");
	Get_Line(userEntry, length);
	if (length > 0) then
		if (userEntry(userEntry'First) = 'C' or else userEntry(userEntry'First) = 'c') then
			doComplex;
		elsif (userEntry(userEntry'First) = 'R' or else userEntry(userEntry'First) = 'r') then
			doRational;
		end if;
	end if;
end Driver;
