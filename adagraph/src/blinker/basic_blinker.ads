-- Created by Bernard Thirion, 09/04/2012

with Basic_Blinker_Control;

package Basic_Blinker is

   task type Object (X, Y: Integer; Control: Basic_Blinker_Control.Ref);

   type Ref is access all Object;
end;

