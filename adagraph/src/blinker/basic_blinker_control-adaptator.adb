-- Created by Bernard Thirion, 10/04/2012

with OSC_Argument;
with Basic_Blinker_Control.Selectors;

use  OSC_Argument, Basic_Blinker_Control.Selectors;

package body Basic_Blinker_Control.Adaptator is

   procedure Initialize_Method_Table(Self: in out Object) is
   begin
      Self.Define_Methods((
         (new String'(Start),      1, Handle_Start'access),
         (new String'(Stop),       1, Handle_Stop'access),
         (new String'(Set_Period), 1, Handle_Set_Period'access),
         (new String'(Shutdown),   1, Handle_Shutdown'access)
      ));
   end;

   function Value(Name: String; Target: Basic_Blinker_Control.Ref) return Object is
   begin
      return Result:Object(Methods_Count => 4) do
         Result.Identify_Node(Name);
         Result.Initialize_Method_Table;
         Result.Target := Target;
      end return;
   end;

   function Value(Name: String; Target: Basic_Blinker_Control.Ref) return OSC_Space.Any is
   begin
      return new Object'(Value(Name, Target));
   end;

   procedure Handle_Start (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments) is
      Period: Float;
   begin
      if Arguments(1).Kind = OSC_Argument.Float then
         Period := Value(Arguments(1));
         Object(Self).Target.Start(Duration(Period));
      end if;
   end;

   procedure Handle_Stop (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments) is
   begin
        Object(Self).Target.Stop;
   end;

   procedure Handle_Set_Period (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments)  is
       Period: Float;
   begin
      if Arguments(1).Kind = OSC_Argument.Float then
         Period := Value(Arguments(1));
         Object(Self).Target.Set_Period(Duration(Period));
      end if;
   end;

   procedure Handle_Shutdown   (Self: in Object_Adaptator.Class; Arguments: in OSC_Argument.Arguments) is
   begin
        Object(Self).Target.Shutdown;
   end;

end;
