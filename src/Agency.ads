with Robot;
with Adagraph;
with Site;
with Parking;
with Generic_Mailbox;

package Agency is

   procedure Handle_Transfer(From: Site.Input_Places; To: Site.Output_Places);
   procedure Shutdown;

   protected type Signal is
      entry Wait;
      procedure Signal;
   private
      Arrived: Boolean := False;
   end Signal;



private
   task Mission_Listener;
   type Robot_Table is array(Robot.Robot_Id) of access Robot.Object;
   Agency_Robot_Table: Robot_Table;

   Cancel: Signal;
   Agency_Parking: Parking.Object;
   Mailbox:  access Robot.Robot_Mailbox.Object := new Robot.Robot_Mailbox.Object(Robot.Robot_Id'Size);

end Agency;
