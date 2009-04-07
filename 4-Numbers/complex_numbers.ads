--	complex_numbers.ads

--	Chris Corley
--	Assignment 4 - "Numbers"
--	CS390 - Dr. Roden
--	Due Tuesday, April 7, 2009

--	Purpose:  Specification of Complex_Numbers package.  Package handles complex numbers
--		and the operations upon them, in both polar and rectangular forms.
with Ada.Numerics;

package Complex_Numbers is
	use Ada.Numerics;

	type Complex is private;
	type Polar is private;
	I: constant Complex;

	-- Complex functions
	function "+" (X: Complex) return Complex;
	function "-" (X: Complex) return Complex;
	function "+" (X, Y: Complex) return Complex;
	function "-" (X, Y: Complex) return Complex;
	function "*" (X, Y: Complex) return Complex;
	function "/" (X, Y: Complex) return Complex;
	function Cons (Re,Im: Float) return Complex;
	function Re_Part (X: Complex) return Float;
	function Im_Part (X: Complex) return Float;
	function Conjugate (X: Complex) return Complex;
	function Absolute (X: Complex) return Float;
	procedure Put (X: Complex);
	procedure Put_Line (X: Complex);
	procedure Get_Line (X: out Complex);

	-- Polar functions
	function "+" (X: Polar) return Polar;
	function "-" (X: Polar) return Polar;
	function "+" (X, Y: Polar) return Polar;
	function "-" (X, Y: Polar) return Polar;
	function "*" (X, Y: Polar) return Polar;
	function "/" (X, Y: Polar) return Polar;
	function Cons (R,Theta: Float) return Polar;
	function R_Part (X: Polar) return Float;
	function Theta_Part (X: Polar) return Float;
	function Conjugate (X: Polar) return Polar;
	function Absolute (X: Polar) return Float;
	procedure Put (X: Polar);
	procedure Put_Line (X: Polar);

	-- Conversion functions
	function ToPolar (X: Complex) return Polar;
	function ToComplex (X: Polar) return Complex;
private
	type Complex is
	record
		Re, Im: Float;
	end record;
	type Polar is
	record
		R: Float;
		Theta: Float range -Pi..Pi;
	end record;
	I: constant Complex := (0.0, 1.0);
end Complex_Numbers;
