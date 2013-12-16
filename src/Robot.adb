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

                  Trajectory.Safe.Open(Safe_Trajectory => Its_Trajectory,
                                       From => From,
                                       To => To,
                                       Speed => 75.0);
               end Go;

               Site.Safely.Draw_Robot(Pnt    =>  Trajectory.XY(Trajectory.Safe.Get_Trajectory(Its_Trajectory)),
                                      Radius => Radius,
                                      Direction    => Trajectory.Direction(Trajectory.Safe.Get_Trajectory(Its_Trajectory)),
                                      Mouth_Opened    => True,
                                      Clr    => Color);

               Next := Ada.Calendar.Clock;
               while Trajectory.Safe.Is_On_Departure(Its_Trajectory) loop
                  Next := Next + 0.05;
                  delay until Next;
                  Trajectory.Safe.Next(Safe_Trajectory => Its_Trajectory, DeltaT => 0.0);
               end loop;

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



                  if Counter=7 then
                     Counter:=0;
                     Mouth_Opened := not Mouth_Opened;
                  end if;

                  Counter := Counter + 1;

                  delay until Next;
                  Site.Safely.Hide_Robot(Pnt    => Trajectory.XY(Trajectory.Safe.Get_Trajectory(Its_Trajectory)),
                                         Radius => Radius);

                  Trajectory.Safe.Next(Safe_Trajectory => Its_Trajectory, DeltaT => 0.05);


               end loop;

               Trajectory.Safe.Close(Safe_Trajectory => Its_Trajectory);

               State := Ready;

               Mission_Done.Put(Id);

         or
            when State=Ready => accept Shutdown do
                  State:=Shutdown;
               end Shutdown;
         end select;

         exit when State=Shutdown;
      end loop;
   end Object;

end Robot;
