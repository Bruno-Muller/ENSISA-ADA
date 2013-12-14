with Site;

generic
   type Resource_Id is (<>);

package Generic_Resource_Pool is

   type Request_Map is array(Resource_Id) of Boolean;

   procedure Acquire(Map : in Request_Map);
   procedure Acquire(Id: in Resource_Id);
   procedure Release(Map: in Request_Map);
   procedure Release(Id: in Resource_Id);

private

   protected type Resource is
      entry Acquire;
      procedure Release;
   private
      Acquired: Boolean := False;
   end;

   Resource_Pool : array(Resource_Id) of Resource;

end Generic_Resource_Pool;
