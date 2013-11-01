-- Created by Bernard Thirion, 23/04/2010

with Nio_Buffer.Byte_Buffer;
with OSC_Packet;

use Nio_Buffer;

package OSC_Packet_Parser is

   function Parse(B: access Byte_Buffer.Object) return OSC_Packet.Any;

   Not_Implemented: exception;

end;

