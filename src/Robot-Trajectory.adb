with Site; use Site;
with Site.Places_Path;
with Ada.Text_IO;

package body Robot.Trajectory is

   function Route(Trj: in Object) return Path.Object is
   begin
      return Trj.Route;
   end Route;

   procedure Open(Trj: in out Object; From: Site.Input_Places; To: Site.Output_Places; Speed: in Float) is
      Pth : Site.Places_Path.Object := Site.Places_Path.Open(From => From, To => To);
   begin
      Trj.Route := Path.Null_Path;
      Trj.At_End := False;
      Trj.Segment := 1;
      Trj.K := 0.0;
      Trj.Speed := Speed;

      while(not Site.Places_Path.At_End(Pth)) loop
         Path.Add(Trj.Route, Site.Get_Point(Site.Places_Path.Value(Pth)));
         Site.Places_Path.Next(Pth);
      end loop;

   end Open;

   function X(Trj: in Object) return Float is
   begin
      return Path.X(Path => Trj.Route,
                    Segment => Trj.Segment,
                    K => Trj.K);
   end X;

   function Y(Trj: in Object) return Float is
   begin
      return Path.Y(Path => Trj.Route,
                    Segment => Trj.Segment,
                    K => Trj.K);
   end Y;

   function XY(Trj: in Object) return Path.Point is
   begin
      return Path.Point'(X => Trajectory.X(Trj),
                         Y => Trajectory.Y(Trj));
   end XY;

   function Direction(Trj: in Object) return Path.Vector is
      X1: Float := Path.X(Path => Trj.Route, Segment => Trj.Segment, K => 0.0);
      X2: Float := Path.X(Path => Trj.Route, Segment => Trj.Segment, K => 1.0);
      Y1: Float := Path.Y(Path => Trj.Route, Segment => Trj.Segment, K => 0.0);
      Y2: Float := Path.Y(Path => Trj.Route, Segment => Trj.Segment, K => 1.0);
      DeltaX: Float := X2 - X1;
      DeltaY: Float := Y2 - Y1;
      Length: Float := Sqrt(DeltaX**2+DeltaY**2);
   begin
      return Path.Vector'(X => DeltaX/Length, Y => DeltaY/Length);
   end Direction;

   procedure Next(Trj: in out Object; DeltaT: in Float) is
      DeltaK: Float := Trj.Speed/Path.Segment_Length(Path => Trj.Route, Segment => Trj.Segment)*DeltaT;
   begin
      if not Trj.At_End then
         Trj.K := Trj.K + DeltaK;
         if Trj.K>1.0 then
            Trj.K := 0.0;
            if (Trj.Segment+1)>Path.Segment_Count(Path => Trj.Route) then
               Trj.At_End := True;
            else
               Trj.Segment := Trj.Segment + 1;
            end if;
         end if;
      end if;
   end Next;

   function At_End(Trj: in Object) return Boolean is
   begin
      return Trj.At_End;
   end At_End;

   procedure Close is
   begin
      null;
   end Close;


end Robot.Trajectory;
