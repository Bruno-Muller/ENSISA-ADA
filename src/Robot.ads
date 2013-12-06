with Adagraph; use Adagraph;
with Ada.Calendar; use Ada.Calendar;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Float_Text_IO;
with Path; use Path;

package Robot is

   type State_Type is (Ready, Following);
   type Mouth_State is (Opened, Closed);

   task type Object(Color: Color_Type := Light_Green) is
      entry Follow(P: Path.Object);
      entry Shutdown;
   end Object;

   procedure Draw(P: in Point; Next_Point: in Point; Mouth: in Mouth_State; Color: in Color_Type);


private
   Radius: constant Float := 16.0;
end Robot;
