-- Created by Bernard Thirion, 10/04/2012
-- OSC protocol (designed for Lemur which has always at least one argument)
--   .../start period
--   .../stop  x
--   .../setPeriod period
--   .../shutdown x

with OSC_Argument;
with OSC_Space.Object_Adaptator;
with Basic_Blinker_Control;

use OSC_Space;

package Basic_Blinker_Control.Adaptator is

   type Object is new Object_Adaptator.Object with private;

   function  Value(Name: String; Target: Basic_Blinker_Control.Ref) return Object;
   function  Value(Name: String; Target: Basic_Blinker_Control.Ref) return OSC_Space.Any;

private

   procedure Initialize_Method_Table(Self: in out Object);

   procedure Handle_Start      (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments);
   procedure Handle_Stop       (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments);
   procedure Handle_Set_Period (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments);
   procedure Handle_Shutdown   (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments);

   type Object is new Object_Adaptator.Object with record
	  Target: Basic_Blinker_Control.Ref;
   end record;

end;
