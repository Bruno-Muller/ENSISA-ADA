-- Created by Bernard Thirion 23/04/2010

with Nio_Buffer.Byte_Buffer;
use  Nio_Buffer;

package Byte_Sink is

   type Object is interface;
   type Any    is access all Object'Class;

   procedure Send (To: in Object; From: in out Byte_Buffer.Object) is abstract;

end;

