with Site;
with Site.Places_Path;
with Generic_Resource_Pool;

package Robot.Trajectory.Safe is

   type Object is private;

   procedure Open(Sf_Trj: in out Object; From: in Site.Input_Places; To: Site.Output_Places; Speed: in Float);
   procedure Next(Sf_Trj: in out Object; DeltaT: in Float);
   procedure Close(Sf_Trj: in out Object);
   function Get_Trajectory(Sf_Trj: in out Object) return Robot.Trajectory.Object;

private

   type Object is tagged record
      From:  Site.Input_Places;
      To: Site.Output_Places;
      Trj: Robot.Trajectory.Object;
      Plc: Site.Places_Path.Object;
      In_Place: Boolean := False;
   end record;

   package Pool is new Generic_Resource_Pool(Resource_Id => Site.Place_Names);

end Robot.Trajectory.Safe;
