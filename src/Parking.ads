with Robot;
with Ada.Numerics.Discrete_Random;

package Parking is

   protected type Object is
      entry Take(Id: out Robot.Robot_Id);
      procedure Park(Id: in Robot.Robot_Id);
   private
      function Has_Disponible_Robots return Boolean;
   end Object;

private
   package Robot_Id_Randomizer is new Ada.Numerics.Discrete_Random(Robot.Robot_Id);
   Robot_Id_Generator: Robot_Id_Randomizer.Generator;

   type Parking_Robot_Table is array(Robot.Robot_Id) of Boolean;
   Occupied_Park_Place: Parking_Robot_Table := (others => True);

end Parking;
