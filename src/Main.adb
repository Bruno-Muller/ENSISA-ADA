with Adagraph;
with Site;
with Robot;
with Path;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with Place_Randomizer;

with Place_Resource_Pool;

procedure Main is

   type Robot_Table is array(Integer range <>) of access Robot.Object;

   Randomized_Input : Site.Input_Places := Place_Randomizer.Random_Input;
   Randomized_Output : Site.Output_Places := Place_Randomizer.Random_Output;

   My_Robot_Table: Robot_Table(1..6) := (new Robot.Object,
                                         new Robot.Object(1, null, Adagraph.Blue),
                                         new Robot.Object(2, null, Adagraph.Red),
                                         new Robot.Object(3, null,  Adagraph.Cyan),
                                         new Robot.Object(4, null, Adagraph.Magenta),
                                         new Robot.Object(5, null, Adagraph.Yellow));

   Request1: Place_Resource_Pool.Request_Map := (Site.I1 | Site.R1 | Site.R2 | Site. O2 | Site.C => True, others => False);
   Request2: Place_Resource_Pool.Request_Map := (Site.I2 | Site.R1 | Site.R2 | Site. O1 | Site.C => True, others => False);


begin




   Place_Resource_Pool.Acquire(Map => Request1);
   Place_Resource_Pool.Release(Site.I1);
   Place_Resource_Pool.Release(Site.R1);
   Place_Resource_Pool.Release(Site.C);
   Place_Resource_Pool.Release(Site.R2);
   Place_Resource_Pool.Release(Site.O2);

   Place_Resource_Pool.Acquire(Map => Request2);
   Place_Resource_Pool.Release(Site.I2);
   Place_Resource_Pool.Release(Site.R2);
   Place_Resource_Pool.Release(Site.C);
   Place_Resource_Pool.Release(Site.R1);
   Place_Resource_Pool.Release(Site.O1);


   My_Robot_Table(3).Go(From => Site.I1 , To   => Site.O2 );

   for I in My_Robot_Table'First..My_Robot_Table'Last loop
      Randomized_Input := Place_Randomizer.Random_Input;
      Randomized_Output := Place_Randomizer.Random_Output;
      select
         My_Robot_Table(I).Go(From => Randomized_Input , To   => Randomized_Output );
      or
         delay 3.5;
         if I=My_Robot_Table'Last then
            My_Robot_Table(1).Go(From => Randomized_Input, To   => Randomized_Output);
         else
            My_Robot_Table(I+1).Go(From => Randomized_Input, To   => Randomized_Output);
         end if;
      end select;
   end loop ;



      for I in My_Robot_Table'First..My_Robot_Table'Last loop
         My_Robot_Table(I).Shutdown;
      end loop ;

   Adagraph.Destroy_Graph_Window;

end Main ;
