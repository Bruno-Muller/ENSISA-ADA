
-- Created by Bernard Thirion 06/05/2010

with Ada.Strings.Unbounded;
with OSC_Argument;

package OSC_Space.Object_Adaptator is

   type    Object(Methods_Count: Positive) is abstract new OSC_Space.Object with private;
   subtype Class is Object'Class;

   overriding procedure Tell (Self: in Object; Message: in String; Arguments: in OSC_Argument.Arguments);

   type Method_Ref is access procedure(Self: in Class; Arguments: in OSC_Argument.Arguments);

   type Table_Entry is record
      Selector:        Ada.Strings.Unbounded.String_Access;
      Arguments_Count: Natural;
      Method:          Method_Ref;
   end record;

   type Method_Table is array (Positive range <>) of Table_Entry;

   procedure Define_Methods(Self: in out Object; Table: in Method_Table);

   procedure Define_Method (Self:     in out Object; Index: in Positive;
                            Selector: in String; Arguments_Count: in Natural;  Method: in Method_Ref);

private

   type Object(Methods_Count: Positive) is abstract new OSC_Space.Object with record
      Methods: Method_Table(1..Methods_Count);
   end record;

end;

