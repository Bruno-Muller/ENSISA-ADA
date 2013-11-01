-- Created by Bernard Thirion, 09/04/2012

package Basic_Blinker_Control is

   protected type Object is
      procedure Start(Period: in Duration := 1.0);
      procedure Stop;
      procedure Set_Period(Period: in Duration := 1.0);
      procedure Shutdown;
      entry     Wait_Change(Blinking: out boolean; Period: out Duration; Done: out Boolean);
      entry     Wait_Shutdown;
   private
      Changed:  Boolean  := False;
      Blinking: Boolean  := False;
      Period:   Duration := 1.0;
      Done:     Boolean  := False;
   end;

   type Ref is access all Object;

end;

