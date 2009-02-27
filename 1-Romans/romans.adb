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

procedure Romans is
	type RomanType is array (Character range <>) of Natural;
	RomanArray : RomanType('A'..'z') := (	'I' => 1, 'i' => 1,
						'V' => 5, 'v' => 5,
						'X' => 10, 'x' => 10,
						'L' => 50, 'l' => 50,
						'C' => 100, 'c' => 100,
						'D' => 500, 'd' => 500,
						'M' => 1000, 'm' => 1000,
						others => 0);
	userEntry : String(1..80);
	userEntryLen : Natural;
	totalValue : Natural := 0;
	currValueCount : Natural := 1;
	currValue : Natural;
	prevValue : Natural;
	greatValue : Natural;
	HasSubtracted : Boolean;
	SyntaxOK : Boolean;
begin
	loop
		userEntry := (others => ' '); -- empty the previous read
		Ada.Text_IO.Put("Please enter your Roman numerals ($ to quit): ");
		Ada.Text_IO.Get_Line(userEntry, userEntryLen);
		exit when userEntry(1) = '$';
		if(userEntryLen > 0) then
			HasSubtracted := false;
			SyntaxOK := true;
			currValueCount := 1;
			prevValue := RomanArray(userEntry(userEntryLen));
			greatValue := RomanArray(userEntry(userEntryLen));
			totalValue := prevValue;
			for N in reverse 1..(userEntryLen-1) loop
				currValue := RomanArray(userEntry(N));
				--only 3 values can repeat
				if currValue = prevValue then
					currValueCount := currValueCount + 1;
					if currValueCount >= 4 then
						SyntaxOK := false;
						Ada.Text_IO.Put_Line("4");
						exit;
					end if;
				else
					currValueCount := 1;
				end if;
				if currValue < prevValue then
					--only one value can be subtracted
					if HasSubtracted = true then
						SyntaxOK := false;
						Ada.Text_IO.Put_Line("2");
						exit;
					--values subtracted must be atleast 1/10
					elsif currValue * 10 < prevValue then
						SyntaxOK := false;
						Ada.Text_IO.Put_Line("1");
						exit;
					--values V, L, and D cannot be subtracted
					elsif currValue = 5 or currValue = 50 or currValue = 500 then
						SyntaxOK := false;
						Ada.Text_IO.Put_Line("5");
						exit;
					else
						HasSubtracted := true;
						totalValue := totalValue - currValue;
						currValueCount := 0;
					end if;
				else
					HasSubtracted := false;
					prevValue := currValue;
					totalValue := totalValue + currValue;
				end if;
			end loop;
			if SyntaxOK = true then
				Ada.Text_IO.Put(userEntry(1..userEntryLen));
				Ada.Integer_Text_IO.Put(totalValue);
			else
				Ada.Text_IO.Put_Line("Syntax error in your Roman numerals.");
			end if;
		end if;
		Ada.Text_IO.New_Line;
	end loop;
end Romans;
