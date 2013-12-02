--WITH ...;
--USE ...;

package body Path is

   function Value (From: Points) return Object is
   begin
       return Null_Path; -- TODO
   end Value;

   function "&" (Left: in Object ; Right: in Object) return Object is
   begin
      return Left; -- TODO
   end "&";

   function "&" (Left: in Object; Right: in Point) return Object is
   begin
      return Left; -- TODO
   end "&";

   function "&" (Left: in Point; Right: in Object) return Object is
   begin
      return Right; -- TODO
   end "&";

   procedure Add (Path: in out Object; P: in Point) is
   begin
      -- TODO
   end Add;

   function Segment_Count (Path: in Object) return Natural is
   begin
      return 0; -- TODO
   end Segment_Count;

   function Segment_Length (Path: in Object; Segment: in Positive) return Float is
   begin
      return 0.0;
   end Segment_Length;

   procedure Draw (Path: in Object; Color: in Color_Type := Light_Green) is
   begin
      -- TODO
   end Draw;

end Path;
