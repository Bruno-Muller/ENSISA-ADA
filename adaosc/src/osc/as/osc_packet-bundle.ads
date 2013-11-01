-- Created by Bernard Thirion, 23/04/2010

package OSC_Packet.Bundle is

   type Object is new Osc_Packet.Object with private;

   type Mod_256  is mod 256;
   type Time_Tag is array(1..8) of Mod_256;

   overriding procedure Interpret(B: in Object; Listener: in OSC_Listener.Class);
   overriding procedure Print    (B: in Object);
   overriding procedure Free     (B: in out Object);

   function  Get_Time_Tag(B: in     Object) return Time_Tag;
   procedure Set_Time_Tag(B: in out Object; Value: in Time_Tag);

   procedure Add(B: in out Object; P: access OSC_Packet.Class);

   type Iterator is private;

   function  Open  (B: in     Object  ) return Iterator;
   function  Value (I: in     Iterator) return access OSC_Packet.Class;
   procedure Next  (I: in out Iterator);
   function  At_End(I: in     Iterator) return boolean;

private

   type Cell;
   -- type Cell_Ref is access Cell;

   type Cell is record
      Value: access OSC_Packet.Class;
      Next:  access Cell;
   end record;

   type Object is new OSC_Packet.Object with record
      Time:   Time_Tag := (others  => 0);
      First:  access Cell;
      Last:   access Cell;
      -- Cursor: Cell_Ref;
   end record;

   type Iterator is record
      Current: access Cell;
   end record;

   procedure Print_Time_Tag(B: in Object);

end;

