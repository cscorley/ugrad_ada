--	driver.adb

--	Chris Corley
--	Assignment 3 - "LibNumbers"
--	CS390 - Dr. Roden
--	Due Tuesday, March 31, 2009

--	Purpose:

--	Input:

--	Output:

with Complex_Numbers, Rational_Numbers, Ada.Text_IO, Ada.Integer_Text_IO;

procedure Driver is
	use Complex_Numbers, Rational_Numbers, Ada.Text_IO, Ada.Integer_Text_IO;
	A, B, C : Complex;
	AP, BP, CP : Polar;
	D, E, F : Rational;
begin
	A := Cons (1.0,1.0);
	B := Cons (2.0,1.0);
	C := Cons (3.0,2.0);
	AP := ToPolar(A);
	BP := ToPolar(B);
	CP := ToPolar(C);
	Print(A); New_Line;
	Print(A-B); New_Line;
	Print(AP); New_Line;
	D := 4/5;
	E := 5/25;
	F := D + E;
	Print(F); New_Line;
	F := D*E;
	Print(F); New_Line;
	F := D/E;
	Print(F); New_Line;
	F := D-E;
	Print(F); New_Line;
	F := E-D;
	Print(F); New_Line;
	E := 0/1;
	F := D/E;
	Print(F); New_Line;
end Driver;
