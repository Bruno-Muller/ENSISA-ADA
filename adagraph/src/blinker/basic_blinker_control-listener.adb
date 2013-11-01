-- Created by Bernard Thirion, 09/04/2010
-- Only for testing. The problem with this first solution

with OSC_Argument;
with Basic_Blinker_Control.Selectors;
use  OSC_Argument, Basic_Blinker_Control;

package body Basic_Blinker_Control.Listener is

   function Match(Self: in Object; Message: in String; Selector: in String) Return Boolean is
   begin
      return Message = Self.Name.all & '/' & Selector;
   end;

   procedure Tell (Self: in Object; Message: in String; Arguments: in OSC_Argument.Arguments) is
      Period: Float;
   begin
      if Match(Self, Message, Selectors.Start) then
         case Arguments'Length is
            when 0 => Self.Target.Start;
            when 1 => if Arguments(1).Kind = OSC_Argument.Float then
                  Period := Value(Arguments(1));
                  Self.Target.Start(Duration(Period));
               end if;
            when others => null;
         end case;
      end if;

      if Match(Self, Message, Selectors.Stop) then
         Self.Target.Stop;
      end if;

      if Match(Self, Message, Selectors.Set_Period) then
         if Arguments'Length = 1 and Arguments(1).Kind = OSC_Argument.Float then
            Period := Value(Arguments(1));
            Self.Target.Set_Period(Duration(Period));
         end if;
      end if;

      if Match(Self, Message, Selectors.Shutdown) then
         Self.Target.Shutdown;
      end if;
   end;

end;

