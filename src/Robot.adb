with Robot.Trajectory;
with Site;

package body Robot is

   task body Object is
      Next: Ada.Calendar.Time := Clock;
      Counter: Integer := 0;
      State: State_Type := Ready;
      Mouth: Mouth_State := Closed;
      Its_Trajectory: Trajectory.Object;
   begin
      select
         when State=Ready => accept Follow(P: Path.Object) do
               State := Following;
               Trajectory.Open(T => Its_Trajectory,
                               P => P,
                               Speed => 75.0);

               Next := Ada.Calendar.Clock;
               while not Trajectory.At_End(Its_Trajectory) loop
                  Next := Next + 0.05;

                  Site.Safely.Draw_Robot(Pnt    =>  Trajectory.XY(Its_Trajectory),
                                         Radius => Radius,
                                         Dir    => Trajectory.Direction(Its_Trajectory),
                                         Mth    => Mouth,
                                         Clr    => Color);
                  delay until Next;
                  Site.Safely.Hide_Robot(Pnt    => Trajectory.XY(Its_Trajectory),
                                         Radius => Radius);

                  if Counter=7 then
                     Counter:=0;
                     if Mouth=Opened then
                        Mouth:=Closed;
                     else
                        Mouth:=Opened;
                     end if;
                  end if;

                  Counter := Counter + 1;
                  Trajectory.Next(T => Its_Trajectory, DeltaT => 0.05);
               end loop;

               State := Ready;
            end Follow;
      or
         when State=Ready => accept Shutdown do
               State := Ready;
            end Shutdown;
      end select;
   end Object;

end Robot;
