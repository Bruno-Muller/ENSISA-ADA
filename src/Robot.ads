with Adagraph; use Adagraph;
with Ada.Calendar; use Ada.Calendar;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Site;
with Generic_Mailbox;

package Robot is

   -- état du robot
   type State_Type is (Ready, Following, Shutdown);

   -- id des robot, l'agence crée le nombre maximum de robot autorisé par range
   subtype Robot_Id is Natural range 1..6;

   -- Mailbox dont les messages sont des id de robots
   package Robot_Mailbox is new Generic_Mailbox(Message => Robot_Id);

   task type Object(Id: Robot_Id := 1; Mission_Done: access Robot_Mailbox.Object := null; Color: Color_Type := Light_Green) is
      entry Go(From: Site.Input_Places; To: Site.Output_Places);
      entry Shutdown;
   end Object;

   Radius: constant Float := 16.0;

   -- Les couleurs des robots utilisées par l'agence et le parking
   Robot_Color: array (Robot_Id)  of Adagraph.Color_Type := (Adagraph.Green, Adagraph.Blue, Adagraph.Red, Adagraph.Cyan, Adagraph.Magenta, Adagraph.Yellow);

end Robot;
