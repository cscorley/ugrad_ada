--	rational_numbers.adb

--	Chris Corley
--	Assignment 4 - "Numbers"
--	CS390 - Dr. Roden
--	Due Tuesday, April 7, 2009

--	Purpose:  Body of Rational_Numbers package.  Package which handles rational
--		numbers and the operations upon them.

with Ada.Text_IO, Ada.Integer_Text_IO;
package body Rational_Numbers is
	use Ada.Text_IO, Ada.Integer_Text_IO;
	function "+" (X: Rational) return Rational is
	begin
		return X;
	end "+"; --unary

	function "-" (X: Rational) return Rational is
	begin
		return (-X.Num, X.Denom);
	end "-"; --unary

	function "+" (X, Y: Rational) return Rational is
	begin
		return Simplify(((X.Num*Y.Denom)+(Y.Num * X.Denom), (X.Denom*Y.Denom)));
	end "+"; --binary

	function "-" (X, Y: Rational) return Rational is
	begin
		return Simplify(((X.Num*Y.Denom)-(Y.Num * X.Denom), (X.Denom*Y.Denom)));
	end "-"; --binary

	function "*" (X, Y: Rational) return Rational is
	begin
		return Simplify(((X.Num*Y.Num), (X.Denom*Y.Denom)));
	end "*";


	function "=" (X, Y: Rational) return Boolean is
		ReducedX : Rational := Simplify(X);
		ReducedY : Rational := Simplify(Y);
	begin
		return (ReducedX.Num = ReducedY.Num and then ReducedX.Denom = ReducedY.Denom);
	end "=";

	function "/" (X, Y: Rational) return Rational is
		N : Integer := X.Num*Y.Denom;
		D : Integer := X.Denom*Y.Num;
	begin
		if D < 0 then
			D := -D; -- switch signs so numerator holds negative
			N := -N;
		elsif (D = 0) then
			return (0,1); -- NaN
		end if;
		return Simplify((N,D));
	end "/";

	function "/" (X: Integer; Y: Positive) return Rational is -- constructor
	begin
		return (X, Y);
	end "/";

	function Numerator (X: Rational) return Integer is
	begin
		return X.Num;
	end Numerator;

	function Denominator (X: Rational) return Positive is
	begin
		return X.Denom;
	end Denominator;

	-- Simply: returns the same rational in the most reduced form by calling dividing out the GCD.
	function Simplify (X: Rational) return Rational is
		divisor : Integer;
	begin
		divisor := GCD(X.Num, X.Denom);
		return (X.Num / divisor, X.Denom / divisor);
	end Simplify;

	procedure Put (X: Rational) is
	begin
		Put(Integer'Image(X.Num));
		Put("/");
		Put(Integer'Image(X.Denom));
	end Put;

	procedure Put_Line (X: Rational) is
	begin
		Put(X);
		New_Line;
	end Put_Line;

	procedure Get_Line (X: out Rational) is
		userEntry : String (1..80) := (others => ' ');
		length : Natural := 0;
		slashPos : Natural := 0;
	begin
		Get_Line(userEntry, length);
		for I in userEntry'First..length loop
			slashPos := I;
			exit when (userEntry(I) = '/' or userEntry(I) = '\');
		end loop;
		X := Integer'Value(userEntry(1..slashPos-1))/Integer'Value(userEntry(slashPos+1..length));
	end Get_Line;
	-- GCD: Recursively looks for the Greatest Common Divisor between two Integers.
	function GCD (X,Y: Integer) return Integer is
	begin
		if Y = 0 then
			return X;
		else
			return GCD(Y, X mod Y);
		end if;
	end GCD;

end Rational_Numbers;
