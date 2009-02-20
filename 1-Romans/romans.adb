--      romans.adb

--	Chris Corley
--	Assignment 1 - "Romans"
--	CS390 - Dr. Roden
--	Due February 26, 2009

--	Purpose:
--	Program will ask the user to enter a roman numeral, convert the entry to
--	decimal and print out the result.  Will exit upon "$" from user.

--	Input:
--	A non-case-sensitive sequenece consisting of Roman digits: I,V,X,L,C,D,M
--	in syntactly correct order.  Program does not check for syntax errors.

--	Output:
--	The users entry followed by the decimal equivalent.


with Ada.Text_IO, Ada.Integer_Text_IO;

procedure Romans is
	type RomanType is array (Character range <>) of Natural;
	myArray : RomanType('A'..'z') := ('I' => 1, 'i' => 1,
				'V' => 5, 'v' => 5,
				'X' => 10, 'x' => 10,
				'L' => 50, 'l' => 50,
				'C' => 100, 'c' => 100,
				'D' => 500, 'd' => 500,
				'M' => 1000, 'm' => 1000,
				others=>0);
	userEntry : String(1..80);
	userEntryLen : Positive;
	totalValue : Natural := 0;
	currValue : Integer;
	prevValue : Integer;
begin
	loop
		Ada.Text_IO.Put_Line("Please enter your Roman numerals ($ to quit): ");
		Ada.Text_IO.Get_Line(userEntry, userEntryLen);
		exit when userEntry(1) = '$';
		--Ada.Text_IO.Put_Line(userEntry);
		--Ada.Integer_Text_IO.Put(userEntryLen);
		--Ada.Integer_Text_IO.Put(myArray('M'));
		--Ada.Text_IO.Put(userEntry(userEntryLen));
		prevValue := myArray(userEntry(userEntryLen));
		totalValue := prevValue;
		for eye in reverse 1..(userEntryLen-1) loop
			--Ada.Integer_Text_IO.Put(eye);
			currValue := myArray(userEntry(eye));
			if currValue < prevValue then
				totalValue := totalValue - currValue;
			else
				totalValue := totalValue + currValue;
			end if;
			prevValue := currValue;
		end loop;
		Ada.Integer_Text_IO.Put(totalValue);
		Ada.Text_IO.Put_Line("");
	end loop;
end Romans;
