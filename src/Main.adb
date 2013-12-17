with Adagraph;
with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Place_Randomizer;
with Agency;
with Site; use Site;

with Place_Resource_Pool;

procedure Main is

   -- Les variables utilisées pour les places d'entrée et de sortie calculées
   -- aléatoirement grace a Place_Randomizer
   Randomized_Input : Site.Input_Places := Place_Randomizer.Random_Input;
   Randomized_Output : Site.Output_Places := Place_Randomizer.Random_Output;

begin

   -- On va attribuer des missions
   for I in 1..10 loop

      Randomized_Input := Place_Randomizer.Random_Input;
      Randomized_Output := Place_Randomizer.Random_Output;

      -- On essaie de faire des chemins interresants
      -- Par exemple, aller de I1 à O1 n'est pas pertinant alors
      -- tant que way_in = way_out on cherche des nouvelles places d'entrée et de sortie
      while Site.Way_In(Randomized_Input)=Site.Way_Out(Randomized_Output) loop
         Randomized_Input := Place_Randomizer.Random_Input;
         Randomized_Output := Place_Randomizer.Random_Output;
      end loop;

      -- On demande à l'agence de prendre en charge une mission
      Agency.Handle_Transfer(Randomized_Input, Randomized_Output);

   end loop ;

   -- On ferme l'agence
   Agency.Shutdown;

   delay 2.0;

   -- Ferme la fenêtre adagraph
   Adagraph.Destroy_Graph_Window;

end Main ;
