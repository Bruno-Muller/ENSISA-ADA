with Robot;

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
      select
         Cancel.Wait;
      then abort
         while True loop
            Mailbox.Get(Id);
            Agency_Parking.Park(Id);
         end loop;
      end select;
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
   for I in Robot.Robot_Id'First..Robot.Robot_Id'Last loop
      Agency_Robot_Table(I) := new Robot.Object(I, Mailbox, Robot.Robot_Color(I));
   end loop;
end Agency;
