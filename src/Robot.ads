with Adagraph; use Adagraph;
with Ada.Calendar; use Ada.Calendar;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Site;
with Generic_Mailbox;

package Robot is

   type State_Type is (Ready, Following, Shutdown);
   subtype Robot_Id is Natural range 1..6;

   package Robot_Mailbox is new Generic_Mailbox(Message => Robot_Id);

   task type Object(Id: Robot_Id := 1; Mission_Done: not null access Robot_Mailbox.Object := new Robot_Mailbox.Object(1); Color: Color_Type := Light_Green) is
      entry Go(From: Site.Input_Places; To: Site.Output_Places);
      entry Shutdown;
   end Object;

   Radius: constant Float := 16.0;

end Robot;
