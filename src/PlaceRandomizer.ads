with Site; use Site;

package PlaceRandomizer is

   type Interval is range 1..6;

   function Random_Input return Places_Names;
   function Random_Output return Places_Names;

end PlaceRandomizer;
