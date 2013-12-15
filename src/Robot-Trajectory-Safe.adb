with Site; use Site;
with Site.Places_Path;
with Place_Resource_Pool;

package body Robot.Trajectory.Safe is

   procedure Open(Safe_Trajectory: in out Object; From: Site.Input_Places; To: Site.Output_Places; Speed: in Float) is
   begin
      Safe_Trajectory.Place_Path_Object := Site.Places_Path.Open(From => From, To => To);
      Safe_Trajectory.From := From;
      Safe_Trajectory.To := To;
      Safe_Trajectory.On_Departure := True;
      Safe_Trajectory.In_Place := True;

      Pool.Acquire(From);

      Robot.Trajectory.Open(Trajectory_Object => Safe_Trajectory.Trajectory_Object,
                            From  => From,
                            To    => To,
                            Speed => Speed);
   end Open;

   procedure Next(Safe_Trajectory: in out Object; DeltaT: in Float) is
      Pth: Site.Places_Path.Places := Site.Places_Path.Values(Safe_Trajectory.Place_Path_Object);
      Request: Pool.Request_Map := (others => False);
      Pnt: Path.Point;
   begin
      if Safe_Trajectory.On_Departure=True then
         for P in Pth'First..Pth'Last loop
            if Pth(P)/=Safe_Trajectory.From then
               Request(Pth(P)) := True;
            end if;
         end loop;
         Pool.Acquire(Request);
         Safe_Trajectory.On_Departure := False;
      end if;

      Robot.Trajectory.Next(Trajectory_Object => Safe_Trajectory.Trajectory_Object,
                            DeltaT => DeltaT);

      Pnt := Robot.Trajectory.XY(Safe_Trajectory.Trajectory_Object);
      if not Site.Robot_Intersects(Site.Places_Path.Value(Safe_Trajectory.Place_Path_Object),Pnt.X, Pnt.Y) and Safe_Trajectory.In_Place then
         Safe_Trajectory.In_Place := False;
         Pool.Release(Site.Places_Path.Value(Safe_Trajectory.Place_Path_Object));
         Site.Places_Path.Next(Safe_Trajectory.Place_Path_Object);
      elsif Site.Robot_Intersects(Site.Places_Path.Value(Safe_Trajectory.Place_Path_Object),Pnt.X, Pnt.Y) and not Safe_Trajectory.In_Place then
         Safe_Trajectory.In_Place := True;
      end if;

   end Next;

   procedure Close(Safe_Trajectory: in out Object) is
   begin
      Pool.Release(Safe_Trajectory.To);
   end Close;

   function Is_On_Departure(Safe_Trajectory: in Object) return Boolean is
   begin
      return Safe_Trajectory.On_Departure;
   end Is_On_Departure;

   function Get_Trajectory(Safe_Trajectory: in out Object) return Robot.Trajectory.Object is
   begin
      return Safe_Trajectory.Trajectory_Object;
   end Get_Trajectory;

end Robot.Trajectory.Safe;
