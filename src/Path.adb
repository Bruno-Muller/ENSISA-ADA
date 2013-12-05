--with Adagraph; use Adagraph;
--with Interfaces; use Interfaces;
--with Ada.Numerics; use Ada.Numerics;
--with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body Path is

   function Value (From: Points) return Object is
   begin
       return Object'(Size => From'Length, Values => From);
   end Value;

   function "&" (Left: in Object ; Right: in Object) return Object is
   begin
      return Object'(Size => Left.Size + Right.Size, Values => Left.Values & Right.Values);
   end "&";

   function "&" (Left: in Object; Right: in Point) return Object is
      P: Points := Left.Values;
   begin
      P(Left.Size+1) := Right;
      return Object'(Size => Left.Size+1, Values => P);
   end "&";

   function "&" (Left: in Point; Right: in Object) return Object is
      P: Points := Right.Values;
   begin
      P(Right.Size+1) := Left;
      return Object'(Size => Right.Size+1, Values => P);
   end "&";

   procedure Add (Path: in out Object; P: in Point) is
   begin
	Path := Path & P;
   end Add;

   function Segment_Count (Path: in Object) return Natural is
   begin
      return Path.Size-1;
   end Segment_Count;

   function Segment_Length (Path: in Object; Segment: in Positive) return Float is
      DeltaX: Float := Path.Values(Segment+1).X-Path.Values(Segment).X;
      DeltaY: Float := Path.Values(Segment+1).Y-Path.Values(Segment).Y;
   begin
      return Sqrt(DeltaX**2+DeltaY**2);
   end Segment_Length;

   procedure Draw (Path: in Object; Color: in Color_Type := Light_Green) is
   begin
      for I in 1..Path.Size loop
         Draw_Line(X1 => Integer(Path.Values(I).X),
                   Y1 => Integer(Path.Values(I).Y),
                   X2 => Integer(Path.Values(I).X),
                   y2 => Integer(Path.Values(I).Y),
                   Hue => Color);
      end loop;
   end Draw;

end Path;
