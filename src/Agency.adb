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

      Signal.Signal;
   end Shutdown;

   task body Mission_Listener is
   begin
      null;
   end Mission_Listener;


   protected body Cancel is

      procedure Signal is
      begin
         Canceled:= True;
      end Signal;

      entry Wait when Canceled is
      begin
         Canceled := False;
      end Wait;

   end Cancel;


end Agency;
