package body Robot.Trajectory is

   function Route(T: in Object) return Path.Object is
   begin
      return T.Route;
   end Route;

   procedure Open(T: in out Object; P: in Path.Object; Speed: in Float) is
   begin
      T.Route := P;
      T.Speed := Speed;
   end Open;

   function X(T: in Object) return Float is
   begin
      return Path.X(Path => T.Route,
                    Segment => T.Segment,
                    K => T.K);
   end X;

   function Y(T: in Object) return Float is
   begin
      return Path.Y(Path => T.Route,
                    Segment => T.Segment,
                    K => T.K);
   end Y;

   procedure Next(T: in out Object; DeltaT: in Float) is
      DeltaK: Float := T.Speed/Path.Segment_Length(Path => T.Route, Segment => T.Segment)*DeltaT;
   begin
      T.K := T.K + DeltaK;
      if T.K>1.0 then
         T.K := 0.0;
         T.Segment := T.Segment + 1;
         if T.Segment>Path.Segment_Count(Path => T.Route) then
            T.At_End := True;
         end if;
      end if;
   end Next;

   function At_End(T: in Object) return Boolean is
   begin
      return T.At_End;
   end At_End;

   procedure Close is
   begin
      null;
   end Close;

end Robot.Trajectory;
