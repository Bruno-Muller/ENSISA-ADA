with Site;
with Site.Places_Path;
with Place_Resource_Pool;
with Ada.Text_IO;

package body Robot.Trajectory.Safe is


   procedure Open(Sf_Trj: in out Object; From: Site.Input_Places; To: Site.Output_Places; Speed: in Float) is
      Request: Pool.Request_Map := (others => False);
   begin
      Sf_Trj.Plc := Site.Places_Path.Open(From => From, To => To);
      Sf_Trj.From := From;
      Sf_Trj.To := To;

      Site.Places_Path.Start(Sf_Trj.Plc);
      while not Site.Places_Path.At_End(Sf_Trj.Plc) loop
         Request(Site.Places_Path.Value(Sf_Trj.Plc)) := True;
         Site.Places_Path.Next(Sf_Trj.Plc);
      end loop;
      Pool.Acquire(Request);

      Site.Places_Path.Start(Sf_Trj.Plc); -- TODO plus tard

      Robot.Trajectory.Open(Trj   => Sf_Trj.Trj,
                            From  => From,
                            To    => To,
                            Speed => Speed);

      Sf_Trj.In_Place := True;

   end Open;

   procedure Next(Sf_Trj: in out Object; DeltaT: in Float) is
      Pnt: Path.Point;
   begin
      Robot.Trajectory.Next(Trj    => Sf_Trj.Trj,
                            DeltaT => DeltaT);

      Pnt := Robot.Trajectory.XY(Sf_Trj.Trj);

      if not Site.Robot_Intersects(Site.Places_Path.Value(Sf_Trj.Plc),Pnt.X, Pnt.Y) and Sf_Trj.In_Place then
         Sf_Trj.In_Place := False;
         Pool.Release(Site.Places_Path.Value(Sf_Trj.Plc));
         Site.Places_Path.Next(Sf_Trj.Plc);
      elsif Site.Robot_Intersects(Site.Places_Path.Value(Sf_Trj.Plc),Pnt.X, Pnt.Y) and not Sf_Trj.In_Place then
          Sf_Trj.In_Place := True;
      end if;

   end Next;

   procedure Close(Sf_Trj: in out Object) is
      Request: Pool.Request_Map := (others => False);
   begin
      Pool.Release(Sf_Trj.To);
   end Close;

   function Get_Trajectory(Sf_Trj: in out Object) return Robot.Trajectory.Object is
   begin
      return Sf_Trj.Trj;
   end Get_Trajectory;


end Robot.Trajectory.Safe;
