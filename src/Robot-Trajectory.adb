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

   function XY(T: in Object) return Point is
   begin
      return Point'(X => Trajectory.X(T),
                    Y => Trajectory.Y(T));
   end XY;

   function Direction(T: in Object) return Vector is
      X1: Float := Path.X(Path => T.Route, Segment => T.Segment, K => 0.0);
      X2: Float := Path.X(Path => T.Route, Segment => T.Segment, K => 1.0);
      Y1: Float := Path.Y(Path => T.Route, Segment => T.Segment, K => 0.0);
      Y2: Float := Path.Y(Path => T.Route, Segment => T.Segment, K => 1.0);
      DeltaX: Float := X2 - X1;
      DeltaY: Float := Y2 - Y1;
      Length: Float := Sqrt(DeltaX**2+DeltaY**2);
   begin
      return Vector'(X => DeltaX/Length, Y => DeltaY/Length);
   end Direction;

   procedure Next(T: in out Object; DeltaT: in Float) is
      DeltaK: Float := T.Speed/Path.Segment_Length(Path => T.Route, Segment => T.Segment)*DeltaT;
   begin
      if not T.At_End then
         T.K := T.K + DeltaK;
         if T.K>1.0 then
            T.K := 0.0;
            if (T.Segment+1)>Path.Segment_Count(Path => T.Route) then
               T.At_End := True;
            else
               T.Segment := T.Segment + 1;
            end if;
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
