-- Created by Bernard Thirion, 23/04/2010

with Ada.Strings.Unbounded;
with OSC_Argument;

use Ada.Strings.Unbounded;

package OSC_Packet.Message is

   type Object(Arguments_Count: Natural) is new Osc_Packet.Object with private;

   overriding procedure Interpret(M: in Object; Listener: in OSC_Listener.Class);
   overriding procedure Print    (M: in Object    );
   overriding procedure Free     (M: in out Object);

   function Selector     (M: in Object) return String;
   function Argument     (M: in Object; Index: in Positive) return OSC_Argument.Object;
   function Argument_Kind(M: in Object; Index: in Positive) return OSC_Argument.Object_Kind;

   procedure Set_Selector (M: in out Object; Selector: in String);
   procedure Set_Argument (M: in out Object; Index: in Positive; Argument: OSC_Argument.Object);
   procedure Set_Arguments(M: in out Object; Arguments: OSC_Argument.Arguments);

private

   type Object(Arguments_Count: Natural) is new Osc_Packet.Object with record
      Selector:  Ada.Strings.Unbounded.String_Access;
      Arguments: OSC_Argument.Arguments(1..Arguments_Count);
   end record;

end;

