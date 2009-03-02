--	romans.adb

--	Chris Corley
--	Assignment 1 - "Romans"
--	CS390 - Dr. Roden
--	Due Tuesday, March 3, 2009

--	Purpose:
--	Program will ask the user to enter a Roman numeral, convert the entry to
--	decimal and print the result.  Will exit upon "$" from user.

--	Input:
--	A case-insensitive sequence consisting of Roman numerals: I,V,X,L,C,D,M
--	in syntactly correct order.

--	Output:
--	The users entry followed by the decimal equivalent.

with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Romans is
	--type RomanType is array (Character range <>) of Natural;
	type RomanEnum is (I,V,X,L,C,D,M);
	type RomanType is array (RomanEnum) of Natural;
	package Roman_IO is new Ada.Text_IO.Enumeration_IO(Enum => RomanEnum);
	Roman_Value : RomanType := (	I => 1,
						V => 5,
						X => 10,
						L => 50,
						C => 100,
						D => 500,
						M => 1000);
	--Roman_Value : RomanType ('A'..'z') := (	'I' => 1, 'i' => 1,
						--'V' => 5, 'v' => 5,
						--'X' => 10, 'x' => 10,
						--'L' => 50, 'l' => 50,
						--'C' => 100, 'c' => 100,
						--'D' => 500, 'd' => 500,
						--'M' => 1000, 'm' => 1000,
						--others => 0);
	userEntry : String(1..80);
	userEntryLen, totalValue, currValueCount : Natural;
	HasSubtracted, SyntaxOK : Boolean;
	currValue, prevValue : RomanEnum;
	tempIndex : Positive;
begin
	loop
		userEntry := (others => ' '); -- empty the previous read
		Put("Please enter your Roman numeral ($ to quit): ");
		Get_Line(userEntry, userEntryLen);
		exit when userEntry(1) = '$';
		if (userEntryLen > 0) then
			HasSubtracted := false;
			SyntaxOK := true;
			currValueCount := 1;
			Roman_IO.Get("" & userEntry(userEntryLen),prevValue,tempIndex);
			--prevValue := Roman_Value(tempRoman);
			--prevValue := Roman_Value(userEntry(userEntryLen));
			totalValue := Roman_Value(prevValue);
			for N in reverse 1..(userEntryLen-1) loop
				Roman_IO.Get("" & userEntry(N),currValue,tempIndex);
				--currValue := Roman_Value(tempRoman);
				--currValue := Roman_Value(userEntry(N));
				if (currValue = prevValue) then
					currValueCount := currValueCount + 1;
					if (currValueCount >= 4) then
						SyntaxOK := false;
						exit;
					end if;
				else
					currValueCount := 1;
				end if;
				if (currValue < prevValue) then
					SyntaxOK := false;
					exit when (HasSubtracted
						or Roman_Value(currValue) * 10 < Roman_Value(prevValue)
						or currValue = V
						or currValue = L
						or currValue = D);
					SyntaxOK := true;
					HasSubtracted := true;
					currValueCount := 0;
					totalValue := totalValue - Roman_Value(currValue);
				else
					HasSubtracted := false;
					prevValue := currValue;
					totalValue := totalValue + Roman_Value(currValue);
				end if;
			end loop;
			if SyntaxOK then
				Put(userEntry(1..userEntryLen));
				Put(totalValue);
			else
				Put_Line("Syntax error in your Roman numerals.");
			end if;
		end if;
		New_Line;
	end loop;
end Romans;
