with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Adagraph; use Adagraph;
with Path;
with Robot;

procedure Test_Robot is
   MyPath: Path.Object := Path.Null_Path;
   MyRobot: Robot.Object;

   X_Max, Y_Max: Integer; X_Char, Y_Char: Integer;
begin
   Path.Add(Path => MyPath, P => (X => 100.0, Y => 100.0));
   Path.Add(Path => MyPath, P => (X => 200.0, Y => 100.0));
   Path.Add(Path => MyPath, P => (X => 100.0, Y => 200.0));
   Path.Add(Path => MyPath, P => (X => 200.0, Y => 200.0));

   -- Test ui
   Adagraph.Create_Sized_Graph_Window(800, 600, X_max, Y_Max, X_Char, Y_Char);
   Adagraph.Set_Window_Title("Test_Robot");
   Adagraph.Clear_Window;

   Path.Draw(Path => Mypath);

   MyRobot.Follow(P => MyPath);

   --while not Adagraph.Key_Hit loop
   --   delay 0.1;
   --end loop;

   Adagraph.Destroy_Graph_Window;
   -- /Test ui

end Test_Robot ;
