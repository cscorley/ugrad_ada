--	complex_numbers.ads

--	Chris Corley
--	Assignment 3 - "LibNumbers"
--	CS390 - Dr. Roden
--	Due Tuesday, March 31, 2009

--	Purpose:

--	Input:

--	Output:

package Complex_Numbers is
	type Complex is private;
	type Polar is private;
	I: constant Complex;
	function "+" (X: Complex) return Complex;
	function "-" (X: Complex) return Complex;
	function "+" (X, Y: Complex) return Complex;
	function "-" (X, Y: Complex) return Complex;
	function "*" (X, Y: Complex) return Complex;
	function "/" (X, Y: Complex) return Complex;
	function Cons (R,I: Float) return Complex;
	function Re_Part (X: Complex) return Float;
	function Im_Part (X: Complex) return Float;
	function Conjugate (X: Complex) return Complex;
	function Absolute (X: Complex) return Float;
	function ToPolar (X: Complex) return Polar;
	function ToComplex (X: Polar) return Complex;
private
	type Complex is
	record
		Re, Im: Float;
	end record;
	type Polar is
	record
		R, Theta: Float;
	end record;
	I: constant Complex := (0.0, 1.0);
end Complex_Numbers;
