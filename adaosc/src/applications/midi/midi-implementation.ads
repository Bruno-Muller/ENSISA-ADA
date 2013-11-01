-- Created by Bernard Thirion 04/05/2010

with Midi;

package Midi.Implementation is

   type Object is new Midi.Object with null record;

   procedure Note_On      (Self: in out Object; Channel, Key, Velocity: Natural);
   procedure Bend         (Self: in out Object; Channel: Natural; Value: Integer);
   procedure All_Notes_Off(Self: in out Object; Channel: Natural);

end;

