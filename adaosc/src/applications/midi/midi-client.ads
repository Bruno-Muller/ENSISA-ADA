-- Created by Bernard Thirion 04/05/2010

with Midi;

package Midi.Client is

   type Object(Target: Midi.Any) is tagged null record;

   procedure Bang(Self: in Object);

end;

