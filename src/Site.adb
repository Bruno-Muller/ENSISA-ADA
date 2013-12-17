package body Site is

   function Way_Out(To: Output_Places) return Ring_Places is
   begin
      case To is
         when O1 => return R1;
         when O2 => return R2;
         when O3 => return R3;
         when O4 => return R4;
         when O5 => return R5;
         when O6 => return R6;
      end case;
   end Way_Out;

   function Way_In(From: Input_Places) return Ring_Places is
   begin
      case From is
         when I1 => return R1;
         when I2 => return R2;
         when I3 => return R3;
         when I4 => return R4;
         when I5 => return R5;
         when I6 => return R6;
      end case;
   end Way_In;

   function Next(Place: Ring_Places) return Ring_Places is
   begin
      case Place is
         when R1 => return R2;
         when R2 => return R3;
         when R3 => return R4;
         when R4 => return R5;
         when R5 => return R6;
         when R6 => return R1;
      end case;
   end Next;

   function Previous(Place: Ring_Places) return Ring_Places is
   begin
      case Place is
         when R1 => return R6;
         when R2 => return R1;
         when R3 => return R2;
         when R4 => return R3;
         when R5 => return R4;
         when R6 => return R5;
      end case;
   end Previous;

   function Opposite(Place: Ring_Places) return Ring_Places is
   begin
      case Place is
         when R1 => return R4;
         when R2 => return R5;
         when R3 => return R6;
         when R4 => return R1;
         when R5 => return R2;
         when R6 => return R3;
      end case;
   end Opposite;

   -- retourne la position Point(X,Y) d'une place
   function Get_Point(Pnt: Place_Names) return Path.Point is
   begin
      case Pnt is
         when C => return Center;
         when R1 => return Get_Point(Center, Radius, -30.0);
         when R2 => return Get_Point(Center, Radius, -90.0);
         when R3 => return Get_Point(Center, Radius, -150.0);
         when R4 => return Get_Point(Center, Radius, -210.0);
         when R5 => return Get_Point(Center, Radius, -270.0);
         when R6 => return Get_Point(Center, Radius, -330.0);

         when O1 => return Get_Point(Center, Radius+50.0, -30.0+5.0);
         when O2 => return Get_Point(Center, Radius+50.0, -90.0+5.0);
         when O3 => return Get_Point(Center, Radius+50.0, -150.0+5.0);
         when O4 => return Get_Point(Center, Radius+50.0, -210.0+5.0);
         when O5 => return Get_Point(Center, Radius+50.0, -270.0+5.0);
         when O6 => return Get_Point(Center, Radius+50.0, -330.0+5.0);

         when I1 => return Get_Point(Center, Radius+50.0, -30.0-5.0);
         when I2 => return Get_Point(Center, Radius+50.0, -90.0-5.0);
         when I3 => return Get_Point(Center, Radius+50.0, -150.0-5.0);
         when I4 => return Get_Point(Center, Radius+50.0, -210.0-5.0);
         when I5 => return Get_Point(Center, Radius+50.0, -270.0-5.0);
         when I6 => return Get_Point(Center, Radius+50.0, -330.0-5.0);
      end case;
   end Get_Point;

   -- retourne la position d'un point situé un cercle d'un certain rayon par rapport à un certain angle
   -- utile pour trouver les places et tracer le site
   function Get_Point(Ctr: Path.Point; R: Float; Angle: Float) return Path.Point is
   begin
      return Path.Point'(X => Ctr.X + R * Cos(Angle/180.0*3.14159265),
                         Y => Ctr.Y + R * Sin(Angle/180.0*3.14159265));
   end Get_Point;

   -- retourn la position Point(X,Y) d'une pace de parking
   function Get_Parking_Point(Place: in Natural; Radius: in Float) return Path.Point is
   begin
      return Path.Point'(X => 30.0,
                         Y => 30.0 + Float(Place) * Radius * 3.0);
   end Get_Parking_Point;

   function Robot_Intersects(Place: Place_Names; X: Float; Y: Float) return Boolean is
      Pnt: Path.Point := Get_Point(Pnt => Place);
   begin
      return Sqrt((Pnt.X-X)**2 + (Pnt.Y-Y)**2)<=50.0;
   end Robot_Intersects;

   protected body Safely is

      procedure Draw_Site(Clr: in Color_Type := Dark_Gray) is


         PolyA, PolyB, Tri1, Tri2, Tri3, Som1, Som2: Path.Point;

      begin

         for I in 0..6 loop
            PolyA := Get_Point(Center, Radius, Float(I*60-30)); -- (I)ièm sommet de l'hexagone : la (I)ième place
            PolyB := Get_Point(Center, Radius, Float(I*60+30)); -- (I+1)ièm sommet de l'hexagone : la (I+1)ième place
            Tri1 := Get_Point(Center, 40.0, Float(I*60)); 	-- sommet 1 du triangle par rapport au centre
            Tri2 := Get_Point(PolyA, 40.0, Float(I*60)+120.0); 	-- sommet 2 du trianle par raport à la (I)ième place
            Tri3 := Get_Point(PolyB, 40.0, Float(I*60)+240.0); 	-- sommet 3 du triangle par rapport à la (I+1)ième place
            Som1 := Get_Point(PolyA, 40.0, Float(I*60)+60.0);	-- sommet 1 du segment externe par raport à la (I)ième place
            Som2 := Get_Point(PolyB, 40.0, Float(I*60)+300.0); 	-- sommet 2 du segment externe par raport à la (I+1)ième place

            -- Trace le trigangle
            Adagraph.Draw_Line(X1 => Integer(Tri1.X),
                               Y1 => Integer(Tri1.Y),
                               X2 => Integer(Tri2.X),
                               Y2 => Integer(Tri2.Y),
                               Hue => Clr);


            Adagraph.Draw_Line(X1 => Integer(Tri2.X),
                               Y1 => Integer(Tri2.Y),
                               X2 => Integer(Tri3.X),
                               Y2 => Integer(Tri3.Y),
                               Hue => Clr);

            Adagraph.Draw_Line(X1 => Integer(Tri1.X),
                               Y1 => Integer(Tri1.Y),
                               X2 => Integer(Tri3.X),
                               Y2 => Integer(Tri3.Y),
                               Hue => Clr);

            -- Trace le segment
            Adagraph.Draw_Line(X1 => Integer(Som1.X),
                               Y1 => Integer(Som1.Y),
                               X2 => Integer(Som2.X),
                               Y2 => Integer(Som2.Y),
                               Hue => Clr);
         end loop;

      end Draw_Site;

      procedure Draw_Path(Pth: in Path.Object; Clr: in Color_Type := Light_Green) is
         Pnt: Path.Point;
         Number_Of_Cookies: Integer := 0;
      begin
         for I in 1..Path.Segment_Count(Pth) loop
            Number_Of_Cookies := Integer(Path.Segment_Length(Path => Pth, Segment => I) / 14.0);
            for Cookie in 0..Number_Of_Cookies loop
               Pnt := Path.XY(Path => Pth,
                              Segment => I,
                              K => (Float(Cookie)/Float(Number_Of_Cookies)));

               Adagraph.Draw_Box(X1 => Integer(Pnt.X-2.0),
                                 Y1 => Integer(Pnt.Y-2.0),
                                 X2 => Integer(Pnt.X+2.0),
                                 Y2 => Integer(Pnt.Y+2.0),
                                 Hue => Clr,
                                 Filled => Fill);
            end loop;
         end loop;
      end Draw_Path;

      procedure Draw_Robot(Pnt: in Path.Point; Radius: in Float; Direction: in Path.Vector := Path.Vector'(1.0, 0.0); Mouth_Opened: in Boolean := False; Clr: in Color_Type := Adagraph.White) is
         Theta: Float;
      begin
         Adagraph.Draw_Circle(X => Integer(Pnt.X), Y => Integer(Pnt.Y), Radius => Integer(Radius), Hue => Clr, Filled => Fill);
         if Mouth_Opened then
            for I in -10..10 loop
               Theta := Float(I*3)/180.0*3.14159265;
               Draw_Line(X1 => Integer(Pnt.X),
                         Y1 => Integer(Pnt.Y),
                         X2 => Integer(Pnt.X + Radius * (Direction.X * Cos(Theta) - Direction.Y * Sin(Theta))),
                         Y2 => Integer(Pnt.Y + Radius * (Direction.X * Sin(Theta) + Direction.Y * Cos(Theta))),
                         Hue => Black);
            end loop;
         end if;
      end Draw_Robot;

      procedure Hide_Robot(Pnt: in Path.Point; Radius: in Float) is
      begin
         Adagraph.Draw_Circle(X => Integer(Pnt.X), Y => Integer(Pnt.Y), Radius => Integer(Radius), Hue => Black, Filled => Fill);
      end Hide_Robot;

      procedure Draw_Robot_Park(Place: in Natural; Radius: in Float; Clr: in Color_Type := Light_Green) is
         Pnt: Path.Point := Get_Parking_Point(Place, Radius);
      begin
         Draw_Robot(Pnt          => Pnt,
                    Radius       => Radius,
                    Mouth_Opened => True,
                    Clr => Clr);
      end Draw_Robot_Park;

      procedure Hide_Robot_Park(Place: in Natural; Radius: in Float) is
         Pnt: Path.Point := Get_Parking_Point(Place, Radius);
      begin
         Hide_Robot(Pnt    => Pnt,
                    Radius => Radius);
      end Hide_Robot_Park;

      procedure Draw_Robot_Park_Place(Place: in Natural; Radius: in Float) is
         Pnt: Path.Point := Get_Parking_Point(Place, Radius);
      begin
         Adagraph.Draw_Box(X1 => Integer(Pnt.X - 1.5*Radius),
                           Y1 => Integer(Pnt.Y - 1.5*Radius),
                           X2  => Integer(Pnt.X + 1.5*Radius),
                           Y2  => Integer(Pnt.Y + 1.5*Radius),
                           Hue => Dark_Gray);

         Adagraph.Draw_Line(X1 => Integer(Pnt.X + 1.5*Radius),
                            Y1 => Integer(Pnt.Y - 1.5*Radius),
                            X2  => Integer(Pnt.X + 1.5*Radius),
                            Y2  => Integer(Pnt.Y + 1.5*Radius),
                            Hue => Black);

         Adagraph.Display_Text(X    => Integer(Pnt.X - 1.5*Radius-9.0),
                               Y    => Integer(Pnt.Y + 1.5*Radius-1.0),
                               Text => Integer'Image(Place),
                               Hue  => Dark_Gray);
      end Draw_Robot_Park_Place;

   end Safely;

begin
   Adagraph.Create_Sized_Graph_Window(800, 600, X_max, Y_Max, X_Char, Y_Char);
   Adagraph.Set_Window_Title("PACMAN");
   Adagraph.Clear_Window;

   Site.Safely.Draw_Site;

end Site;
