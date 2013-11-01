-- Created by Bernard Thirion 12/04/2012
-- Basic OSC sending services (to an UDP port)

with GNAT.Sockets;
with Byte_Sink;
with OSC_Packet;
with OSC_Argument;

use OSC_Argument;

package OSC_Sender is

   procedure Send (Selector:  in String;
                   Sink:      in Byte_Sink.Any);

   procedure Send (Selector:  in String;
                   Arguments: in OSC_Argument.Arguments := OSC_Argument.No_Arguments;
                   Sink:      in Byte_Sink.Any);

   procedure Send (Packet:  in OSC_Packet.Object'Class; Sink: in Byte_Sink.Any);

end;

