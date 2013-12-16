with Robot;

package Parking is

   protected type Object is
      entry Take(Id: out Robot.Robot_Id);
      procedure Park(Id: in Robot.Robot_Id);
   end Object;


end Parking;
