-- Created by Bernard Thirion, 02/05/2010

with Byte_Source;
with OSC_Listener;

package OSC_Server is

   type Object(Source: Byte_Source.Any; Listener:  OSC_Listener.Any) is limited private;

   procedure Shutdown(Self: in out Object);

private

   task type Object(Source: Byte_Source.Any; Listener: OSC_Listener.Any) is
      entry Shutdown;
   end;

end;

