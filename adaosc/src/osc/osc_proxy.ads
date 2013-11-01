-- Created by Bernard Thirion, 05/05/2010

with Ada.Strings.Unbounded;

with Byte_Sink;
with OSC_Packet;

package OSC_Proxy is

   type Object is tagged limited private;

   procedure Initialize (Self: in out Object; Target_Name: in String; Sink: Byte_Sink.Any);
   procedure Send       (Self: in out Object; Packet:      in OSC_Packet.Object'Class);

   function Selector (Target_Name: in String; Method_Name: in String) return String;

private

   type Object is tagged limited record
      Target_Name: Ada.Strings.Unbounded.String_Access;
      Sink:        Byte_Sink.Any;
   end record;

end;

