with Adagraph; use Adagraph;
with Site;
with Robot;
with Path;
with PlaceRandomizer;


procedure Main is

   type Robot_Point is access Robot.Object;
   type RobotTable is array(Integer range <>) of Robot_Point;

    Robot_Table: RobotTable(1..6) := (  1 => new Robot.Object,
                                  2 => new Robot.Object(Blue),
                                  3 => new Robot.Object(Red),
                                  4 => new Robot.Object(Adagraph.Cyan),
                                  5 => new Robot.Object(Adagraph.Magenta),
                                  6 => new Robot.Object(Adagraph.Yellow));

begin

   Site.Safely.Draw_Site;

   Robot_Table(1).Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);
   Robot_Table(2).Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);
   Robot_Table(3).Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);
   Robot_Table(4).Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);
   Robot_Table(5).Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);
   Robot_Table(6).Go(From => PlaceRandomizer.Random_Input, To   => PlaceRandomizer.Random_Output);

   Adagraph.Destroy_Graph_Window;

end Main ;
