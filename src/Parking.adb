with Site;
with Robot;
with Ada.Numerics.Discrete_Random;

package body Parking is


   protected body Object is

      entry Take(Id: out Robot.Robot_Id) when Has_Disponible_Robots is
      begin

         Id := Robot_Id_Randomizer.Random(Robot_Id_Generator);
         for Attempt_Number in Robot.Robot_Id'First..Robot.Robot_Id'Last loop
            if Occupied_Park_Place(Id) then
               exit;
            else
               if Id=Robot.Robot_Id'Last then
                  Id:=Robot.Robot_Id'First;
               else
                  Id := Id + 1;
               end if;
            end if;
         end loop;

         Site.Safely.Hide_Robot_Park(Place  => Id,
                                     Radius => Robot.Radius);
      end Take;

      procedure Park(Id: in Robot.Robot_Id) is
      begin
         Site.Safely.Draw_Robot_Park(Place  => Id,
                                     Radius => Robot.Radius);
      end Park;

      function Has_Disponible_Robots return Boolean is
      begin
         for Id in Parking_Robot_Table'First..Parking_Robot_Table'Last loop
            if Occupied_Park_Place(Id) then
               return True;
            end if;
         end loop;
         return False;
      end Has_Disponible_Robots;

   end Object;

end Parking;
