-- Created by Bernard Thirion, 23/04/2010

with Ada.Strings.Unbounded;

package OSC_Argument is

   type Object_Kind is (Undefined, Integer, Float, String);
   type Object (Kind: Object_Kind := Undefined) is private;

   type Arguments is array (Positive range <>) of Object;

   No_Arguments: constant Arguments;

   function Undefined_Value                     return Object;
   function Value(I: in Standard.Integer      ) return Object;
   function Value(F: in Standard.Float        ) return Object;
   function Value(S: in Standard.String       ) return Object;

   function Value(O: in Object) return Standard.Integer;
   function Value(O: in Object) return Standard.Float;
   function Value(O: in Object) return Standard.String;

   function Image(O: in Object) return Standard.String;

   procedure Free(O: in out Object);

private

   type Object (Kind: Object_Kind := Undefined) is record
      case Kind is
      when Undefined => null;
      when Integer   => Integer_Value: Standard.Integer;
      when Float     => Float_Value:   Standard.Float;
      when String    => String_Ref:    Ada.Strings.Unbounded.String_Access;
      end case;
   end record;

   No_Arguments: constant Arguments := (1..0 => <>);

end;

