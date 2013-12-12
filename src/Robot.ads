with Adagraph; use Adagraph;
with Ada.Calendar; use Ada.Calendar;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Site;

package Robot is

   type State_Type is (Ready, Following, Shutdown);

   task type Object(Color: Color_Type := Light_Green) is
      entry Go(From: Site.Input_Places; To: Site.Output_Places);
      entry Shutdown;
   end Object;

private
   Radius: constant Float := 16.0;
end Robot;
