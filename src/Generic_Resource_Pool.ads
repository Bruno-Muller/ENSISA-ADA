generic
   type Resource_Id is private;

package Generic_Resource_Pool is

   type Request_Map is array(1..19) of Boolean;

   procedure Acquire(Map : in Request_Map);
   procedure Acquire(Id: in Resource_Id);
   procedure Release(Map: in Request_Map);
   procedure Release(Id: in Resource_Id);

private
   protected Resource is
      entry Acquire;
      procedure Release;
   end;

end Generic_Resource_Pool;
