--	rational_numbers.ads

--	Chris Corley
--	Assignment 3 - "LibNumbers"
--	CS390 - Dr. Roden
--	Due Tuesday, March 31, 2009

--	Purpose:

--	Input:

--	Output:


package Rational_Numbers is
	type Rational is private;
	function "+" (X: Rational) return Rational;
	function "-" (X: Rational) return Rational;
	function "+" (X, Y: Rational) return Rational;
	function "-" (X, Y: Rational) return Rational;
	function "*" (X, Y: Rational) return Rational;
	function "/" (X, Y: Rational) return Rational;
	function "/" (X: Integer; Y: Positive) return Rational; -- constructor
	function Numerator (X: Rational) return Integer;
	function Denominator (X: Rational) return Positive;
	function Simplify(X: Rational) return Rational;
private
	type Rational is
	record
		Num: Integer := 0;
		Denom: Positive := 1;
	end record;
	function GCD (X,Y: Integer) return Integer;
end Rational_Numbers;
