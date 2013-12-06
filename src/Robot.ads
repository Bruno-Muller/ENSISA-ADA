with Adagraph; use Adagraph;
with Path; use Path;

package Robot is

   task type Object(Color: Color_Type := Light_Green) is
      entry Follow(P: Path.Object);
      entry Shutdown;
   end Object;

end Robot;
