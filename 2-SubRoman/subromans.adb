--	subromans.adb

--	Chris Corley
--	Assignment 2 - "SubRomans"
--	CS390 - Dr. Roden
--	Due Thursday, March 12, 2009

--	Purpose:
--		Program will ask the user to enter a Roman numeral, convert the entry to decimal and
--		print the result.  Will exit upon "$" from user.
--	Input:
--		A case-sensitive sequence consisting of Roman numerals: I,V,X,L,C,D,M in syntactly
--		correct order.
--	Output:
--		The users entry followed by the decimal equivalent.

with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure SubRomans is
	type Roman_Enum is (I,V,X,L,C,D,M);
	type Roman_Type is array (Roman_Enum) of Natural;
	Roman_Value : constant Roman_Type := (  I => 1,
						V => 5,
						X => 10,
						L => 50,
						C => 100,
						D => 500,
						M => 1000);
	package Roman_IO is new Ada.Text_IO.Enumeration_IO(Enum => Roman_Enum);
	-- printError: Prints an appropriate error message and returns true upon print.
	-- Input: Integer: representing an error number
	-- Output: Boolean: if it printed an error message
	function printError (errorNumber : Natural) return Boolean is
	begin
		case errorNumber is
			when 0 => return false; -- no error found code
			when 1 => Put("Invalid numeral.");
			when 2 => Put("Repeating numerals over 3 long are not allowed.");
			when 3 => Put("Doubles of V, L, or D are not allowed.");
			when 4 => Put("Cannot subtract two numerals in a row.");
			when 5 => Put("Cannot subtract numeral from one over 10 times its size.");
			when 6 => Put("Cannot subtract numerals V, L, or D from another numeral.");
			when others => Put("Unknown error.");
		end case;
		return true;
	end printError;

	-- isUpperCase: Checks the given character if it is in the uppercase range and a Roman numeral.
	-- Input: Character
	-- Output: Boolean: if it is a valid upper case numeral.
	function isUpperCase (value : Character) return Boolean is
	begin
		case value is
			when 'I' | 'V' | 'X' | 'L' | 'C' | 'D' | 'M' => return true;
			when others => return false;
		end case;
	end isUpperCase;

	-- RomansToDecimal: Converts numeral to decimal.  This function assumes the string is valid.
	-- Input: String: users input, Positive: length of input
	-- Output: Positive: the value of the Roman Numeral in decimal.
	function RomansToDecimal (userNumeral : String; length : Positive) return Positive is
		currNumeral, prevNumeral : Roman_Enum;
		hasSubtracted : Boolean := false;
		repeatsCounter : Natural := 1;
		tempIndex, totalValue : Natural;
	begin
		Roman_IO.Get("" & userNumeral(length),prevNumeral,tempIndex);  -- convert to enumeration
		totalValue := Roman_Value(prevNumeral);		-- set total to the first read value

		for N in reverse userNumeral'First..(length-1) loop
			Roman_IO.Get("" & userNumeral(N),currNumeral,tempIndex); -- convert to enumeration

			if (currNumeral < prevNumeral) then
				totalValue := totalValue - Roman_Value(currNumeral);
			else
				prevNumeral := currNumeral;
				totalValue := totalValue + Roman_Value(currNumeral);
			end if;
		end loop;
		return totalValue;
	end RomansToDecimal;

	-- isValid: Validates the string given and returns error number for later lookup on detection
	-- Input: String: users input, Positive: length of input
	-- Output: Natural: error code of >= 1 if string is invalid, error code of 0 if valid.
	function isValid (userNumeral : String; length : Natural) return Natural is
		currNumeral, prevNumeral : Roman_Enum;
		hasSubtracted : Boolean := false;
		tempIndex, repeatsCounter : Natural := 1;
	begin
		if ( length=0 or else not isUpperCase(userNumeral(length))) then
			return 1;	-- ensure first read character is an upper case numeral
		end if;
		Roman_IO.Get("" & userNumeral(length),prevNumeral,tempIndex);    -- convert to enumeration

		for N in reverse userNumeral'First..(length-1) loop
			if (not isUpperCase(userNumeral(N))) then
				return 1;	-- ensure characters are upper case numerals
			end if;
			Roman_IO.Get("" & userNumeral(N),currNumeral,tempIndex); -- convert to enumeration

			if (currNumeral = prevNumeral) then
				repeatsCounter := repeatsCounter + 1;
				if (repeatsCounter >= 4) then
					return 2;	-- no repeating numerals over 3 long
				elsif (repeatsCounter >= 2 and (currNumeral = V or currNumeral = L
										or currNumeral = D)) then
					return 3;	-- no repeating numerals of 5*(10^n) | n=1,2,3...
				end if;
			else	-- this works since we do not change prevNumeral on subtraction.
				repeatsCounter := 1;
			end if;
			if (currNumeral < prevNumeral) then	-- we have detected a subtraction
				if (hasSubtracted) then
					return 4;	-- cannot subtract twice
				elsif (Roman_Enum'Pos(prevNumeral) > Roman_Enum'Pos(currNumeral) + 2) then
					return 5;	-- cannot subtract when curr*10 < prev
				elsif (currNumeral = V or currNumeral = L or currNumeral = D) then
					return 6;	--cannot subtract numerals of 5*(10^n) | n=1,2,3...
				elsif (prevNumeral /= V and prevNumeral /= L and prevNumeral /= D) then
					repeatsCounter := 0;	-- reset for numerals like XIX but not VIV.
				end if;
				hasSubtracted := true;
			else
				hasSubtracted := false;
				prevNumeral := currNumeral;
			end if;
		end loop;
		return 0;
	end isValid;

	userEntry : String(1..80);
	length : Natural;
begin -- main procedure SubRomans
	loop
		Put("Please enter your Roman numeral ($ to quit): ");
		Get_Line(userEntry, length);
		exit when userEntry(userEntry'First) = '$';

		-- perform body when printError does not print something (when isValid returns a code).
		if not printError(isValid(userEntry, length)) then
			Put(userEntry(1..length));	-- print the string from user
			Put(RomansToDecimal(userEntry, length));	-- print the decmial of the string
		end if;
		New_Line;
	end loop;
end SubRomans;
