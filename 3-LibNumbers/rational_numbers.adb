--	rational_numbers.adb

--	Chris Corley
--	Assignment 3 - "LibNumbers"
--	CS390 - Dr. Roden
--	Due Tuesday, March 31, 2009

--	Purpose:

--	Input:

--	Output:


with Ada.Text_IO, Ada.Integer_Text_IO;
package body Rational_Numbers is
	use Ada.Text_IO, Ada.Integer_Text_IO;
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

	function "/" (X, Y: Rational) return Rational is
	begin
		if (Y.Num /= 0) then
			return Simplify(((X.Num*Y.Denom), (X.Denom*Y.Num)));
		end if;
		return (999999999,1);
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
		divisor : Integer;
	begin
		divisor := GCD(X.Num, X.Denom);
		return (X.Num / divisor, X.Denom / divisor);
	end Simplify;

	function GCD (X,Y: Integer) return Integer is
	begin
		if Y = 0 then
			return X;
		else
			return GCD(Y, X mod Y);
		end if;
	end GCD;
	procedure Print (X: Rational) is
	begin
		Put(Numerator(X));
		Put("/");
		Put(Denominator(X));
	end Print;
end Rational_Numbers;
