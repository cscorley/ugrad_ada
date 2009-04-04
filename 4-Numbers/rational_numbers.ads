--	rational_numbers.ads

--	Chris Corley
--	Assignment 4 - "Numbers"
--	CS390 - Dr. Roden
--	Due Tuesday, April 7, 2009

--	Purpose:  Specification of Rational_Numbers package.  Package which handles rational
--		numbers and the operations upon them.

package Rational_Numbers is
	type Rational is private;
	function "+" (X: Rational) return Rational;
	function "-" (X: Rational) return Rational;
	function "+" (X, Y: Rational) return Rational;
	function "-" (X, Y: Rational) return Rational;
	function "*" (X, Y: Rational) return Rational;
	function "/" (X, Y: Rational) return Rational;
	function "=" (X, Y: Rational) return Boolean;
	function "/" (X: Integer; Y: Positive) return Rational; -- constructor
	function Numerator (X: Rational) return Integer;
	function Denominator (X: Rational) return Positive;
	function Simplify (X: Rational) return Rational;
	procedure Put (X: Rational);
	procedure Put_Line (X: Rational);
	procedure Get_Line (X: out Rational);
private
	type Rational is
	record
		Num: Integer := 0;
		Denom: Positive := 1;
	end record;
	function GCD (X,Y: Integer) return Integer;
end Rational_Numbers;
