-- Created by Bernard Thirion, 06/05/2010

with OSC_Argument;
with Midi.Selectors;

use  OSC_Argument;

package body Midi.Adaptator is

   procedure Initialize_Method_Table(Self: in out Object) is
   begin
      Self.Define_Methods((
         (new String'(Midi.Selectors.Note_On),       3, Handle_Note_On'access),
         (new String'(Midi.Selectors.Bend),          2, Handle_Bend'access),
         (new String'(Midi.Selectors.All_Notes_Off), 1, Handle_All_Notes_Off'access)
      ));
   end;

   function Value(Name: String; Target: Midi.Any) return Object is
   begin
      return Result:Object(Methods_Count => 3) do
         Result.Identify_Node(Name);
         Result.Initialize_Method_Table;
         Result.Target := Target;
      end return;
   end;

   function Value(Name: String; Target: Midi.Any) return OSC_Space.Any is
   begin
      return new Object'(Value(Name, Target));
   end;

   procedure Handle_Note_On(Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments) is
      Channel:  Natural := Value(Arguments(1));
      Key:      Natural := Value(Arguments(2));
      Velocity: Natural := Value(Arguments(3));
   begin
      Object(Self).Target.Note_On(Channel, Key, Velocity);
   end;

   procedure Handle_Bend(Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments) is
      Channel:  Natural := Value(Arguments(1));
      Amount:   Integer := Value(Arguments(2));
   begin
      Object(Self).Target.Bend(Channel, Amount);
   end;

   procedure Handle_All_Notes_Off(Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments) is
      Channel:  Natural := Value(Arguments(1));
   begin
      Object(Self).Target.All_Notes_Off(Channel);
   end;

end;
