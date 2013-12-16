with Site;

package body Parking is

   protected body Object is

      entry Take(Id: out Robot.Robot_Id) when True is
      begin

         Id := 0; -- TODO aléatoire + truc bloquant


         Site.Safely.Hide_Robot_Park(Place  => Id,
                                     Radius => Robot.Radius);
      end Take;

      procedure Park(Id: in Robot.Robot_Id) is
      begin
         Site.Safely.Draw_Robot_Park(Place  => Id,
                                     Radius => Robot.Radius);
      end Park;

   end Object;

end Parking;
