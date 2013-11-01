-- Created by Bernard Thirion 23/04/2010

with Nio_Buffer.Byte_Buffer;
use  Nio_Buffer;

package Byte_Source is

   type Object is interface;
   type Any is access all Object'Class;

   function Receive (From: in Object) return Byte_Buffer.Object is abstract;

end;

