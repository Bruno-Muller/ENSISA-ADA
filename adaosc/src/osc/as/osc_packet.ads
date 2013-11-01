-- Created by Bernard Thirion, 23/04/2010

with Ada.Unchecked_Deallocation;

with OSC_Listener;

package OSC_Packet is

   type    Object is abstract tagged null record;
   subtype Class  is Object'Class;
   type    Any    is access all Class;

   procedure Interpret(Packet: in     Object; Listener: in OSC_Listener.Class) is null;
   procedure Print    (Packet: in     Object) is null;
   procedure Free     (Packet: in out Object) is null;  -- Free object content

   procedure Dispose is new Ada.Unchecked_Deallocation(Object'Class, Any);

end;

