with Adagraph; use Adagraph;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Path;

package Site is

   X_Max, Y_Max: Integer; X_Char, Y_Char: Integer;
   Center: Path.Point := (X => 400.0, Y => 300.0);
   Radius: Float := 200.0;

   type Places_Names is (I1, I2, I3, I4, I5, I6,
                         O1, O2, O3, O4, O5, O6,
                         R1, R2, R3, R4, R5, R6,
                         C);
   subtype Ring_Places is Places_Names range R1..R6;
   subtype Input_Places is Places_Names range I1..I6;
   subtype Output_Places is Places_Names range O1..O6;
   subtype Central_Place is Places_Names range C..C;

   function Way_Out(To: Output_Places) return Ring_Places;
   function Way_In(From: Input_Places) return Ring_Places;
   function Next(Place: Ring_Places) return Ring_Places;
   function Previous(Place: Ring_Places) return Ring_Places;
   function Opposite(Place: Ring_Places) return Ring_Places;
   function Get_Point(Pnt: Places_Names) return Path.Point;
   function Get_Point(Ctr: Path.Point; R: Float; Angle: Float) return Path.Point ;

   protected Safely is
      procedure Draw_Site(Clr: in Color_Type := Dark_Gray);
      procedure Draw_Path (Pth: in Path.Object; Clr: in Color_Type := Light_Green) ;
      procedure Draw_Robot(Pnt: in Path.Point; Radius: in Float; Direction: in Path.Vector; Mouth_Opened: in Boolean; Clr: in Color_Type);
      procedure Hide_Robot(Pnt: in Path.Point; Radius: in Float);
   end;
end Site;
