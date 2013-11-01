-- Created by Bernard Thirion 04/05/2010

with Ada.Text_Io;
use  Ada.Text_Io;

package body Midi.Implementation is

   function Image(I:Integer) return String renames Integer'Image;

   procedure Note_On(Self: in out Object; Channel, Key, Velocity: Natural) is
   begin
      Put_Line("Note_On: " & Image(Channel) & ", " & Image(Key) & ", " & Image(Velocity));
   end;


   procedure Bend(Self: in out Object; Channel: Natural; Value: Integer) is
   begin
      Put_Line("Bend: " & Image(Channel) & ", " & Image(Value));
   end;


   procedure All_Notes_Off(Self: in out Object; Channel: Natural) is
   begin
      Put_Line("All_Notes_Off: " & Image(Channel));
   end;


end;

