-- Created by Bernard Thirion, 06/05/2010

with OSC_Argument;
with OSC_Space.Object_Adaptator;
with Midi;

use OSC_Space;

package Midi.Adaptator is

   type Object is new Object_Adaptator.Object with private;

   function  Value(Name: String; Target: Midi.Any) return Object;
   function  Value(Name: String; Target: Midi.Any) return OSC_Space.Any;

private

   procedure Initialize_Method_Table(Self: in out Object);

   procedure Handle_Note_On       (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments);
   procedure Handle_Bend          (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments);
   procedure Handle_All_Notes_Off (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments);

   type Object is new Object_Adaptator.Object with record
	  Target: access Midi.Class;
   end record;

end;
