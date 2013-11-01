-- Created by Bernard Thirion, 27/04/2010

with OSC_Argument;
with OSC_Listener;
with Basic_Blinker_Control;
package Basic_Blinker_Control.Listener is

   type Object(Name: access String; Target: Basic_Blinker_Control.Ref) is new OSC_Listener.Object with null record;

   procedure Tell (Self: in Object; Message: in String; Arguments: in OSC_Argument.Arguments);

end;

