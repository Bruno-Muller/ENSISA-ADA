with Adagraph; use Adagraph;
with Site;
with Robot;
with Path;
with PlaceRandomizer;
with Ada.Text_IO;
with Ada.Integer_Text_IO;


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

   Robot_Table(3).Go(From => Site.I1 , To   => Site.O2 ); --test critique qui me montre le bug...

   for i in 1..Robot_Table'Length loop
      newInput := PlaceRandomizer.Random_Input;
      newOutput := PlaceRandomizer.Random_Output;
      select
         Robot_Table(i).Go(From => newInput , To   => newOutput );
         Ada.Text_IO.Put("Robot #");
         Ada.Integer_Text_IO.Put(i, 1);
         Ada.Text_IO.Put_Line(" OK");
      or
         delay 0.5;
         Ada.Text_IO.Put("Robot #");
         Ada.Integer_Text_IO.Put(i);
         Ada.Text_IO.Put_Line(" not OK");
         if i=Robot_Table'Length then
            Ada.Text_IO.Put("Trying with Robot #");
            Ada.Integer_Text_IO.Put(1, 1);
            Ada.Text_IO.Put_Line("");
            Robot_Table(1).Go(From => newInput, To   => newOutput);
         else
            Ada.Text_IO.Put("Trying with Robot #");
            Ada.Integer_Text_IO.Put(i, 1);
            Ada.Text_IO.Put_Line("");
            Robot_Table(i+1).Go(From => newInput, To   => newOutput);
         end if;
      end select;
   end loop ;



   for i in 1..Robot_Table'Length loop
      Ada.Text_IO.Put("Shutdown robot #");
      Ada.Integer_Text_IO.Put(i, 1);
      Ada.Text_IO.Put_Line("");
      Robot_Table(i).Shutdown;
   end loop ;

   Ada.Text_IO.Put_Line("Before Destroy_Graph_Window");
   Adagraph.Destroy_Graph_Window;
   Ada.Text_IO.Put_Line("After Destroy_Graph_Window");

end Main ;
