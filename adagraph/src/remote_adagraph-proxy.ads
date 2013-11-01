-- Created by Bernard Thirion 21/03/2012

with Ada.Calendar;
with GNAT.Sockets;

with Remote_Adagraph;
with Byte_Sink;
with OSC_Proxy;
with OSC_Packet.Message;

use Ada.Calendar, GNAT.Sockets, Remote_Adagraph, OSC_Packet;

package Remote_Adagraph.Proxy is

   type Object is limited new OSC_Proxy.Object with private;

   function  Value(Target_Name: String; Sink: Byte_Sink.Any) return Object;

   procedure Create_Graph_Window     (Self: in out Object; Width, Height: in Integer);
   procedure Destroy_Graph_Window    (Self: in out Object);
   procedure Clear_Window            (Self: in out Object; Hue: in Color_Type);
   procedure Set_Window_Title        (Self: in out Object; Title : in String);
   procedure Draw_Line               (Self: in out Object; X1, Y1, X2, Y2: in Integer; Hue: in Color_Type);
   procedure Draw_Box                (Self: in out Object; X1, Y1, X2, Y2: in Integer; Hue: in Color_Type; Filled: Boolean);
   procedure Draw_Circle             (Self: in out Object;  X,  Y, Radius: in Integer; Hue: in Color_Type; Filled: Boolean);
   procedure Draw_Ellipse            (Self: in out Object; X1, Y1, X2, Y2: in Integer; Hue: in Color_Type; Filled: Boolean);
   procedure Display_Text            (Self: in out Object;  X, Y: in Integer; Text: in String; Hue: in Color_Type);
   procedure Set_Antialiasing        (Self: in out Object; On: in Boolean);
   procedure Set_Immediate_Rendering (Self: in out Object; On: in Boolean);
   procedure Create_Control_Surface  (Self: in out Object; Class_Name: in String;
                                      Host_Name: in String; OSC_Port: in Port_Type);
   procedure Destroy_Control_Surface (Self: in out Object);

   overriding procedure Send (Self: in out Object; Packet: in OSC_Packet.Object'Class);

private

   type Object is limited new OSC_Proxy.Object with record
      Burst_Length:            Integer := 0;
      Burst_Start_Time:        Ada.Calendar.Time := Clock;
      Previous_Send_Time:      Ada.Calendar.Time := Clock;
      Create_Graph_Window:     Message.Object(Arguments_Count => 2);
      Destroy_Graph_Window:    Message.Object(Arguments_Count => 0);
      Clear_Window:            Message.Object(Arguments_Count => 1);
      Set_Window_Title:        Message.Object(Arguments_Count => 1);
      Draw_Line:               Message.Object(Arguments_Count => 5);
      Draw_Box:                Message.Object(Arguments_Count => 6);
      Draw_Circle:             Message.Object(Arguments_Count => 5);
      Draw_Ellipse:            Message.Object(Arguments_Count => 6);
      Display_Text:            Message.Object(Arguments_Count => 4);
      Set_Antialiasing:        Message.Object(Arguments_Count => 1);
      Set_Immediate_Rendering: Message.Object(Arguments_Count => 1);
      Create_Control_Surface:  Message.Object(Arguments_Count => 3);
      Destroy_Control_Surface: Message.Object(Arguments_Count => 0);
   end record;

end;

