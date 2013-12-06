package body Site is

   function Way_Out(To: Output_Places) return Ring_Places is
   begin
      return R1;
   end Way_Out;

   function Way_In(From: Input_Places) return Ring_Places is
   begin
      return R1;
   end Way_In;

   function Next return Ring_Places is
   begin
      return R1;
   end Next;

   function Previous return Ring_Places is
   begin
      return R1;
   end Previous;

   function Opposite return Ring_Places is
   begin
      return R1;
   end Opposite;

   protected body Safely is

      procedure Draw_Site is
      begin
         null;
      end Draw_Site;

      procedure Draw_Path is
      begin
         null;
      end Draw_Path;

      procedure Draw_Robot is
      begin
         null;
      end Draw_Robot;

      procedure Hide_Robot is
      begin
         null;
      end Hide_Robot;

   end Safely;

begin
   Adagraph.Create_Sized_Graph_Window(800, 600, X_max, Y_Max, X_Char, Y_Char);
   Adagraph.Set_Window_Title("PACMAN");
   Adagraph.Clear_Window;

end Site;
