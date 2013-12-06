with Robot.Trajectory;

package body Robot is

   task body Object is
      Next: Ada.Calendar.Time := Ada.Calendar.Clock;
      Counter: Integer := 0;
      State: State_Type := Ready;
      Mouth_Opened: Boolean := False;
      Its_Trajectory: Trajectory.Object;
   begin
      select
         when State=Ready => accept Go(From: Site.Input_Places; To: Site.Output_Places) do
               State := Following;
               Trajectory.Open(Trj => Its_Trajectory,
                               From => From,
                               To => To,
                               Speed => 75.0);

               Site.Safely.Draw_Path(Pth => Its_Trajectory.Route,
                                     Clr => Color);

               Next := Ada.Calendar.Clock;
               while not Trajectory.At_End(Its_Trajectory) loop
                  Next := Next + 0.05;

                  Site.Safely.Draw_Robot(Pnt    =>  Trajectory.XY(Its_Trajectory),
                                         Radius => Radius,
                                         Direction    => Trajectory.Direction(Its_Trajectory),
                                         Mouth_Opened    => Mouth_Opened,
                                         Clr    => Color);
                  delay until Next;
                  Site.Safely.Hide_Robot(Pnt    => Trajectory.XY(Its_Trajectory),
                                         Radius => Radius);

                  if Counter=7 then
                     Counter:=0;
                     Mouth_Opened := not Mouth_Opened;
                  end if;

                  Counter := Counter + 1;
                  Trajectory.Next(Trj => Its_Trajectory, DeltaT => 0.05);
               end loop;

               State := Ready;
            end Go;
      or
         when State=Ready => accept Shutdown do
               State := Ready;
            end Shutdown;
      end select;
   end Object;

end Robot;
