with Robot;
with Ada.Numerics.Discrete_Random;

package Parking is

   protected type Object is
      -- obtient l'id d'un robot disponible pour une mission, bloque si pas de robot disponible
      entry Take(Id: out Robot.Robot_Id);

      -- rend un robot disponible pour de nouvelles missions
      procedure Park(Id: in Robot.Robot_Id);
   private
      -- permet de vérifer si des robots sont disponibles sur le parking
      function Has_Disponible_Robots return Boolean;
   end Object;

private
   -- Un Randomizer d'id de robot pour attribué équitablement des missions aux robots

   package Robot_Id_Randomizer is new Ada.Numerics.Discrete_Random(Robot.Robot_Id);
   Robot_Id_Generator: Robot_Id_Randomizer.Generator;

   -- Parking contenant des id de robot
   type Parking_Robot_Table is array(Robot.Robot_Id) of Boolean;
   Occupied_Park_Place: Parking_Robot_Table := (others => True);

end Parking;
