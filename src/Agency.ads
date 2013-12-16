with Robot;
with Adagraph;
with Site;
with Parking;
with Generic_Mailbox;

package Agency is

   procedure Handle_Transfer(From: Site.Input_Places; To: Site.Output_Places);
   procedure Shutdown;

   task Mission_Listener is

   end Mission_Listener;

   protected type Signal is
      entry Wait;
      procedure Signal;
   private
      Arrived: Boolean := False;
   end Signal;

private

   type Robot_Table is array(Robot.Robot_Id) of access Robot.Object;

   Listener:  access Robot.Robot_Mailbox.Object := new Robot.Robot_Mailbox.Object(Robot.Robot_Id'Size);

   Agency_Parking: Parking.Object;
   Agency_Robot_Table: Robot_Table := (new Robot.Object(1, Listener, Adagraph.Green),
                                       new Robot.Object(2, Listener, Adagraph.Blue),
                                       new Robot.Object(3, Listener, Adagraph.Red),
                                       new Robot.Object(4, Listener, Adagraph.Cyan),
                                       new Robot.Object(5, Listener, Adagraph.Magenta),
                                       new Robot.Object(6, Listener, Adagraph.Yellow));
   Cancel: Signal;

end Agency;
