with Site; use Site;
with Site.Places_Path;
with Place_Resource_Pool;
with Ada.Text_IO;

package body Robot.Trajectory.Safe is


   procedure Open(Sf_Trj: in out Object; From: Site.Input_Places; To: Site.Output_Places; Speed: in Float) is
      Plc: Site.Places_Path.Object := Site.Places_Path.Open(From => From, To => To);
      Pth: Site.Places_Path.Places := Site.Places_Path.Values(Plc);
      Request: Pool.Request_Map := (others => False);
   begin
      Sf_Trj.Plc := Plc;
      Sf_Trj.From := From;
      Sf_Trj.To := To;
      Sf_Trj.First_Next := True;

--        for P in Pth'First..Pth'Last loop
--              Request(Pth(P)) := True;
--        end loop;
--
--        Pool.Acquire(Request);
Pool.Acquire(From);

      Robot.Trajectory.Open(Trj   => Sf_Trj.Trj,
                            From  => From,
                            To    => To,
                            Speed => 0.0);

      Sf_Trj.In_Place := True;

   end Open;

   procedure Next(Sf_Trj: in out Object; DeltaT: in Float) is
      Pth: Site.Places_Path.Places := Site.Places_Path.Values(Sf_Trj.Plc);
      Request: Pool.Request_Map := (others => False);
      Pnt: Path.Point;
   begin
            if Sf_Trj.First_Next=True then
               Ada.Text_IO.Put_Line("Input_Place");

               for P in Pth'First..Pth'Last loop
                  if Pth(P)/=Sf_Trj.From then
                     Request(Pth(P)) := True;
                  end if;
               end loop;
         Pool.Acquire(Request);
         Ada.Text_IO.Put_Line("Acquired");
         Sf_Trj.First_Next := False;
         Sf_Trj.Trj.Speed := 75.0;

            end if;



      Robot.Trajectory.Next(Trj    => Sf_Trj.Trj,
                            DeltaT => DeltaT);

      Pnt := Robot.Trajectory.XY(Sf_Trj.Trj);

      if not Site.Robot_Intersects(Site.Places_Path.Value(Sf_Trj.Plc),Pnt.X, Pnt.Y) and Sf_Trj.In_Place then
         Sf_Trj.In_Place := False;
         Pool.Release(Site.Places_Path.Value(Sf_Trj.Plc));
         Site.Places_Path.Next(Sf_Trj.Plc);
         Ada.Text_IO.Put_Line("next");
      elsif Site.Robot_Intersects(Site.Places_Path.Value(Sf_Trj.Plc),Pnt.X, Pnt.Y) and not Sf_Trj.In_Place then
         Sf_Trj.In_Place := True;
      end if;

   end Next;

   procedure Close(Sf_Trj: in out Object) is
      Pth: Site.Places_Path.Places := Site.Places_Path.Values(Sf_Trj.Plc);
      Request: Pool.Request_Map := (others => False);
   begin
            for P in Pth'First..Pth'Last loop
            Request(Pth(P)) := True;
      end loop;
      Pool.Release(Request);

      Ada.Text_IO.Put_Line("close");
   end Close;

   function Get_Trajectory(Sf_Trj: in out Object) return Robot.Trajectory.Object is
   begin
      return Sf_Trj.Trj;
   end Get_Trajectory;


end Robot.Trajectory.Safe;
