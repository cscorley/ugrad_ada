--	subromans.adb

--	Chris Corley
--	Assignment 2 - "SubRomans"
--	CS390 - Dr. Roden
--	Due Thursday, March 12, 2009

--	Purpose:
--	Program will ask the user to enter a Roman numeral, convert the entry to decimal and
--	print the result.  Will exit upon "$" from user.

--	Input:
--	A case-sensitive sequence consisting of Roman numerals: I,V,X,L,C,D,M in syntactly
--	correct order.

--	Output:
--	The users entry followed by the decimal equivalent.

with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure SubRomans is
	type Roman_Enum is (I,V,X,L,C,D,M);
	type Roman_Type is array (Roman_Enum) of Natural;
	package Roman_IO is new Ada.Text_IO.Enumeration_IO(Enum => Roman_Enum);
	Roman_Value : constant Roman_Type := (	I => 1,
						V => 5,
						X => 10,
						L => 50,
						C => 100,
						D => 500,
						M => 1000);
	userEntry : String(1..80);
	length : Natural;


	-- Checks the given character if it is in the uppercase range and a roman numeral.
	function isUpperCase (value : Character) return Boolean is
	begin
		case value is
			when 'I' | 'V' | 'X' | 'L' | 'C' | 'D' | 'M' =>
				return true;
			when others =>
				return false;
		end case;
	end isUpperCase;

	-- Validates the string given and returns error number for later lookup on detection.
	function isValid (A : String; length : Natural) return Natural is
		currNumeral, prevNumeral : Roman_Enum;
		hasSubtracted : Boolean := false;
		tempIndex, repeatsCounter : Natural := 1;
	begin
		if ( length=0 or else not isUpperCase(A(length))) then
			return 1;
		end if;

		Roman_IO.Get("" & A(length),prevNumeral,tempIndex);

		for N in reverse A'First..(length-1) loop
			if (not isUpperCase(A(N))) then
				return 1;
			end if;
			Roman_IO.Get("" & A(N),currNumeral,tempIndex);
			if (currNumeral = prevNumeral) then
				repeatsCounter := repeatsCounter + 1;
				if (repeatsCounter >= 4) then
					return 2;
				elsif (repeatsCounter >= 2 and (currNumeral = V or currNumeral = L
										or currNumeral = D)) then
					return 3;
				end if;
			else
				repeatsCounter := 1;
			end if;

			if (currNumeral < prevNumeral) then
				if (hasSubtracted) then
					return 4;
				elsif (Roman_Enum'Pos(prevNumeral) > Roman_Enum'Pos(currNumeral) + 2) then
					return 5;
				elsif (currNumeral = V or currNumeral = L or currNumeral = D) then
					return 6;
				elsif (prevNumeral /= V and prevNumeral /= L and prevNumeral /= D) then
					repeatsCounter := 0;
				end if;
				hasSubtracted := true;
			else
				hasSubtracted := false;
				prevNumeral := currNumeral;
			end if;
		end loop;
		return 0;
	end isValid;

	-- Converts the string to the decimal equivalent
	function RomansToDecimal (B : String; length : Positive) return Positive is
		currNumeral, prevNumeral : Roman_Enum;
		hasSubtracted : Boolean := false;
		repeatsCounter : Natural := 1;
		tempIndex, totalValue : Natural;
	begin
		Roman_IO.Get("" & B(length),prevNumeral,tempIndex);
		totalValue := Roman_Value(prevNumeral);

		for N in reverse userEntry'First..(length-1) loop

			Roman_IO.Get("" & userEntry(N),currNumeral,tempIndex);
			if (currNumeral < prevNumeral) then
				totalValue := totalValue - Roman_Value(currNumeral);
			else
				prevNumeral := currNumeral;
				totalValue := totalValue + Roman_Value(currNumeral);
			end if;
		end loop;
		return totalValue;
	end RomansToDecimal;

	-- Prints an appropriate error message depending on value received.
	function printError (errorNumber : in Natural) return Boolean is
	begin
		case errorNumber is
			when 1 =>
				Put("Invalid numeral.");
			when 2 =>
				Put("Repeating numerals over 3 long are not allowed.");
			when 3 =>
				Put("Doubles of V, L, or D are not allowed.");
			when 4 =>
				Put("Cannot subtract two numerals in a row.");
			when 5 =>
				Put("Cannot subtract numeral from one over 10 times its size.");
			when 6 =>
				Put("Cannot subtract numerals V, L, or D from another numeral.");
			when others =>
				return false;
		end case;
		return true;
	end printError;


begin -- main procedure SubRomans
	loop
		Put("Please enter your Roman numeral ($ to quit): ");
		Get_Line(userEntry, length);
		exit when userEntry(userEntry'First) = '$';

		-- do not perform body when printError prints something.
		if not printError(isValid(userEntry, length)) then
			Put(userEntry(1..length));
			Put(RomansToDecimal(userEntry, length));
		end if;
		New_Line;
	end loop;
end SubRomans;
