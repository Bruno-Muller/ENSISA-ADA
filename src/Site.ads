with Adagraph; use Adagraph;
package Site is

   X_Max, Y_Max: Integer; X_Char, Y_Char: Integer;

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
   function Next return Ring_Places;
   function Previous return Ring_Places;
   function Opposite return Ring_Places;

   protected Safely is
      procedure Draw_Site;
      procedure Draw_Path;
      procedure Draw_Robot;
      procedure Hide_Robot;
   end;
end Site;
