with Site; use Site;
with Site.Places_Path;
with Place_Resource_Pool;

package body Robot.Trajectory.Safe is

   -- Ouvre un chemin
   procedure Open(Safe_Trajectory: in out Object; From: Site.Input_Places; To: Site.Output_Places; Speed: in Float) is
   begin
      Safe_Trajectory.Place_Path_Object := Site.Places_Path.Open(From => From, To => To);
      Safe_Trajectory.From := From;
      Safe_Trajectory.To := To;
      Safe_Trajectory.On_Departure := True;
      Safe_Trajectory.In_Place := True;

      -- Le robot attend de pouvoir se placer sur la place d'entrée
      Pool.Acquire(From);

      -- Une fois que le robot a accçs à la place d'entée, on ouvre le chemin
      Robot.Trajectory.Open(Trajectory_Object => Safe_Trajectory.Trajectory_Object,
                            From  => From,
                            To    => To,
                            Speed => Speed);
   end Open;

   -- Déplace le robot pour un certain deltaT
   procedure Next(Safe_Trajectory: in out Object; DeltaT: in Float) is
      Pth: Site.Places_Path.Places := Site.Places_Path.Values(Safe_Trajectory.Place_Path_Object);
      Request: Pool.Request_Map := (others => False);
      Pnt: Path.Point;
   begin
      -- Si le robot vient tout juste d'arriver sur la place d'entée alors
      -- c'est sa première tentative de déplacement et il faut dabord acquérir le reste des ressources
      if Safe_Trajectory.On_Departure=True then

         -- On crée la requête
         for P in Pth'First..Pth'Last loop
            -- On prend soin de ne pas inclure la place d'entrée qui est déjà acquise par le robot
            if Pth(P)/=Safe_Trajectory.From then
               Request(Pth(P)) := True;
            end if;
         end loop;

         -- On demande d'acquérir les ressources de la requête (procédure bloquante)
         Pool.Acquire(Request);

         Safe_Trajectory.On_Departure := False;
      end if;

      -- On déplace le robot
      Robot.Trajectory.Next(Trajectory_Object => Safe_Trajectory.Trajectory_Object,
                            DeltaT => DeltaT);

      -- On va vérifier si le robot vient tout juste de libérer une place
      Pnt := Robot.Trajectory.XY(Safe_Trajectory.Trajectory_Object);
      if not Site.Robot_Intersects(Site.Places_Path.Value(Safe_Trajectory.Place_Path_Object),Pnt.X, Pnt.Y) and Safe_Trajectory.In_Place then
         -- Le robot vient de libérer une place
         Safe_Trajectory.In_Place := False;

         -- On libère la ressource
         Pool.Release(Site.Places_Path.Value(Safe_Trajectory.Place_Path_Object));

         -- Dorénavant ce teste de libération de place protera sur la prochaine place
         Site.Places_Path.Next(Safe_Trajectory.Place_Path_Object);
      elsif Site.Robot_Intersects(Site.Places_Path.Value(Safe_Trajectory.Place_Path_Object),Pnt.X, Pnt.Y) and not Safe_Trajectory.In_Place then
         Safe_Trajectory.In_Place := True;
      end if;

   end Next;

   -- Fermer un chemin
   procedure Close(Safe_Trajectory: in out Object) is
   begin
      -- On libère la dernière ressource
      -- Rq: Ne pas faire l'erreur de vouloir libérer toutes les ressources acquises au début est libérée au fur et à mesure
      --     car les ressources pourraient être acquises par d'autres robots entre temps
      Pool.Release(Safe_Trajectory.To);
   end Close;

   -- Quand le robot est sur la place d'entrée, et qu'il attend que les autres ressouces soient disponibles
   function Is_On_Departure(Safe_Trajectory: in Object) return Boolean is
   begin
      return Safe_Trajectory.On_Departure;
   end Is_On_Departure;

   -- Récupère la trajectory de la "safe" trajectory
   function Get_Trajectory(Safe_Trajectory: in out Object) return Robot.Trajectory.Object is
   begin
      return Safe_Trajectory.Trajectory_Object;
   end Get_Trajectory;

end Robot.Trajectory.Safe;
