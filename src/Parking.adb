with Robot;
with Ada.Numerics.Discrete_Random;
with Site;

package body Parking is


   protected body Object is

      -- obtient l'id d'un robot disponible pour une mission, bloque si pas de robot disponible
      entry Take(Id: out Robot.Robot_Id) when Has_Disponible_Robots is
      begin
         -- On prend un id de robot au hasard
         Id := Robot_Id_Randomizer.Random(Robot_Id_Generator);

         -- On parcours la liste des robots non pas du premier jusqu'au dernier
         -- mais à partir de l'id pris au hasard (en bouclant pour revenir au début)
         -- On est sûr de trouver un robot disponible dans cette boucle for grace au when
         for Attempt_Number in Robot.Robot_Id'First..Robot.Robot_Id'Last loop
            if Occupied_Park_Place(Id) then
               -- On a trouvé un id de robot disponible, on arrête de chercher
               exit;
            else
               if Id=Robot.Robot_Id'Last then
                  -- on est à la fin de la liste,
                  -- le robot suivant est le premier robot du tableau
                  Id:=Robot.Robot_Id'First;
               else
                  -- on testera la disponibilité du robot suivant
                  Id := Id + 1;
               end if;
            end if;
         end loop;

         -- Marque le robot comme n'étant plus disponible
         Occupied_Park_Place(Id) := False;

         -- On ne vas pas effacer le robot du parking maintenat
         -- car il se peut que le robot soit en attente pour acquérir la place d'entrée
         --Site.Safely.Hide_Robot_Park(Place  => Id, Radius => Robot.Radius);

      end Take;

      -- rend un robot disponible pour de nouvelles missions
      procedure Park(Id: in Robot.Robot_Id) is
      begin
         -- Marque le robot comme disponible
         Occupied_Park_Place(Id) := True;

         -- on déssine le robot sur son parking
         Site.Safely.Draw_Robot_Park(Place  => Id,
                                     Radius => Robot.Radius,
                                     Clr => Robot.Robot_Color(Id));
      end Park;

      -- permet de vérifer si des robots sont disponibles sur le parking
      function Has_Disponible_Robots return Boolean is
      begin
         for Id in Parking_Robot_Table'First..Parking_Robot_Table'Last loop
            if Occupied_Park_Place(Id) then
               -- on a trouvé un robot disponible
               return True;
            end if;
         end loop;
         -- on a pas trouvé de robot disponible
         return False;
      end Has_Disponible_Robots;

   end Object;

begin

   -- On va tracer les places de parking et les robots
   for I in Robot.Robot_Id'First..Robot.Robot_Id'Last loop

      Site.Safely.Draw_Robot_Park_Place(Place  => I,
                                        Radius => Robot.Radius);
      Site.Safely.Draw_Robot_Park(Place  => I,
                                  Radius => Robot.Radius,
                                  Clr => Robot.Robot_Color(I));

   end loop;

end Parking;
