--	rational_numbers.adb

--	Chris Corley
--	Assignment 3 - "LibNumbers"
--	CS390 - Dr. Roden
--	Due Tuesday, March 31, 2009

--	Purpose:

--	Input:

--	Output:

package body Rational_Numbers is
	function "+" (X: Rational) return Rational is
	begin
		if X.Num < 0 then
			return (-X.Num, X.Denom);
		end if;
		return X;
	end "+"; --unary

	function "-" (X: Rational) return Rational is
	begin
		if X.Num > 0 then
			return (-X.Num, X.Denom);
		end if;
		return X;
	end "-"; --unary

	function "+" (X, Y: Rational) return Rational is
	begin
		return X;
	end "+"; --binary

	function "-" (X, Y: Rational) return Rational is
	begin
		return X;
	end "-"; --binary

	function "*" (X, Y: Rational) return Rational is
	begin
		return X;
	end "*";

	function "/" (X, Y: Rational) return Rational is
	begin
		return X;
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

	function Simplify(X: Rational) return Rational is
	begin
		return X;
	end Simplify;

	function GCD (X,Y: Integer) return Integer is
	begin
		return 1;
	end GCD;

end Rational_Numbers;
