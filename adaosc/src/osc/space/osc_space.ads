-- Created by Bernard Thirion, 27/04/2010

with Ada.Strings.Unbounded;

with OSC_Argument;
with OSC_Listener;

package OSC_Space is

   type    Object is abstract new OSC_Listener.Object with private;
   subtype Class  is Object'Class;
   type    Any    is access all Class;

   type Objects is array (Positive range <>) of Any;

   procedure Identify_Node(Self: in out Object; Name: in String);
   function  Name         (Self: in     Object) return String;

   procedure Free    (Self: in out Object);    -- no reference counting use with care, avoid shared nodes
   procedure Dispose (Self: in out Any); -- no reference counting use with care

private

   type Object is abstract new OSC_Listener.Object with record
      Name: Ada.Strings.Unbounded.String_Access;
   end record;

end;

