-- Created by Bernard Thirion 27/03/2012

with OSC_Argument;

package OSC_Listener is

   type    Object is interface;
   subtype Class  is Object'Class;
   type    Any    is access all Class;

   procedure Tell (Self:      in Object; Message:   in String;
                   Arguments: in OSC_Argument.Arguments := OSC_Argument.No_Arguments) is abstract;
end;

