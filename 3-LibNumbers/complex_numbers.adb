--	complex_numbers.adb

--	Chris Corley
--	Assignment 3 - "LibNumbers"
--	CS390 - Dr. Roden
--	Due Tuesday, March 31, 2009

--	Purpose:

--	Input:

--	Output:

with Ada.Text_IO, Ada.Float_Text_IO, Ada.Numerics, Ada.Numerics.Elementary_Functions;

package body Complex_Numbers is
	use Ada.Text_IO, Ada.Float_Text_IO, Ada.Numerics, Ada.Numerics.Elementary_Functions;

	-- Complex functions
	function "+" (X: Complex) return Complex is
	begin
		return X;
	end "+"; --unary

	function "-" (X: Complex) return Complex is
	begin
		return (-X.Re, -X.Im);
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
		return (X.Re*Y.Re - X.Im*Y.Im, X.Im*Y.Re + X.Re*Y.Im);
	end "*";

	function "/" (X, Y: Complex) return Complex is
		Div : Float := Y.Re**2 + Y.Im**2;
	begin
		if Y /= (0.0,0.0) then
			return ((X.Re*Y.Re + X.Im*Y.Im)/Div, (X.Im*Y.Re - X.Re*Y.Im)/Div);
		end if;
		return (0.0,0.0);
	end "/";

	function Cons (Re,Im: Float) return Complex is
	begin
		return (Re, Im);
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
		return Sqrt((X.Re*X.Re) + (X.Im*X.Im));
	end Absolute;
	procedure Print(X: Complex) is
	begin
		Put(Re_Part(X));
		if Im_Part(X) < 0.0 then
			Put(" ");
		else
			Put(" + ");
		end if;
		Put(Im_Part(X));
		Put("i");
	end Print;

	-- Polar functions
	function "+" (X: Polar) return Polar is
	begin
		return X;
	end "+"; --unary

	function "-" (X: Polar) return Polar is
	begin
		return (-X.R, X.Theta);
	end "-"; --unary

	function "+" (X, Y: Polar) return Polar is
	begin
		return (ToPolar(ToComplex(X) + ToComplex(Y)));
	end "+"; -- binary

	function "-" (X, Y: Polar) return Polar is
	begin
		return (ToPolar(ToComplex(X) - ToComplex(Y)));
	end "-"; --binary

	function "*" (X, Y: Polar) return Polar is
	begin
		return (X.R * Y.R, X.Theta + Y.Theta);
	end "*";

	function "/" (X, Y: Polar) return Polar is
	begin
		return (X.R / Y.R, X.Theta - Y.Theta);
	end "/";

	function Cons (R,Theta: Float) return Polar is
	begin
		return (R, Theta);
	end Cons;

	function R_Part (X: Polar) return Float is
	begin
		return X.R;
	end R_Part;

	function Theta_Part (X: Polar) return Float is
	begin
		return X.Theta;
	end Theta_Part;

	function Conjugate (X: Polar) return Polar is
	begin
		return (X.R, -X.Theta);
	end Conjugate;

	function Absolute (X: Polar) return Float is
	begin
		return X.R;
	end Absolute;

	procedure Print(X: Polar) is
	begin
		Put(R_Part(X));
		Put("(cos");
		Put(Theta_Part(X));
		Put(" + i*sin");
		Put(Theta_Part(X));
		Put(")");

	end Print;


	-- Conversion functions
	function ToPolar (X: Complex) return Polar is
	begin
		--R= Absolute(X)
		--Theta = arctan(X.Im / X.Re)
		-- watch for special cases of the 2nd/3rd quadrants.
		if X.Re < 0.0 then
			return (Absolute(X), arctan(X.Im / X.Re) + Pi);
		end if;
		return (Absolute(X), arctan(X.Im / X.Re));
	end ToPolar;

	function ToComplex (X: Polar) return Complex is
	begin
		--Re = X.R * cos(X.Theta)
		--Im = X.R * sin(X.Theta)
		return (X.R * cos(X.Theta),X.R * sin(X.Theta));
	end ToComplex;
end Complex_Numbers;
