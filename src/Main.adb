with Adagraph; use Adagraph;
with Site;
with Robot;
with Path;
with PlaceRandomizer;


procedure Main is

   type Robot_Point is access Robot.Object;
   type RobotTable is array(Integer range <>) of Robot_Point;

   i : Integer := 0;

   newInput : Site.Places_Names := PlaceRandomizer.Random_Input;
   newOutput : Site.Places_Names := PlaceRandomizer.Random_Output;

    Robot_Table: RobotTable(1..6) := (  1 => new Robot.Object,
                                  2 => new Robot.Object(Blue),
                                  3 => new Robot.Object(Red),
                                  4 => new Robot.Object(Adagraph.Cyan),
                                  5 => new Robot.Object(Adagraph.Magenta),
                                  6 => new Robot.Object(Adagraph.Yellow));

begin

   Site.Safely.Draw_Site;

   i := 1;
   while i <= Robot_Table'Length loop
      newInput := PlaceRandomizer.Random_Input;
      newOutput := PlaceRandomizer.Random_Output;
      select
         Robot_Table(i).Go(From => newInput , To   => newOutput );
      or
         delay 0.5;
         Robot_Table(i+1).Go(From => newInput, To   => newOutput);
      end select;
      i := i + 1 ;
   end loop ;

   Adagraph.Destroy_Graph_Window;

end Main ;
