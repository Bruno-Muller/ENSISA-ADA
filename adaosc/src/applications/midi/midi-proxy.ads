-- Created by Bernard Thirion 04/05/2010

with Byte_Sink;
with OSC_Proxy;
with OSC_Packet.Message;

with Midi;

use OSC_Packet;

package Midi.Proxy is

   type Object is limited new Midi.Object with private;

   type Ref is access Object;

   function Value (Target_Name: String; Sink: Byte_Sink.Any) return Object;
   function Value (Target_Name: String; Sink: Byte_Sink.Any) return Midi.Any;

   overriding procedure Note_On      (Self: in out Object; Channel, Key, Velocity: Natural);
   overriding procedure Bend         (Self: in out Object; Channel: Natural; Value: Integer);
   overriding procedure All_Notes_Off(Self: in out Object; Channel: Natural);

private

   type Object is limited new Midi.Object with record
      Proxy:         OSC_Proxy.Object; -- should rather inherit this member, but gnat fails on OS X !!!
      Note_On:       Message.Object(Arguments_Count => 3);
      Bend:          Message.Object(Arguments_Count => 2);
      All_Notes_Off: Message.Object(Arguments_Count => 1);
   end record;

end;

