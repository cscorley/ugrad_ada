--	romans.adb

--	Chris Corley
--	Assignment 1 - "Romans"
--	CS390 - Dr. Roden
--	Due February 26, 2009

--	Purpose:
--	Program will ask the user to enter a Roman numeral, convert the entry to
--	decimal and print the result.  Will exit upon "$" from user.

--	Input:
--	A case-insensitive sequence consisting of Roman numerals: I,V,X,L,C,D,M
--	in syntactly correct order.  Program does not check for syntax errors.

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
						others=>0);
	userEntry : String(1..80);
	userEntryLen : Natural;
	totalValue : Natural := 0;
	currValue : Integer;
	prevValue : Integer;
begin
	loop
		userEntry := (others => ' '); -- empty the previous read
		Ada.Text_IO.Put("Please enter your Roman numerals ($ to quit): ");
		Ada.Text_IO.Get_Line(userEntry, userEntryLen);
		exit when userEntry(1) = '$';
		if(userEntryLen > 0) then
			prevValue := RomanArray(userEntry(userEntryLen));
			totalValue := prevValue;
			for N in reverse 1..(userEntryLen-1) loop
				currValue := RomanArray(userEntry(N));
				if currValue < prevValue then
					totalValue := totalValue - currValue;
				else
					totalValue := totalValue + currValue;
				end if;
				prevValue := currValue;
			end loop;
			Ada.Text_IO.Put(userEntry(1..userEntryLen));
			Ada.Integer_Text_IO.Put(totalValue);
		end if;
		Ada.Text_IO.New_Line;
	end loop;
end Romans;
