with Path; use Path;

package Robot.Trajectory is

   type Object is tagged private;

   function Route(T: in Object) return Path.Object;
   procedure Open(T: Object; P: in Path.Object; Speed: in Float);
   function X(T: in Object) return Float;
   function Y(T: in Object) return Float;
   procedure Next(T: Object; DeltaT: in Float);
   function At_End(T: in Object) return Boolean;

   procedure Close;

private
   type Object is tagged record
      null;
   end record;

end Robot.Trajectory;
