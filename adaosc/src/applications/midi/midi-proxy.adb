-- Created by Bernard Thirion 04/05/2010
with Ada.Text_IO;

with OSC_Argument;
with Midi.Selectors;

with OSC_Proxy;

use OSC_Proxy;

package body Midi.Proxy is

   function Value (Target_Name: String; Sink: Byte_Sink.Any) return Object is
   begin
      return Result: Object do
         Result.Proxy.Initialize(Target_Name, Sink);
         Result.Note_On.Set_Selector      (Selector(Target_Name, Midi.Selectors.Note_On));
         Result.Bend.Set_Selector         (Selector(Target_Name, Midi.Selectors.Bend));
         Result.All_Notes_Off.Set_Selector(Selector(Target_Name, Midi.Selectors.All_Notes_Off));
      end return;
   end;

   function Value (Target_Name: String; Sink: Byte_Sink.Any) return Midi.Any is
   begin
      return Result: Midi.Any do
         Result := new Object'(Value(Target_Name, Sink));
      end return;
   end;

   procedure Note_On(Self: in out Object; Channel, Key, Velocity: Natural) is
   begin
      Self.Note_On.Set_Argument(1, OSC_Argument.Value(Channel ));
      Self.Note_On.Set_Argument(2, OSC_Argument.Value(Key     ));
      Self.Note_On.Set_Argument(3, OSC_Argument.Value(Velocity));
      Self.Proxy.Send(Self.Note_On);
   end;

   procedure Bend(Self: in out Object; Channel: Natural; Value: Integer) is
   begin
      Self.Bend.Set_Argument(1, OSC_Argument.Value(Channel));
      Self.Bend.Set_Argument(2, OSC_Argument.Value(Value  ));
      Self.Proxy.Send(Self.Bend);
   end;

   procedure All_Notes_Off(Self: in out Object; Channel: Natural) is
   begin
      Self.All_Notes_Off.Set_Argument(1, OSC_Argument.Value(Channel));
      Self.Proxy.Send(Self.All_Notes_Off);
   end;

end;

