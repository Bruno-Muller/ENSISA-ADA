with GNAT.Sockets;

with Nio_Buffer.Byte_Buffer;
with OSC_Packet;
with OSC_Packet_Parser;
with Constant_Byte_Source;
with OSC_Packet_Instances;

with Byte_Sink;
with UDP_Sink;

with OSC_Argument;
with OSC_Sender;
with Dump_OSC;
with Midi.Test;

use GNAT.Sockets, Nio_Buffer, OSC_Packet_Instances;

procedure Test_OSC is

   Local_Host: constant String        := "127.0.0.1";
   Outlet: Byte_Sink.Any              := UDP_Sink.Value(Target_Host => Inet_Addr(Local_Host), Port => 8000);

   CS: Constant_Byte_Source.Object    := B3;
   Buffer: aliased Byte_Buffer.Object := CS.Receive;
   Packet: access OSC_Packet.Class    := OSC_Packet_Parser.Parse(Buffer'Access);


begin
   OSC_Sender.send("/ada/says/hello", Outlet);
   OSC_Sender.send("/ada/osc/message",
                   (1 => OSC_Argument.Value("hello world"),
                    2 => OSC_Argument.Value(33),
                    3 => OSC_Argument.Value(3.14159)),
                    Outlet);
   Packet.Print;
   Midi.Test(OSC_Port => 8057);
   Dump_OSC (OSC_Port => 8055);
end;
