-- Created by Bernard Thirion, 26/04/2010

with Nio_Buffer.Byte_Buffer;
with OSC_Packet;

use Nio_Buffer;

package OSC_Packet_Unparser is

   function Unparse(P: OSC_Packet.Object'Class) return Byte_Buffer.Object;

   Not_Implemented: exception;

end;

