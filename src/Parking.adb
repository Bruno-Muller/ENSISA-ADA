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

         Occupied_Park_Place(Id) := False;

         Site.Safely.Hide_Robot_Park(Place  => Id,
                                     Radius => Robot.Radius);
      end Take;

      procedure Park(Id: in Robot.Robot_Id) is
      begin
         Occupied_Park_Place(Id) := True;

         Site.Safely.Draw_Robot_Park(Place  => Id,
                                     Radius => Robot.Radius,
                                     Clr => Robot.Robot_Color(Id));
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

begin
   for I in Robot.Robot_Id'First..Robot.Robot_Id'Last loop

      Site.Safely.Draw_Robot_Park_Place(Place  => I,
                                        Radius => Robot.Radius);
      Site.Safely.Draw_Robot_Park(Place  => I,
                                  Radius => Robot.Radius,
                                  Clr => Robot.Robot_Color(I));

   end loop;

end Parking;
