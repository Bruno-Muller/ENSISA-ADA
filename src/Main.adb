with Adagraph; use Adagraph;
with Site;
with Robot;
with Path;
with Site;


procedure Main is
   MyRobot1: Robot.Object;
   MyRobot2: Robot.Object(Blue);
begin

   Site.Safely.Draw_Site;

   MyRobot1.Go(From => Site.I1, To   => Site.O6);
   MyRobot2.Go(From => Site.I4, To   => Site.O1);




   Adagraph.Destroy_Graph_Window;

end Main ;
