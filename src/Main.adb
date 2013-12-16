with Adagraph;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Place_Randomizer;
with Agency;
with Site; use Site;

with Place_Resource_Pool;

procedure Main is

   Randomized_Input : Site.Input_Places := Place_Randomizer.Random_Input;
   Randomized_Output : Site.Output_Places := Place_Randomizer.Random_Output;

begin

   for I in 1..10 loop

      Randomized_Input := Place_Randomizer.Random_Input;
      Randomized_Output := Place_Randomizer.Random_Output;

      while Site.Way_In(Randomized_Input)=Site.Way_Out(Randomized_Output) loop
         Randomized_Input := Place_Randomizer.Random_Input;
         Randomized_Output := Place_Randomizer.Random_Output;
      end loop;

      Agency.Handle_Transfer(Randomized_Input, Randomized_Output);

   end loop ;

   Agency.Shutdown;

   delay 2.0;

   Adagraph.Destroy_Graph_Window;

end Main ;
