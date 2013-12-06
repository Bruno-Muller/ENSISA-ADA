with Robot.Trajectory;

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


                  Robot.Draw(P => Trajectory.XY(Its_Trajectory),
                             Dir => Trajectory.Direction(Its_Trajectory),
                             Mouth => Mouth,
                             Color => Color);
                  delay until Next;
                  Robot.Draw(P => Trajectory.XY(Its_Trajectory),
                             Dir => Trajectory.Direction(Its_Trajectory),
                             Mouth => Closed, -- pour gagner un peu de perf
                             Color => Black);

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

   procedure Draw(P: in Point; Dir: in Vector; Mouth: in Mouth_State; Color: in Color_Type) is
      Theta: Float;
   begin
      Adagraph.Draw_Circle(X => Integer(P.X), Y => Integer(P.Y), Radius => Integer(Radius), Hue => Color, Filled => Adagraph.Fill);
      if (Mouth=Opened) then
         for I in -10..10 loop
            Theta := Float(I*3)/180.0*3.14159265;
            Draw_Line(X1 => Integer(P.X),
                      Y1 => Integer(P.Y),
                      X2 => Integer(P.X + Radius * (Dir.X * Cos(Theta) - Dir.Y * Sin(Theta))),
                      Y2 => Integer(P.Y + Radius * (Dir.X * Sin(Theta) + Dir.Y * Cos(Theta))),
                      Hue => Black);
         end loop;
      end if;
   end Draw;

end Robot;
