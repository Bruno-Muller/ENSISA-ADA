with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Adagraph; use Adagraph;
with Path;


procedure Test_Path is
   MyPath: Path.Object := Path.Null_Path;
   MyPoint: Path.Point := (X => 1.0, y => 2.0);

   X_Max, Y_Max: Integer; X_Char, Y_Char: Integer;
begin

   -- Test Point
   Put("MyPoint.X:");
   Put(MyPoint.X);
   Put_Line("");

   Put("MyPoint.Y:");
   Put(MyPoint.Y);
   Put_Line("");

   MyPoint.X := 10.0;
   MyPoint.Y := 10.0;

   Put("MyPoint.X:");
   Put(MyPoint.X);
   Put_Line("");

   Put("MyPoint.Y:");
   Put(MyPoint.Y);
   Put_Line("");
   -- /Test Point

   Path.Add(Path => MyPath, P => MyPoint);
   Path.Add(Path => MyPath, P => (X => 100.0, Y => 10.0));
   Path.Add(Path => MyPath, P => (X => 100.0, Y => 100.0));
   Path.Add(Path => MyPath, P => (X => 10.0, Y => 100.0));
   Path.Add(Path => MyPath, P => (X => 10.0, Y => 10.0));

   -- Test Path.Object
   Put("Segment_Count:");
   Put(Path.Segment_Count(MyPath));
   Put_Line("");

   for I in 1..Path.Segment_Count(MyPath) loop
      Put("Segment_Length:");
      Put(Path.Segment_Length(MyPath, I));
      Put_Line("");
   end loop;
   -- /Test Path.Object

   -- Test ui
   Adagraph.Create_Sized_Graph_Window(800, 600, X_max, Y_Max, X_Char, Y_Char);
   Adagraph.Set_Window_Title("Test_Path");
   Adagraph.Clear_Window;

   Path.Draw(Path => Mypath);

   for I in 1..Path.Segment_Count(MyPath) loop
      for DeltaK in 0..9 loop
         Adagraph.Draw_Circle(X => Integer(Path.X(Path => MyPath, Segment => I, k => (Float(DeltaK)/10.0))),
                              Y => Integer(Path.Y(Path => MyPath, Segment => I, k => (Float(DeltaK)/10.0))),
                              Radius => 10,Hue => Light_Green, Filled => Adagraph.Fill);
         delay 0.05;
         Adagraph.Draw_Circle(X => Integer(Path.X(Path => MyPath, Segment => I, k => (Float(DeltaK)/10.0))),
                              Y => Integer(Path.Y(Path => MyPath, Segment => I, k => (Float(DeltaK)/10.0))),
                              Radius => 10,Hue => Black, Filled => Adagraph.Fill);
      end loop;
   end loop;

   while not Adagraph.Key_Hit loop
      delay 0.1;
   end loop;

   Adagraph.Destroy_Graph_Window;
   -- /Test ui

end Test_Path ;