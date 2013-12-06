package body Robot is

   task body Object is
      Next: Ada.Calendar.Time := Clock;
      State: State_Type := Ready;
      Mouth: Mouth_State := Closed;
   begin
      select
         when State=Ready => accept Follow(P: Path.Object) do
               State := Following;
               Next := Ada.Calendar.Clock;
               for I in 1..Path.Segment_Count(P) loop
                  for DeltaK in 0..9 loop
                     Next := Next + 0.25;
                     Robot.Draw(P => Path.XY(Path => P, Segment => I, K => (Float(DeltaK)/10.0)),
                                Next_Point => Path.XY(Path => P, Segment => I, K => (Float(DeltaK+1)/10.0)),
                                Mouth => Mouth,
                                Color => Color);
                     delay until Next;
                     Robot.Draw(P => Path.XY(Path => P, Segment => I, K => (Float(DeltaK)/10.0)),
                                Next_Point => Path.XY(Path => P, Segment => I, K => (Float(DeltaK+1)/10.0)),
                                Mouth => Mouth,
                                Color => Black);
                     if Mouth=Opened then
                        Mouth:=Closed;
                     else
                        Mouth:=Opened;
                     end if;
                  end loop;
               end loop;
               State := Ready;
            end Follow;
      or
         when State=Ready => accept Shutdown do
               State := Ready;
            end Shutdown;
      end select;
   end Object;

   procedure Draw(P: in Point; Next_Point: in Point; Mouth: in Mouth_State; Color: in Color_Type) is
      DeltaX: Float := Next_Point.X - P.X;
      DeltaY: Float := Next_Point.Y - P.Y;
      Length: Float := Sqrt(DeltaX**2+DeltaY**2);
      DirX: Float := DeltaX/Length;
      DirY: Float := DeltaY/Length;
      Theta: Float;
   begin
      Adagraph.Draw_Circle(X => Integer(P.X), Y => Integer(P.Y), Radius => Integer(Radius), Hue => Color, Filled => Adagraph.Fill);
      if (Mouth=Opened) then
         for I in -10..10 loop
            Theta := Float(I*3)/180.0*3.14159265;
            Draw_Line(X1 => Integer(P.X),
                      Y1 => Integer(P.Y),
                      X2 => Integer(P.X + Radius * (DirX * Cos(Theta) - DirY * Sin(Theta))),
                      Y2 => Integer(P.Y + Radius * (DirX * Sin(Theta) + DirY * Cos(Theta))),
                      Hue => Black);
         end loop;
      end if;
   end Draw;

end Robot;
