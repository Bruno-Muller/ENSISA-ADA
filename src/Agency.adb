with Robot;
with Ada.Text_IO;

package body Agency is

   procedure Handle_Transfer(From: Site.Input_Places; To: Site.Output_Places) is
      Id: Robot.Robot_Id;
   begin
      Agency_Parking.Take(Id);
      Agency_Robot_Table(Id).Go(From => From, To   => To);
   end Handle_Transfer;

   procedure Shutdown is
   begin
      for I in Agency_Robot_Table'First..Agency_Robot_Table'Last loop
         Agency_Robot_Table(I).Shutdown;
      end loop ;

      Cancel.Signal;
   end Shutdown;

   task body Mission_Listener is
      Id: Robot.Robot_Id;
   begin
      Ada.Text_IO.Put_Line("Begin Mission_Listener");

      select
         Cancel.Wait;
      then abort
         while True loop
            Ada.Text_IO.Put_Line("Mission_Listener begin loop");
            Ada.Text_IO.Put_Line("Mission_Listener before get");
            Mailbox.Get(Id);
            Agency_Parking.Park(Id);
            Ada.Text_IO.Put_Line("Listener.Get & Park");
            Ada.Text_IO.Put_Line("Mission_Listener ending loop");
         end loop;
      end select;

      Ada.Text_IO.Put_Line("Mission_Listener ended");
   end Mission_Listener;

   protected body Signal is

      procedure Signal is
      begin
         Arrived:= True;
      end Signal;

      entry Wait when Arrived is
      begin
         Arrived := False;
      end Wait;

   end Signal;
begin
   Ada.Text_IO.Put_Line("Begin Agency");

   --Mailbox := new Robot.Robot_Mailbox.Object(Robot.Robot_Id'Size);
   Agency_Robot_Table := (new Robot.Object(1, Mailbox, Adagraph.Green),
                          new Robot.Object(2, Mailbox, Adagraph.Blue),
                          new Robot.Object(3, Mailbox, Adagraph.Red),
                          new Robot.Object(4, Mailbox, Adagraph.Cyan),
                          new Robot.Object(5, Mailbox, Adagraph.Magenta),
                          new Robot.Object(6, Mailbox, Adagraph.Yellow));


end Agency;
