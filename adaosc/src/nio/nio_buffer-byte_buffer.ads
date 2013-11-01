-- Created by Bernard Thirion, 21/04/2010
-- Mimics the class java.nio.Byte_Buffer
-- Byte ordering is always big endian

with Nio_Buffer;
with Interfaces; use Interfaces;

package Nio_Buffer.Byte_Buffer is

   type Byte is mod 256;
   for  Byte'size use 8;
   type Bytes is array (Positive range <>) of Byte;

   type Object is new Nio_Buffer.Object with private;

   procedure get(B: in out Object; Value: out Byte);
   procedure put(B: in out Object; Value: in  Byte);

   procedure get(B: in out Object; Value: out String);
   procedure put(B: in out Object; Value: in  String);

   procedure get(B: in out Object; Value: out Bytes);
   procedure put(B: in out Object; Value: in  Bytes);

   procedure get(B: in out Object; Value: out Bytes; Offset : Positive; Length: Natural);
   procedure put(B: in out Object; Value: in  Bytes; Offset : Positive; Length: Natural);

   procedure get(B: in out Object; Value: out Character);
   procedure put(B: in out Object; Value: in  Character);

   procedure get(B: in out Object; Value: out Integer_32);
   procedure put(B: in out Object; Value: in  Integer_32);

   procedure get(B: in out Object; Value: out IEEE_Float_32);
   procedure put(B: in out Object; Value: in  IEEE_Float_32);

   function  As_Byte (Value: in Character) return Byte;
   function  As_Bytes(Value: in String   ) return Bytes;

private

   type Object is new Nio_Buffer.Object with record
      Values: Bytes (1..Object.Capacity);
   end record;

end;

