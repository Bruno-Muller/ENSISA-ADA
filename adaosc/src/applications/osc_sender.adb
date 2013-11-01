-- Created by Bernard Thirion 12/04/2012

with OSC_Packet_Unparser;
with Nio_Buffer.Byte_Buffer;

with OSC_Packet.Message;

use  Nio_Buffer, OSC_Packet;

package body OSC_Sender is

   procedure Send (Packet: in OSC_Packet.Object'Class; Sink: in Byte_Sink.Any) is
      Buffer: Byte_Buffer.Object := OSC_Packet_Unparser.Unparse(Packet);
   begin
      Sink.Send(Buffer);
   end;

   procedure Send (Selector:  in String; Sink: in Byte_Sink.Any) is
   begin
      Send(Selector, OSC_Argument.No_Arguments, Sink);
   end;

   procedure Send (Selector:  in String;
                   Arguments: in OSC_Argument.Arguments := OSC_Argument.No_Arguments;
                   Sink:      in Byte_Sink.Any) is
      M: Message.Object(Arguments_Count => Arguments'Length);
   begin
      M.Set_Selector(Selector);
      M.Set_Arguments(Arguments);
      Send(M, Sink);
   end;

end;

