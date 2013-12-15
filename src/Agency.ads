with Robot;
with Adagraph;
with Site;

package Agency is

   procedure Handle_Transfer(From: Site.Input_Places; To: Site.Output_Places);
   procedure Shutdown;


private

   type Robot_Table is array(Integer range <>) of access Robot.Object;

   Agency_Robot_Table: Robot_Table(1..6) := (new Robot.Object,
                                             new Robot.Object(1, null, Adagraph.Blue),
                                             new Robot.Object(2, null, Adagraph.Red),
                                             new Robot.Object(3, null,  Adagraph.Cyan),
                                             new Robot.Object(4, null, Adagraph.Magenta),
                                             new Robot.Object(5, null, Adagraph.Yellow));
end Agency;
