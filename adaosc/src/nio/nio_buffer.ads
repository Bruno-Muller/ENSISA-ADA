-- Created by Bernard Thirion, 21/04/2010
-- The contract and behavior mimic the class java.nio.Buffer
-- See Javadoc, but indexes start at 1 not at 0

package Nio_Buffer is

   type Object (Capacity : Natural) is abstract tagged private;

   function Capacity (B : in Object) return Positive;
   function Limit (B : in Object) return Positive;
   function Position (B : in Object) return Positive;

   function Remaining (B : in Object) return Natural;
   function Has_Remaining (B : in Object) return Boolean;

   procedure Position (B : in out Object; New_Position : in Positive);
   procedure Limit (B : in out Object; New_Limit : in Positive);

   procedure Clear (B : in out Object);
   procedure Flip (B : in out Object);
   procedure Mark (B : in out Object);
   procedure Reset (B : in out Object);
   procedure Rewind (B : in out Object);

   Underflow, Overflow : exception;

private

   Not_Marked : constant := 0;

   type Object (Capacity : Natural) is tagged record
      Limit    : Positive := Capacity + 1;   -- first element that shoud not be read or written
      Position : Positive := 1;              -- index of next element to be read or written
      Mark     : Natural  := Not_Marked;     -- a remenbered position
   end record;

end Nio_Buffer;
