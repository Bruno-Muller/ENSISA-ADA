-- Created by Bernard Thirion 02/05/2010

with GNAT.Sockets;

with Byte_Source;
with Nio_Buffer.Byte_Buffer; use Nio_Buffer;

package UDP_Source is

   type Object is new Byte_Source.Object with private;

   function Value(Port: in GNAT.Sockets.Port_Type; Blocking: Boolean := True) return Object;
   function Value(Port: in GNAT.Sockets.Port_Type; Blocking: Boolean := True) return Byte_Source.Any;

   overriding function Receive (From: in Object) return Byte_Buffer.Object;

private

   type Object is new Byte_Source.Object with record
      Socket:   GNAT.Sockets.Socket_Type := GNAT.Sockets.No_Socket;
      Blocking: Boolean := True;
   end record;

end;

