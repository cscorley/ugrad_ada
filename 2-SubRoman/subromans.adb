--	subromans.adb

--	Chris Corley
--	Assignment 2 - "SubRomans"
--	CS390 - Dr. Roden
--	Due Thursday, March 12, 2009

--	Purpose:
--	Program will ask the user to enter a Roman numeral, convert the entry to decimal and
--	print the result.  Will exit upon "$" from user.

--	Input:
--	A case-insensitive sequence consisting of Roman numerals: I,V,X,L,C,D,M in syntactly
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
	function isUpperCase (value : Character) return Boolean is
	begin
		case value is
			when 'I' | 'V' | 'X' | 'L' | 'C' | 'D' | 'M' =>
				return true;
			when others =>
				return false;
		end case;
	end isUpperCase;
	-- Validates the string given and prints out approipriate error on detection.
	function isValid (A : String; length : Natural) return Boolean is
		currentNumeral, previousNumeral : Roman_Enum;
		hasSubtracted : Boolean := false;
		repeatsCounter : Natural := 1;
		tempIndex : Positive;
	begin
		if ( length=0) then
			return false;
		elsif (not isUpperCase(A(length))) then
			Put("Invalid numeral: " & A(length));
			return false;
		end if;

		Roman_IO.Get("" & A(length),previousNumeral,tempIndex);

		for N in reverse A'First..(length-1) loop
			if (not isUpperCase(A(N))) then
				Put("Invalid character: " & A(N));
				return false;
			end if;
			Roman_IO.Get("" & A(N),currentNumeral,tempIndex);
			if (currentNumeral = previousNumeral) then
				repeatsCounter := repeatsCounter + 1;
				if (repeatsCounter >= 4) then
					Put("Repeating numerals over 3 long are not allowed.");
					return false;
				elsif (repeatsCounter >= 2 and (currentNumeral = V
								or currentNumeral = L
								or currentNumeral = D)) then
					Put("Doubles of V, L, or D are not allowed.");
					return false;
				end if;
			else
				repeatsCounter := 1;
			end if;

			if (currentNumeral < previousNumeral) then
				if (hasSubtracted) then
					Put("Already attempted subtracting, cannot subtract two numerals in a row.");
					return false;
				elsif (Roman_Enum'Pos(previousNumeral) > Roman_Enum'Pos(currentNumeral) + 2) then
					Put("Cannot subtract numeral from a numeral over 10 times its size.");
					return false;
				elsif (currentNumeral = V or currentNumeral = L or currentNumeral = D) then
					Put("Cannot subtract numerals V, L, or D from another numeral.");
					return false;
				end if;

				hasSubtracted := true;

				if (previousNumeral /= V and previousNumeral /= L
							 and previousNumeral /= D) then
					repeatsCounter := 0;
				end if;
			else
				hasSubtracted := false;
				previousNumeral := currentNumeral;
			end if;
		end loop;
		return true;
	end isValid;

	-- Converts the string to the decimal equivalent
	function RomansToDecimal (B : String; length : Positive) return Positive is
		currentNumeral, previousNumeral : Roman_Enum;
		hasSubtracted : Boolean := false;
		repeatsCounter : Natural := 1;
		tempIndex : Positive;
		totalValue : Natural;
	begin
		Roman_IO.Get("" & B(length),previousNumeral,tempIndex);

		totalValue := Roman_Value(previousNumeral);

		for N in reverse userEntry'First..(length-1) loop

			Roman_IO.Get("" & userEntry(N),currentNumeral,tempIndex);
			if (currentNumeral < previousNumeral) then
				totalValue := totalValue - Roman_Value(currentNumeral);
			else
				previousNumeral := currentNumeral;
				totalValue := totalValue + Roman_Value(currentNumeral);
			end if;
		end loop;

		return totalValue;
	end RomansToDecimal;
begin -- main procedure SubRomans
	loop
		Put("Please enter your Roman numeral ($ to quit): ");
		Get_Line(userEntry, length);
		exit when userEntry(userEntry'First) = '$';

		if isValid(userEntry, length) then
			Put(userEntry(1..length));
			Put(RomansToDecimal(userEntry, length));
		end if;
		New_Line;
	end loop;
end SubRomans;
