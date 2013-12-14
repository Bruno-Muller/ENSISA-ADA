with Robot.Trajectory;
with Robot.Trajectory.Safe;

package body Robot is

   task body Object is
      Next: Ada.Calendar.Time := Ada.Calendar.Clock;
      Counter: Integer := 0;
      State: State_Type := Ready;
      Mouth_Opened: Boolean := False;
      Its_Trajectory: Trajectory.Safe.Object;
   begin
      loop
         select
            when State=Ready => accept Go(From: Site.Input_Places; To: Site.Output_Places) do
                  State := Following;

                  Trajectory.Safe.Open(Sf_Trj => Its_Trajectory,
                                  From => From,
                                  To => To,
                                  Speed => 75.0);
               end Go;

         or
            when State=Ready => accept Shutdown do
                  State:=Shutdown;
               end Shutdown;
         end select;

         exit when State=Shutdown;

         Site.Safely.Draw_Path(Pth => Trajectory.Safe.Get_Trajectory(Its_Trajectory).Route,
                               Clr => Color);

         Next := Ada.Calendar.Clock;
         while not Trajectory.At_End(Trajectory.Safe.Get_Trajectory(Its_Trajectory)) loop
            Next := Next + 0.05;

            Site.Safely.Draw_Robot(Pnt    =>  Trajectory.XY(Trajectory.Safe.Get_Trajectory(Its_Trajectory)),
                                   Radius => Radius,
                                   Direction    => Trajectory.Direction(Trajectory.Safe.Get_Trajectory(Its_Trajectory)),
                                   Mouth_Opened    => Mouth_Opened,
                                   Clr    => Color);
            delay until Next;
            Site.Safely.Hide_Robot(Pnt    => Trajectory.XY(Trajectory.Safe.Get_Trajectory(Its_Trajectory)),
                                   Radius => Radius);
            if Counter=7 then
               Counter:=0;
               Mouth_Opened := not Mouth_Opened;
            end if;

            Counter := Counter + 1;
            Trajectory.Safe.Next(Sf_Trj => Its_Trajectory, DeltaT => 0.05);
         end loop;

         Trajectory.Safe.Close(Sf_Trj => Its_Trajectory);

         State := Ready;

      end loop;
   end Object;

end Robot;
