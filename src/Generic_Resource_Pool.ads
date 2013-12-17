with Site;

generic
   type Resource_Id is (<>);

   -- Pool de resource générique
package Generic_Resource_Pool is

   -- Type utilisé pour représenter une requête d'accès aux ressources
   type Request_Map is array(Resource_Id) of Boolean;

   -- Acquérir les ressources d'une requête
   procedure Acquire(Map : in Request_Map);

   -- Acquérir une ressource en particulier
   procedure Acquire(Id: in Resource_Id);

   -- Libérer une requête de resource
   procedure Release(Map: in Request_Map);

   -- Libérer une ressource en particulier
   procedure Release(Id: in Resource_Id);

private

   -- type protéger pour réprésente une ressource
   protected type Resource is
      -- Acquirer la ressource, bloque si la ressource n'est pas disponible
      entry Acquire;

      -- Libérer la ressource
      procedure Release;
   private
      Acquired: Boolean := False;
   end;

   -- Pool de ressource générique
   Resource_Pool : array(Resource_Id) of Resource;

end Generic_Resource_Pool;
