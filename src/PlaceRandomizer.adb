with Ada.Numerics.Discrete_Random;
with Site;

package body PlaceRandomizer is

   package Randomisation is new Ada.Numerics.Discrete_Random(Interval);
   use Randomisation;
   G : Generator;



   function Random_Input return Places_Names is
   begin

      case  Random(G) is
         when 1 => return Site.I1;
         when 2 => return Site.I2;
         when 3 => return Site.I3;
         when 4 => return Site.I4;
         when 5 => return Site.I5;
         when 6 => return Site.I6;
      end case;
   end Random_Input ;

   function Random_Output return Places_Names is
   begin
      case Random(G) is
         when 1 => return Site.O1;
         when 2 => return Site.O2;
         when 3 => return Site.O3;
         when 4 => return Site.O4;
         when 5 => return Site.O5;
         when 6 => return Site.O6;
      end case;
   end Random_Output ;

begin
   reset(G);

end PlaceRandomizer;
