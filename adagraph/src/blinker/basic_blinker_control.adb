-- Created by Bernard Thirion, 09/04/2012

package body Basic_Blinker_Control is

   protected body Object is

      procedure Start(Period: in Duration := 1.0) is
      begin
         if Object.Period /= Period then
            Object.Period   := Period;
            Object.Changed  := True;
         end if;
         if not Blinking then
            Object.Blinking := True;
            Object.Changed  := True;
         end if;
      end;

      procedure Stop is
      begin
         if Blinking then
            Object.Blinking := False;
            Object.Changed  := True;
         end if;
      end;

      procedure Set_Period(Period: in Duration := 1.0) is
      begin
         if Object.Period /= Period then
            Object.Period   := Period;
            Object.Changed  := True;
         end if;
       end;

      procedure Shutdown is
      begin
         if not Done then
            Object.Done     := True;
            Object.Changed  := True;
         end if;
      end;

      entry Wait_Change(Blinking: out boolean; Period: out Duration; Done: out Boolean) when Changed is
      begin
         Blinking := Object.Blinking;
         Period   := Object.Period;
         Done     := Object.Done;
         Changed  := False;
      end;

      entry Wait_Shutdown when Done is
      begin
         null;
      end;

   end;

end;


