with Site; use Site;
with Site.Places_Path;

package body Robot.Trajectory is

   function Route(Trajectory_Object: in Object) return Path.Object is
   begin
      return Trajectory_Object.Route;
   end Route;

   procedure Open(Trajectory_Object: in out Object; From: Site.Input_Places; To: Site.Output_Places; Speed: in Float) is
      Pth : Site.Places_Path.Places := Site.Places_Path.Values(Site.Places_Path.Open(From => From, To => To));
   begin
      Trajectory_Object.Route := Path.Null_Path;
      Trajectory_Object.At_End := False;
      Trajectory_Object.Segment := 1;
      Trajectory_Object.K := 0.0;
      Trajectory_Object.Speed := Speed;

      for P in Pth'First..Pth'Last loop
         Path.Add(Trajectory_Object.Route, Site.Get_Point(Pth(P)));
      end loop;

   end Open;

   function X(Trajectory_Object: in Object) return Float is
   begin
      return Path.X(Path => Trajectory_Object.Route,
                    Segment => Trajectory_Object.Segment,
                    K => Trajectory_Object.K);
   end X;

   function Y(Trajectory_Object: in Object) return Float is
   begin
      return Path.Y(Path => Trajectory_Object.Route,
                    Segment => Trajectory_Object.Segment,
                    K => Trajectory_Object.K);
   end Y;

   function XY(Trajectory_Object: in Object) return Path.Point is
   begin
      return Path.Point'(X => Trajectory.X(Trajectory_Object),
                         Y => Trajectory.Y(Trajectory_Object));
   end XY;

   function Direction(Trajectory_Object: in Object) return Path.Vector is
      X1: Float := Path.X(Path => Trajectory_Object.Route, Segment => Trajectory_Object.Segment, K => 0.0);
      X2: Float := Path.X(Path => Trajectory_Object.Route, Segment => Trajectory_Object.Segment, K => 1.0);
      Y1: Float := Path.Y(Path => Trajectory_Object.Route, Segment => Trajectory_Object.Segment, K => 0.0);
      Y2: Float := Path.Y(Path => Trajectory_Object.Route, Segment => Trajectory_Object.Segment, K => 1.0);
      DeltaX: Float := X2 - X1;
      DeltaY: Float := Y2 - Y1;
      Length: Float := Sqrt(DeltaX**2+DeltaY**2);
   begin
      return Path.Vector'(X => DeltaX/Length, Y => DeltaY/Length);
   end Direction;

   procedure Next(Trajectory_Object: in out Object; DeltaT: in Float) is
      DeltaK: Float := Trajectory_Object.Speed/Path.Segment_Length(Path => Trajectory_Object.Route, Segment => Trajectory_Object.Segment)*DeltaT;
   begin
      if not Trajectory_Object.At_End then
         Trajectory_Object.K := Trajectory_Object.K + DeltaK;
         if Trajectory_Object.K>1.0 then
            Trajectory_Object.K := 0.0;
            if (Trajectory_Object.Segment+1)>Path.Segment_Count(Path => Trajectory_Object.Route) then
               Trajectory_Object.At_End := True;
            else
               Trajectory_Object.Segment := Trajectory_Object.Segment + 1;
            end if;
         end if;
      end if;
   end Next;

   function At_End(Trajectory_Object: in Object) return Boolean is
   begin
      return Trajectory_Object.At_End;
   end At_End;

   procedure Close is
   begin
      null;
   end Close;


end Robot.Trajectory;
