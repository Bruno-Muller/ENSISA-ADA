package body Parking is

   protected body Object is

      entry Take(Id: out Robot.Robot_Id) when True is
      begin
         Id := 0;
      end Take;

      procedure Park(Id: Robot.Robot_Id) is
      begin
         null;
      end Park;

   end Object;

end Parking;
