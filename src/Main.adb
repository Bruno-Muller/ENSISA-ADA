with Adagraph;
with Site;
with Robot;
with Path;


procedure Main is
   MyPath: Path.Object := Path.Null_Path;
   MyRobot: Robot.Object;
begin

   Site.Safely.Draw_Site;

   Path.Add(Path => MyPath, P => (X => 100.0, Y => 100.0));
   Path.Add(Path => MyPath, P => (X => 500.0, Y => 100.0));
   Path.Add(Path => MyPath, P => (X => 100.0, Y => 500.0));
   Path.Add(Path => MyPath, P => (X => 500.0, Y => 500.0));

   Site.Safely.Draw_Path(Pth => Mypath);




   Adagraph.Destroy_Graph_Window;

end Main ;
