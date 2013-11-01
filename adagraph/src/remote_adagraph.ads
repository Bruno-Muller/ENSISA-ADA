-- This is a simplified version of Adagraph using a remote server
-- The specifications are taken from Adagraph.ads written by Jerry van Dijk
-- to be compatible with a subset of his specifications.
-- The Mouse event functions are not provided, but are replaced by
-- the possibility to create a remote Control Surface

with GNAT.Sockets; use GNAT.Sockets;

package Remote_Adagraph is

   Default_Adagraph_Port: constant Port_Type := 8057;
   Default_Host:          constant String    := "127.0.0.1";

   ------------------
   -- Libary types --
   ------------------

   type Color_Type is (Black, Blue, Green, Cyan, Red, Magenta, Brown,
                       Light_Gray, Dark_Gray, Light_Blue, Light_Green,
                       Light_Cyan, Light_Red, Light_Magenta, Yellow, White);

   type Fill_Type is (Fill, No_Fill);

   ------------------------
   -- Server declaration --
   ------------------------

   -- used to change the destination. Calling this operation is not mandatory (called internaly)

   procedure Define_Server (Hostname: String := Default_Host; Adagraph_Port: Port_Type := Default_Adagraph_Port);

   -----------------------
   -- Window management --
   -----------------------

   -- creates a window of a predetermined size which will display characters of a specified height and width

   procedure Create_Graph_Window (X_Max, Y_Max: out Integer; X_Char, Y_Char: out Integer);

   -- creates a graphics window of a size specified by the user

   procedure Create_Sized_Graph_Window (X_Size, Y_Size: in Integer; X_Max,  Y_Max: out Integer;
                                        X_Char, Y_Char: out Integer);

   -- closes the last opened graphics window (ignore if no current window)

   procedure Destroy_Graph_Window;

   -- displays a title in the title bar of the window

   procedure Set_Window_Title (Title : in String);

   ---------------------
   -- Input functions --
   ---------------------

   -- return true if a hey has been pressed since the last Get_Function call

   function Key_Hit return Boolean;

   -- gets a key from the input keyboard (warning, side effect)

   function Get_Key return Character;

--   function Mouse_Event return Boolean;

--   function Get_Mouse return Mouse_Type;

   -----------------------
   -- Graphic functions --
   -----------------------

   procedure Clear_Window (Hue : in Color_Type := Black);
--   function  Get_Pixel    (X, Y: in Integer) return Color_Type;
--   procedure Put_Pixel    (X, Y: in Integer;           Hue: in Color_Type := White);
   procedure Draw_Line    (X1, Y1, X2, Y2: in Integer; Hue: in Color_Type := White);
   procedure Draw_Box     (X1, Y1, X2, Y2: in Integer; Hue: in Color_Type := White; Filled: in Fill_Type  := No_Fill);
   procedure Draw_Circle  (X, Y, Radius: in Integer;   Hue: in Color_Type := White; Filled: in Fill_Type  := No_Fill);
   procedure Draw_Ellipse (X1, Y1, X2, Y2: in Integer; Hue: in Color_Type := White; Filled: in Fill_Type  := No_Fill);
   procedure Display_Text (X, Y: in Integer; Text: in String; Hue: in Color_Type := White);


   ----------------------
   -- Polydraw support --
   ----------------------

   function  Where_X return Integer;
   function  Where_Y return Integer;
   procedure Goto_XY (X, Y: in Integer);
   procedure Draw_To (X, Y: in Integer; Hue: in Color_Type := White);

   ----------------------
   -- Some extensions  --
   ----------------------

   -- Enable/Disable Antialiasing

   procedure Set_Antialiasing(On : in Boolean);

   -- "Set_Immediate_Rendering (False)" retains drawing to screen until subsequent
   -- "Set_Immediate_Rendering (True)".
   -- Use this procedure for avoiding the flickering of simple animations

   procedure Set_Immediate_Rendering(On : in Boolean);

   -- Creates a remote control surface defined by a Java Class wich sends back OSC Messages
   -- to the given Host, and UDP Port

   procedure Create_Control_Surface(Class_Name: in String; Host_Name: in String; OSC_Port: in Port_Type);

   -- Destroy the last opened control surface

   procedure Destroy_Control_Surface;

end Remote_Adagraph;

