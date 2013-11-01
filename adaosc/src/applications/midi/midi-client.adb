-- Created by Bernard Thirion 04/05/2010

with Midi;
with Midi.Proxy;

package body Midi.Client is

   procedure Bang(Self: in Object) is
   begin
      Self.Target.All_Notes_Off(7);
      Self.Target.Note_On(5, 69, 100);
      Self.Target.Note_On(6, 70, 83);
      Self.Target.Bend(8, -20);
   end;

end;

