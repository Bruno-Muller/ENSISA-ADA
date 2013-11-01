-- Created by Bernard Thirion, 27/03/2012

with Adagraph;
use  Adagraph;

package body Basic_Blinker is

   procedure Display(X, Y: in Integer; On: in Boolean) is
   begin
      Set_Antialiasing(True);
      case On is
         when True  =>
            Draw_Circle(X, Y, 12, Green, Fill);
            Draw_Circle(X, Y,  4, Light_Cyan, Fill);
            Draw_Circle(X, Y, 11, Light_Cyan, No_Fill);
         when False =>
            Draw_Circle(X, Y,  13, Light_Gray, Fill);
            Draw_Circle(X, Y,  11, Dark_Gray,  Fill);
      end case;
      Draw_Circle(X, Y, 13, Light_Blue,  No_Fill);
   end;

   task body Object is
      Done:   Boolean := False;
      Active: Boolean := False;
      On:     Boolean := False;
      Period: Duration;
   begin
      Display(X, Y, On);
      while not Done loop
         Display(X, Y, On);
         case Active is
            when False => Control.Wait_Change(Active, Period, Done);
               On := Active and not Done;
            when True  =>
               select
                  Control.Wait_Change(Active, Period, Done);
                  On := Active and not Done;
               or
                  delay Period / 2;
                  On := not On;
               end select;
         end case;
      end loop;
      Display(X, Y, On);
   end;
end;


