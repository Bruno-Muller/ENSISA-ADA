with Adagraph; use Adagraph;
with Site;
with Robot;
with Path;
with PlaceRandomizer;
with Ada.Text_IO;
with Ada.Integer_Text_IO;


procedure Main is

   type Robot_Table is array(Integer range <>) of access Robot.Object; -- access Robot.Object;

   I : Integer := 0;

   Randomized_Input : Site.Places_Names := PlaceRandomizer.Random_Input;
   Randomized_Output : Site.Places_Names := PlaceRandomizer.Random_Output;


   My_Robot_Table: Robot_Table(1..6) := (new Robot.Object,
                     new Robot.Object(Blue),
                     new Robot.Object(Red),
                     new Robot.Object(Adagraph.Cyan),
                     new Robot.Object(Adagraph.Magenta),
                     new Robot.Object(Adagraph.Yellow));


begin

   My_Robot_Table(3).Go(From => Site.I1 , To   => Site.O2 );

   for I in 1..My_Robot_Table'Length loop
      Randomized_Input := PlaceRandomizer.Random_Input;
      Randomized_Output := PlaceRandomizer.Random_Output;
      select
         My_Robot_Table(I).Go(From => Randomized_Input , To   => Randomized_Output );
         Ada.Text_IO.Put("Robot #");
         Ada.Integer_Text_IO.Put(I, 1);
         Ada.Text_IO.Put_Line(" OK");
      or
         delay 3.5;
         Ada.Text_IO.Put("Robot #");
         Ada.Integer_Text_IO.Put(I);
         Ada.Text_IO.Put_Line(" not OK");
         if I=My_Robot_Table'Length then
            Ada.Text_IO.Put("Trying with Robot #");
            Ada.Integer_Text_IO.Put(1, 1);
            Ada.Text_IO.Put_Line("");
            My_Robot_Table(1).Go(From => Randomized_Input, To   => Randomized_Output);
         else
            Ada.Text_IO.Put("Trying with Robot #");
            Ada.Integer_Text_IO.Put(I, 1);
            Ada.Text_IO.Put_Line("");
            My_Robot_Table(I+1).Go(From => Randomized_Input, To   => Randomized_Output);
         end if;
      end select;
   end loop ;



   for I in 1..My_Robot_Table'Length loop
      Ada.Text_IO.Put("Shutdown robot #");
      Ada.Integer_Text_IO.Put(I, 1);
      Ada.Text_IO.Put_Line("");
      My_Robot_Table(I).Shutdown;
   end loop ;

   Ada.Text_IO.Put_Line("Before Destroy_Graph_Window");
   Adagraph.Destroy_Graph_Window;
   Ada.Text_IO.Put_Line("After Destroy_Graph_Window");

end Main ;
