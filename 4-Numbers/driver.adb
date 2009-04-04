--	driver.adb

--	Chris Corley
--	Assignment 4 - "Numbers"
--	CS390 - Dr. Roden
--	Due Tuesday, April 7, 2009

--	Purpose:  Tests the two packages Complex_Numbers and Rational_Numbers

--	Input:

--	Output:

with Complex_Numbers, Rational_Numbers, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;

procedure Driver is
	use Complex_Numbers, Rational_Numbers, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
	userEntry : String(1..16);
	length : Natural;
	procedure doComplex is
		option : Natural := 12;
		Left, Right : Complex;
	begin
		loop
			New_Line;
			Put_Line("Please select your operation");
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
				when 8 => Put_Line(Conjugate(Left));
				when 9 => Put_Line(Float'Image(Absolute(Left)));
				when 10 => Put_Line(ToPolar(Left));
				when others => null;
			end case;
		end loop;
	end doComplex;
	procedure doRational is
		option : Natural := 12;
		Left, Right : Rational;
	begin
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
begin
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
