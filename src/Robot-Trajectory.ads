with Path;

package Robot.Trajectory is

   type Object is tagged private;

   function Route(Trajectory_Object: in Object) return Path.Object;
   procedure Open(Trajectory_Object: in out Object; From: in Site.Input_Places; To: Site.Output_Places; Speed: in Float);
   function X(Trajectory_Object: in Object) return Float;
   function Y(Trajectory_Object: in Object) return Float;
   function XY(Trajectory_Object : in Object) return Path.Point;

   -- récupère la direction du robot, utile pour tracer la bouche de Pacman dans son sens de déplacement
   function Direction(Trajectory_Object: in Object) return Path.Vector;

   procedure Next(Trajectory_Object: in out Object; DeltaT: in Float);
   function At_End(Trajectory_Object: in Object) return Boolean;

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
