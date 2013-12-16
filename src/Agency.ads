with Robot;
with Adagraph;
with Site;
with Parking;

package Agency is

   procedure Handle_Transfer(From: Site.Input_Places; To: Site.Output_Places);
   procedure Shutdown;


private

   type Robot_Table is array(Robot.Robot_Id range <>) of access Robot.Object;

   Agency_Parking: Parking.Object;
   Agency_Robot_Table: Robot_Table(1..6) := (new Robot.Object(1, null, Adagraph.Green),
                                             new Robot.Object(2, null, Adagraph.Blue),
                                             new Robot.Object(3, null, Adagraph.Red),
                                             new Robot.Object(4, null,  Adagraph.Cyan),
                                             new Robot.Object(5, null, Adagraph.Magenta),
                                             new Robot.Object(6, null, Adagraph.Yellow));

end Agency;
