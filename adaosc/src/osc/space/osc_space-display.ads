-- Created by Bernard Thirion, 27/04/2010

with Ada.Strings.Unbounded;

with OSC_Space;

package OSC_Space.Display is

   type Object is new OSC_Space.Object with private;

   function  Value(Name: String; Device: String := "Display") return Object;
   function  Value(Name: String; Device: String := "Display") return OSC_Space.Any;

   overriding procedure Tell(Self:      in Object; Message:   in String;
                             Arguments: in OSC_Argument.Arguments);

   overriding procedure Free (Self: in out Object);

private

   type Object is new OSC_Space.Object with record
      device: Ada.Strings.Unbounded.String_Access;
   end record;

   function  Can_Handle(Self: in Object; Message: in String) return Boolean; -- here to be a primitive op.

end;

