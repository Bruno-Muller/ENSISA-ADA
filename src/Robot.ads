with Adagraph; use Adagraph;
with Ada.Calendar; use Ada.Calendar;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Site;
with Generic_Mailbox;

package Robot is

   type State_Type is (Ready, Following, Shutdown);
   subtype Robot_Id is Natural range 0..50;

   package Robot_Mailbox is new Generic_Mailbox(Resource_Id => Robot_Id);

   task type Object(Id: Robot_Id := 0; Mission_Done: access Robot_Mailbox.Mailbox := null; Color: Color_Type := Light_Green) is
      entry Go(From: Site.Input_Places; To: Site.Output_Places);
      entry Shutdown;
   end Object;

   Radius: constant Float := 16.0;

end Robot;
