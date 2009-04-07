--	complex_numbers.adb

--	Chris Corley
--	Assignment 4 - "Numbers"
--	CS390 - Dr. Roden
--	Due Tuesday, April 7, 2009

--	Purpose:  Body of Complex_Numbers package.  Package handles complex numbers
--		and the operations upon them, in both polar and rectangular forms.

with Ada.Numerics, Ada.Numerics.Elementary_Functions, Ada.Text_IO;
package body Complex_Numbers is
	use Ada.Numerics, Ada.Numerics.Elementary_Functions, Ada.Text_IO;
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

	function Cons (Re,Im: Float) return Complex is -- constructor
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

	procedure Put (X: Complex) is
	begin
		Put(Float'Image(X.Re)); -- Looks cleaner using Integers, but doesn't do much help other
					-- than reduce the dependency list here.
		if (X.Im >= 0.0) then
			Put(" +");
		else
			Put(" ");
		end if;
		Put(Float'Image(X.Im));
		Put(" * i");
	end Put;

	procedure Put_Line (X: Complex) is
	begin
		Put(X);
		New_Line;
	end Put_Line;

	-- Get_Line will fetch a line from user input and parse it for relevant information.
	-- Only works when input is in a +- bi form!
	procedure Get_Line (X: out Complex) is
		userEntry : String (1..80) := (others => ' ');
		length,signPos : Natural := 0;
		iPos : Natural := 80;
	begin
		Get_Line(userEntry, length);
		for I in userEntry'First..length loop
			signPos := I;
			exit when (userEntry(I) = '+' or userEntry(I) = '-');
		end loop;
		for I in signPos+1..length loop
			iPos := I;
			exit when (userEntry(I) = 'i' or userEntry(I) = 'I');
		end loop;
		X :=Cons(Float'Value(userEntry(1..signPos-1)),Float'Value(userEntry(signPos..iPos-1)));
	end Get_Line;
	-- Polar functions
	function "+" (X: Polar) return Polar is
	begin
		return X;
	end "+"; --unary

	function "-" (X: Polar) return Polar is
	begin
		return (-X.R, X.Theta);
	end "-"; --unary

	-- There is no clear way to add or subtract two Polar numbers, so simply convert them to
	-- Complex type before adding or subtracting, and then convert them back to Polar form.
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

	procedure Put (X: Polar) is
	begin
		Put(Float'Image(X.R));
		Put(" * cis(");
		Put(Float'Image(X.Theta));
		Put(")");
	end Put;

	procedure Put_Line (X: Polar) is
	begin
		Put(X);
		New_Line;
	end Put_Line;

	-- Conversion functions
	function ToPolar (X: Complex) return Polar is
	begin
		-- Adjust the Imaginary part depending on Quadrant our polar coordinate is located.
		if X.Re < 0.0 and then X.Im >= 0.0 then
			return (Absolute(X), arctan(X.Im / X.Re) + Pi);
		elsif X.Re < 0.0 and then X.Im < 0.0 then
			return (Absolute(X), arctan(X.Im / X.Re) - Pi);
		end if;
		return (Absolute(X), arctan(X.Im / X.Re));
	end ToPolar;

	function ToComplex (X: Polar) return Complex is
	begin
		return (X.R * cos(X.Theta),X.R * sin(X.Theta));
	end ToComplex;
end Complex_Numbers;
