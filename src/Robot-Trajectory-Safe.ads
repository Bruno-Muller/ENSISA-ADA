with Site;
with Site.Places_Path;
with Generic_Resource_Pool;

package Robot.Trajectory.Safe is

   type Object is private;

   -- Ouvre un chemin
   procedure Open(Safe_Trajectory: in out Object; From: in Site.Input_Places; To: Site.Output_Places; Speed: in Float);

   -- Déplace le robot pour un certain deltaT
   procedure Next(Safe_Trajectory: in out Object; DeltaT: in Float);

   -- Fermer un chemin
   procedure Close(Safe_Trajectory: in out Object);

   -- Récupère la trajectory de la "safe" trajectory
   function Get_Trajectory(Safe_Trajectory: in out Object) return Robot.Trajectory.Object;

   -- Quand le robot est sur la place d'entrée, et qu'il attend que les autres ressouces soient disponibles
   function Is_On_Departure(Safe_Trajectory: in Object) return Boolean;

private

   -- Même principe que le path sauf qu'on ne stocke pas des points X, Y mais des places
   type Object is tagged record
      From:  Site.Input_Places;
      To: Site.Output_Places;
      Trajectory_Object: Robot.Trajectory.Object;
      Place_Path_Object: Site.Places_Path.Object;
      In_Place: Boolean := True;
      On_Departure : Boolean := True;
   end record;

   -- Le pool de places
   package Pool is new Generic_Resource_Pool(Resource_Id => Site.Place_Names);

end Robot.Trajectory.Safe;
