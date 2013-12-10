with Adagraph; use Adagraph;
with Site;
with Robot;
with Path;
with Site;


procedure Main is
   MyRobot1: Robot.Object;
   MyRobot2: Robot.Object(Blue);
   MyRobot3: Robot.Object(Red);
   MyRobot4: Robot.Object(Adagraph.Cyan);
   MyRobot5: Robot.Object(Adagraph.Magenta);
   MyRobot6: Robot.Object(Adagraph.Yellow);
begin

   Site.Safely.Draw_Site;

   MyRobot1.Go(From => Site.I1, To   => Site.O2);
   MyRobot2.Go(From => Site.I2, To   => Site.O4);

   MyRobot3.Go(From => Site.I3, To   => Site.O6);

   MyRobot4.Go(From => Site.I4, To   => Site.O3);
   MyRobot5.Go(From => Site.I5, To   => Site.O3);

   Adagraph.Destroy_Graph_Window;

end Main ;
