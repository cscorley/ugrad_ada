--	complex_numbers.adb

--	Chris Corley
--	Assignment 3 - "LibNumbers"
--	CS390 - Dr. Roden
--	Due Tuesday, March 31, 2009

--	Purpose:

--	Input:

--	Output:


package body Complex_Numbers is
	function "+" (X: Complex) return Complex is
	begin
		return X;
	end "+"; --unary

	function "-" (X: Complex) return Complex is
	begin
		return X;
	end "-"; --unary

	function "+" (X, Y: Complex) return Complex is
	begin
		return (X.Re + Y.Re, X.Im + Y.Im);
	end "+"; -- binary

	function "-" (X, Y: Complex) return Complex is
	begin
		return (X.Re - Y.Re, X.Im - Y.Im);
	end "-"; --binary

	function "*" (X, Y: Complex) return Complex is
	begin
		return X;
	end "*";

	function "/" (X, Y: Complex) return Complex is
	begin
		return X;
	end "/";

	function Cons (R,I: Float) return Complex is
	begin
		return (R, I);
	end Cons;

	function Re_Part (X: Complex) return Float is
	begin
		return X.Re;
	end Re_Part;

	function Im_Part (X: Complex) return Float is
	begin
		return X.Im;
	end Im_Part;

	function Conjugate (X: Complex) return Complex is
	begin
		return (X.Re, -X.Im);
	end Conjugate;

	function Absolute (X: Complex) return Float is
	begin
		--Sqrt ((X.Re * X.Re) + (X.Im * X.Im))
		return 0.0;
	end Absolute;

	function ToPolar (X: Complex) return Polar is
	begin
		--R= Absolute(X)
		--Theta = arctan(X.Im / X.Re)
		-- watch for special cases of the 2nd/3rd quadrants.
		return (Absolute(X), 0.0);
	end ToPolar;

	function ToComplex (X: Polar) return Complex is
	begin
		--Re = X.R * cos(X.Theta)
		--Im = X.R * sin(X.Theta)
		return (0.0,0.0);
	end ToComplex;
end Complex_Numbers;
