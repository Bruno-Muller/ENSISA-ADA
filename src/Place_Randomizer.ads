with Site;

package Place_Randomizer is

   type Interval is range 1..6;

   function Random_Input return Site.Input_Places;
   function Random_Output return Site.Output_Places;

end Place_Randomizer;
