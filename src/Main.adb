with Adagraph; use Adagraph;
with Site;
with Robot;
with Path;
with PlaceRandomizer;


procedure Main is
   MyRobot1: Robot.Object;
   MyRobot2: Robot.Object(Blue);
   MyRobot3: Robot.Object(Red);
   MyRobot4: Robot.Object(Adagraph.Cyan);
   MyRobot5: Robot.Object(Adagraph.Magenta);
   MyRobot6: Robot.Object(Adagraph.Yellow);
begin

   Site.Safely.Draw_Site;

   MyRobot1.Go(From => PlaceRandomizer.Random_Input , To   => PlaceRandomizer.Random_Output );
   MyRobot2.Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);

   MyRobot3.Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);

   MyRobot4.Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);
   MyRobot5.Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);

   Adagraph.Destroy_Graph_Window;

end Main ;
