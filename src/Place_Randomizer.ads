with Site; use Site;

package Place_Randomizer is

   type Interval is range 1..6;

   function Random_Input return Places_Names;
   function Random_Output return Places_Names;

end Place_Randomizer;
