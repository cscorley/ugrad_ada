--	romans.adb

--	Chris Corley
--	Assignment 1 - "Romans"
--	CS390 - Dr. Roden
--	Due Tuesday, March 3, 2009

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

procedure Romans is
	type Roman_Enum is (I,V,X,L,C,D,M);
	type Roman_Type is array (Roman_Enum) of Natural;
	package Roman_IO is new Ada.Text_IO.Enumeration_IO(Enum => Roman_Enum);
	-- this is going to end up very painful for a user who enters a non-roman numeral.
	Roman_Value : Roman_Type := (	I => 1,
					V => 5,
					X => 10,
					L => 50,
					C => 100,
					D => 500,
					M => 1000);
	userEntry : String(1..80);
	length, totalValue, repeatsCounter : Natural;
	hasSubtracted, syntaxOK : Boolean;
	currentNumeral, previousNumeral : Roman_Enum;
	tempIndex : Positive;
begin
	loop
	userEntry := (others => ' '); -- empty the previous read

	Put("Please enter your Roman numeral ($ to quit): ");
	Get_Line(userEntry, length);
	exit when userEntry(userEntry'First) = '$';

	if (length > 0) then
		-- reset for new read
		hasSubtracted := false;
		syntaxOK := true;
		repeatsCounter := 1;

		-- initialize the smallest digit to set a previousNumeral for the loop and set the
		-- starting totalValue to that.  Must concatenate since Get requires String.
		Roman_IO.Get("" & userEntry(length),previousNumeral,tempIndex);
		totalValue := Roman_Value(previousNumeral);

		-- begin reading right to left.
		for N in reverse userEntry'First..(length-1) loop
			-- must concatenate since Get requires String.
			Roman_IO.Get("" & userEntry(N),currentNumeral,tempIndex);

			-- insure no >3 repeating numerals or any of 5x10^n numerals (V,L,D).
			-- ie, IIII should be written IV. VV should be written X.
			if (currentNumeral = previousNumeral) then
				repeatsCounter := repeatsCounter + 1;
				-- assume bad syntax incase exit statement makes us leave the loop.
				syntaxOK := false;
				exit when ( repeatsCounter >= 4
					or ( repeatsCounter >= 2 and ( 	currentNumeral = V
									or currentNumeral = L
									or currentNumeral = D)));
				-- if we made it this far, it must be OK.
				syntaxOK := true;
			else
				repeatsCounter := 1;
			end if;

			-- subtract if the left value < right value
			if (currentNumeral < previousNumeral) then
				-- assume bad syntax incase exit statement makes us leave the loop.
				syntaxOK := false;
				exit when (hasSubtracted
					or Roman_Value(currentNumeral) * 10 < Roman_Value(previousNumeral)
					or currentNumeral = V
					or currentNumeral = L
					or currentNumeral = D);
				-- if we made it this far, it must be OK.
				syntaxOK := true;
				hasSubtracted := true;

				totalValue := totalValue - Roman_Value(currentNumeral);

				-- since we are subtracting, we don't change the previousNumeral.
				-- But because of this, we must set repeatsCounter to 0 so
				-- the value being subtracted isn't considered apart of it.
				-- Also, repeats of 5x10^n numerals (V,L,D) are not included.
				-- ie, VIV should be written IX.
				-- XXXX is invalid, but both XXX and XXXIX are.
				if (previousNumeral /= V and previousNumeral /= L
							 and previousNumeral /= D) then
					repeatsCounter := 0;
				end if;
			else
				hasSubtracted := false;

				previousNumeral := currentNumeral;
				totalValue := totalValue + Roman_Value(currentNumeral);
			end if;
		end loop;

		-- decide on what to print depending on flag
		if syntaxOK then
			Put(userEntry(1..length));
			Put(totalValue);
		else
			Put_Line("Syntax error in your Roman numerals.");
		end if;
	end if;
	New_Line;
	end loop;
end Romans;
