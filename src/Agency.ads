with Robot;
with Adagraph;
with Site;

package Agency is

   procedure Handle_Transfert(From: Site.Input_Places; To: Site.Output_Places);
   procedure Shutdown;


private

   type Robot_Table is array(Integer range <>) of access Robot.Object;

   Agency_Robot_Table: Robot_Table(1..6) := (new Robot.Object,
                                         new Robot.Object(Adagraph.Blue),
                                         new Robot.Object(Adagraph.Red),
                                         new Robot.Object(Adagraph.Cyan),
                                         new Robot.Object(Adagraph.Magenta),
                                         new Robot.Object(Adagraph.Yellow));
end Agency;
