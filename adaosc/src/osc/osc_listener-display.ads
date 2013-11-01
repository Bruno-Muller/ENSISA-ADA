-- Created by Bernard Thirion, 27/04/2010

with Ada.Strings.Unbounded;

with OSC_Listener;

package OSC_Listener.Display is

   type Object is new OSC_Listener.Object with null record;

   overriding procedure Tell (Self: in Object; Message: in String; Arguments: in OSC_Argument.Arguments);

end;

