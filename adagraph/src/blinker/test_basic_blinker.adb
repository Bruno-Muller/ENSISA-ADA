with Adagraph;
with Basic_Blinker;
with Basic_Blinker_Control.Listener;
with Basic_Blinker_Control.Adaptator;

with Byte_Source;
with UDP_Source;
with OSC_Listener;
with OSC_Space;
with OSC_Space.Container;
with OSC_Server;

with GNAT.Sockets;


use GNAT.Sockets, OSC_Space;

use Adagraph;

procedure Test_Basic_Blinker is

   X_Max, Y_Max: Integer; X_Char, Y_Char: Integer;
   OSC_Port: constant Port_Type := 8055;

   Controller:  Basic_Blinker_Control.Ref := new Basic_Blinker_Control.Object;
   -- Listener:    OSC_Listener.Any    := new Basic_Blinker_Control.Listener.Object(Name => new String'("/blinker"),
   --                                                                               Target => Controller);
   Adaptator:   OSC_Space.Any       := Basic_Blinker_Control.Adaptator.Value("blinker", Controller);

   Space:       OSC_Space.Any       := Container.Value("", (1 => Adaptator));

   Blinker_Ref: Basic_Blinker.Ref   := new Basic_Blinker.Object(X => 100, Y => 100, Control => Controller);

   Inlet:       Byte_Source.Any     := new UDP_Source.Object'(UDP_Source.Value(OSC_Port, Blocking => False));
--   Server:      OSC_Server.Object(Inlet, Listener);
   Server:      OSC_Server.Object(Inlet, OSC_Listener.Any(Space));

begin
   Create_Sized_Graph_Window(200, 200, X_max, Y_Max, X_Char, Y_Char);
   Set_Window_Title("OSCable Blinker");
   Clear_Window(Blue);
   Controller.Wait_Shutdown;
   OSC_Server.Shutdown(Server);
   Destroy_Graph_Window;
end;
