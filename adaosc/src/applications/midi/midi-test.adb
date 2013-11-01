with Ada.Text_IO;
with Ada.Tags;
with Ada.Exceptions;

with GNAT.Sockets;

with Byte_Source;
with Byte_Sink;
with UDP_Source;
with UDP_Sink;

with OSC_Space;
with OSC_Space.Container;
with OSC_Space.Display;
with OSC_Listener;
with OSC_Server;
with Midi.Client;
with Midi.Implementation;
with Midi.Proxy;
with Midi.Adaptator;

use GNAT.Sockets, OSC_Space;

procedure Midi.Test(OSC_Port: Port_Type := 8000) is
   Target:     Midi.Any      := new Midi.Implementation.Object;
   Adaptator:  OSC_Space.Any := Midi.Adaptator.Value("midi", Target);
   Music:      OSC_Space.Any := Container.Value("music",      (1 => Adaptator));
   Oscillator: OSC_Space.Any := Container.Value("oscillator", (-- only to show correct message routing
     Display.Value("frequency"),
     Display.Value("amplitude")
   ));

   Space:  OSC_Space.Any   := Container.Value("", (Music, Oscillator));
   Inlet:  Byte_Source.Any := UDP_Source.Value(Port => OSC_Port, Blocking => False);
   Outlet: Byte_Sink.Any   := UDP_Sink.Value(Target_Host => Inet_Addr("127.0.0.1"), Port => OSC_Port);
   Proxy:  Midi.Any        := Midi.Proxy.Value("/music/midi", Outlet);

   Client: Midi.Client.Object(Proxy);
   Server: OSC_Server.Object(Inlet, OSC_Listener.Any(Space));

begin
   delay 0.2;
   for I in 1..10 loop
      Client.Bang;
      -- delay 0.5;
   end loop;
   delay 1.0;
   Osc_Server.Shutdown(Server);
exception
      when what : others => Ada.Text_IO.Put_Line (" in test " & Ada.Exceptions.Exception_Message(What));
end;
