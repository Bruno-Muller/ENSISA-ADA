with Robot;
with Adagraph;
with Site;
with Parking;

package Agency is

   procedure Handle_Transfer(From: Site.Input_Places; To: Site.Output_Places);
   procedure Shutdown;

   task Mission_Listener is

   end Mission_Listener;

   protected type Cancel is
      entry Wait;
      procedure Signal;
   private
      Canceled: Boolean := False;
   end Cancel;

private

   type Robot_Table is array(Robot.Robot_Id) of access Robot.Object;

   Agency_Parking: Parking.Object;
   Agency_Robot_Table: Robot_Table := (new Robot.Object(1, null, Adagraph.Green),
                                       new Robot.Object(2, null, Adagraph.Blue),
                                       new Robot.Object(3, null, Adagraph.Red),
                                       new Robot.Object(4, null, Adagraph.Cyan),
                                       new Robot.Object(5, null, Adagraph.Magenta),
                                       new Robot.Object(6, null, Adagraph.Yellow));
   Signal: Cancel;

end Agency;
