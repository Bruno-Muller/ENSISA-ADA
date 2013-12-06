with Site;

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
   begin
      return Object'(Size => Left.Size+1, Values => Left.Values & Right);
   end "&";

   function "&" (Left: in Point; Right: in Object) return Object is
   begin
      return Object'(Size => Right.Size+1, Values => Left & Right.Values);
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

   function X (Path: in Object; Segment: in Positive; K: in Float) return Float is
   begin
      return Path.Values(Segment).X + K * (Path.Values(Segment+1).X-Path.Values(Segment).X);
   end X;

   function Y (Path: in Object; Segment: in Positive; K: in Float) return Float is
   begin
      return Path.Values(Segment).Y + K * (Path.Values(Segment+1).Y-Path.Values(Segment).Y);
   end Y;

   function XY (Path: in Object; Segment: in Positive; K: in Float) return Point is
   begin
      return Point'(X => X(Path => Path, Segment => Segment, K => K),
                   Y => Y(Path => Path, Segment => Segment, K => K));
   end XY;

end Path;
