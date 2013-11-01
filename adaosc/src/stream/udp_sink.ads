-- Created by Bernard Thirion 03/05/2010

with GNAT.Sockets;

with Byte_Sink;
with Nio_Buffer.Byte_Buffer; use Nio_Buffer;

package UDP_Sink is

   type Object is new Byte_Sink.Object with private;

   function Value(Target_Host: in GNAT.Sockets.Inet_Addr_Type;
                  Port:        in GNAT.Sockets.Port_Type) return Object;

   function Value(Target_Host: in GNAT.Sockets.Inet_Addr_Type;
                  Port:        in GNAT.Sockets.Port_Type) return Byte_Sink.Any;

   overriding procedure Send (To: in Object; From: in out Byte_Buffer.Object);

private

   type Object is new Byte_Sink.Object with record
      Socket: GNAT.Sockets.Socket_Type    := GNAT.Sockets.No_Socket;       -- output socket towards below target address
      Target: GNAT.Sockets.Sock_Addr_Type := GNAT.Sockets.No_Sock_Addr;
   end record;

end;

