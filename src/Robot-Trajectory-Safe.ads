with Site;
with Site.Places_Path;
with Generic_Resource_Pool;

package Robot.Trajectory.Safe is

   type Object is private;

   procedure Open(Safe_Trajectory: in out Object; From: in Site.Input_Places; To: Site.Output_Places; Speed: in Float);
   procedure Next(Safe_Trajectory: in out Object; DeltaT: in Float);
   procedure Close(Safe_Trajectory: in out Object);
   function Get_Trajectory(Safe_Trajectory: in out Object) return Robot.Trajectory.Object;
   function Is_On_Departure(Safe_Trajectory: in Object) return Boolean;

private

   type Object is tagged record
      From:  Site.Input_Places;
      To: Site.Output_Places;
      Trajectory_Object: Robot.Trajectory.Object;
      Place_Path_Object: Site.Places_Path.Object;
      In_Place: Boolean := True;
      On_Departure : Boolean := True;
   end record;

   package Pool is new Generic_Resource_Pool(Resource_Id => Site.Place_Names);

end Robot.Trajectory.Safe;
