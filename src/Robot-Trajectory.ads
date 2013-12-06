with Path;

package Robot.Trajectory is

   type Object is tagged private;

   function Route(Trj: in Object) return Path.Object;
   procedure Open(Trj: in out Object; From: in Site.Input_Places; To: Site.Output_Places; Speed: in Float);
   function X(Trj: in Object) return Float;
   function Y(Trj: in Object) return Float;
   function XY(Trj : in Object) return Path.Point;
   function Direction(Trj: in Object) return Path.Vector;

   procedure Next(Trj: in out Object; DeltaT: in Float);
   function At_End(Trj: in Object) return Boolean;

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
