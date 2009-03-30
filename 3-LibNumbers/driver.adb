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
	A := Cons (0.63,1.337);
	B := Cons (0.50,1.0);
	C := Cons (3.0,2.0);
	AP := ToPolar(A);
	BP := ToPolar(B);
	CP := ToPolar(C);
	Print(A); New_Line;
	Print(ToComplex(AP)); New_Line;
	New_Line;
	Print(-A); New_Line;
	Print(ToComplex(-AP)); New_Line;
	New_Line;
	Print(A+B); New_Line;
	Print(ToComplex(AP+BP)); New_Line;
	New_Line;
	Print(A-B); New_Line;
	Print(ToComplex(AP-BP)); New_Line;
	New_Line;
	Put_Line("These next two should be equal.  If not, your reference angles are FUCKED.");
	Print(A-C); New_Line;
	Print(ToComplex(AP-CP)); New_Line;
	New_Line;
	Print(A*B); New_Line;
	Print(ToComplex(AP*BP)); New_Line;
	New_Line;
	Print(A/B); New_Line;
	Print(ToComplex(AP/BP)); New_Line;
	New_Line;
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
