with Site;
with Adagraph;
with Path;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Robot;


procedure Main is
   MyPath: Path.Object := Path.Null_Path;
   MyRobot: Robot.Object;
begin

   Site.Safely.Draw_Site;


   for I in 0..6 loop
      Path.Add(Path => MyPath, P => (X => 400.0 + 200.0 *Cos(Float(I*60-30)/180.0*3.14159265),
                                     Y => 300.0 + 200.0 *Sin(Float(I*60-30)/180.0*3.14159265)));
   end loop;


   Site.Safely.Draw_Path(Pth => MyPath);

   MyRobot.Follow(P => MyPath);


   Adagraph.Destroy_Graph_Window;

end Main ;
