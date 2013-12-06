with Path; use Path;

package Robot.Trajectory is

   type Object is tagged private;

   function Route(T: in Object) return Path.Object;
   procedure Open(T: in out Object; P: in Path.Object; Speed: in Float);
   function X(T: in Object) return Float;
   function Y(T: in Object) return Float;
   function XY(T : in Object) return Point;
   function Direction(T: in Object) return Vector;

   procedure Next(T: in out Object; DeltaT: in Float);
   function At_End(T: in Object) return Boolean;

   procedure Close;

private
   type Object is tagged record
      Route: Path.Object;
      Speed: Float := 0.0;
      Segment: Positive := 1;
      K: Float := 0.0;
      At_End: Boolean := False;
   end record;

end Robot.Trajectory;
