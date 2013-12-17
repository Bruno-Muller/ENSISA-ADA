package body Generic_Resource_Pool is

    -- Acquérir les ressources d'une requête
   procedure Acquire(Map : in Request_Map) is
   begin
      -- On acquière les ressources demandées par la requête
      for Rsc in Resource_Id'First..Resource_Id'Last loop
         if Map(Rsc) then
            Acquire(Rsc); -- bloque si la ressource n'est pas disponible
         end if;
      end loop;
   end Acquire;

   -- Acquérir une ressource en particulier
   procedure Acquire(Id: in Resource_Id) is
   begin
      Resource_Pool(Id).Acquire;
   end Acquire;

   -- Libérer une requête de resource
   procedure Release(Map: in Request_Map) is
   begin
      -- On libère les ressources de la requête
      for Rsc in Resource_Id'First..Resource_Id'Last loop
         if Map(Rsc) then
            Release(Rsc);
         end if;
      end loop;
   end Release;

   -- Libérer une ressource en particulier
   procedure Release(Id: in Resource_Id) is
   begin
      Resource_Pool(Id).Release;
   end Release;

   protected body Resource is

      -- Libérer la ressource
      procedure Release is
      begin
         Acquired := False;
      end Release;

      -- Acquirer la ressource, bloque si la ressource n'est pas disponible
      entry Acquire when not Acquired is
      begin
         Acquired := True;
      end Acquire;

   end Resource;

end Generic_Resource_Pool;
