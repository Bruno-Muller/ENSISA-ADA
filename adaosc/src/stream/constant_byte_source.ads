-- Created by Bernard Thirion 23/04/2010

with Byte_Source;
with Nio_Buffer.Byte_Buffer; use Nio_Buffer;

package Constant_Byte_Source is

   type Object(<>) is new Byte_Source.Object with private;

   function Value(From: in String           ) return Object;
   function Value(From: in Byte_Buffer.Bytes) return Object;

   overriding function Receive (From: in Object) return Byte_Buffer.Object;

private

   type Object(Capacity: Natural) is new Byte_Source.Object with record
      Buffer: Byte_Buffer.Object(Capacity);
   end record;

end;

