with Ada.Text_Io;

with GNAT.Sockets;

with Byte_Source;
with UDP_Source;
with OSC_Listener.Display;
with OSC_Server;

use GNAT.Sockets;

procedure Dump_OSC(OSC_Port: Port_Type := 8000) is
   Inlet:  Byte_Source.Any := UDP_Source.Value(Port => OSC_Port, Blocking => False);
   Server: OSC_Server.Object(Inlet, new OSC_Listener.Display.Object);
   Done: boolean := False; Input: Character;
begin
   while not Done loop
      Ada.Text_IO.Get_Immediate(Input, Done);
      delay 0.100;
   end loop;
   Osc_Server.Shutdown(Server);
end;
