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
	type Roman_Enum is (I,V,X,L,C,D,M);
	type Roman_Type is array (Roman_Enum) of Natural;
	package Roman_IO is new Ada.Text_IO.Enumeration_IO(Enum => Roman_Enum);
	Roman_Value : Roman_Type := (	I => 1,
					V => 5,
					X => 10,
					L => 50,
					C => 100,
					D => 500,
					M => 1000);
	userEntry : String(1..34); -- MMMCMDDDCDCCCXCLLLXLXXXIXVVVIVIII
	length, totalValue, repeatsCounter : Natural;
	hasSubtracted, syntaxOK : Boolean;
	currentNumeral, previousNumeral : Roman_Enum;
	tempIndex : Positive;
begin
	loop
		userEntry := (others => ' '); -- empty the previous read

		Put("Please enter your Roman numeral ($ to quit): ");
		Get_Line(userEntry, length);
		exit when userEntry(1) = '$';

		if (length > 0) then
			-- reset for new read
			hasSubtracted := false;
			syntaxOK := true;
			repeatsCounter := 1;

			-- initialize the smallest digit to set a previousNumeral
			--	for the loop and set the start totalValue to that.
			-- must concatenate since Get requires String, but
			--	userEntry(length) returns a Character value.
			Roman_IO.Get("" & userEntry(length),previousNumeral,tempIndex);
			totalValue := Roman_Value(previousNumeral);

			-- begin reading right to left.
			for N in reverse 1..(length-1) loop
				-- must concatenate since Get requires String, but
				--	userEntry(N) returns a Character value.
				Roman_IO.Get("" & userEntry(N),currentNumeral,tempIndex);

				-- insure no repeating numerals, will total value
				--	later.  ie, IIII should be written IV.
				if (currentNumeral = previousNumeral) then
					repeatsCounter := repeatsCounter + 1;
					if (repeatsCounter >= 4) then
						syntaxOK := false;
						exit;
					end if;
				else
					repeatsCounter := 1;
				end if;

				-- subtract if the left value < right value
				if (currentNumeral < previousNumeral) then
					-- assume bad syntax incase exit statement
					--	makes us leave the loop.
					syntaxOK := false;
					exit when (hasSubtracted
						or Roman_Value(currentNumeral) * 10 < Roman_Value(previousNumeral)
						or currentNumeral = V
						or currentNumeral = L
						or currentNumeral = D);
					-- if we made it this far, it must be OK.
					syntaxOK := true;


					hasSubtracted := true;

					repeatsCounter := 0;
					totalValue := totalValue - Roman_Value(currentNumeral);
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
