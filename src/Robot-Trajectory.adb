package body Robot.Trajectory is

   function Route(T: in Object) return Path.Object is
   begin
      return Path.Null_Path;
   end Route;

   procedure Open(T: Object; P: in Path.Object; Speed: in Float) is
   begin
      null;
   end Open;

   function X(T: in Object) return Float is
   begin
      return 0.0;
   end X;

   function Y(T: in Object) return Float is
   begin
      return 0.0;
   end Y;

   procedure Next(T: Object; DeltaT: in Float) is
   begin
      null;
   end Next;

   function At_End(T: in Object) return Boolean is
   begin
      return False;
   end At_End;

   procedure Close is
   begin
      null;
   end Close;

end Robot.Trajectory;
