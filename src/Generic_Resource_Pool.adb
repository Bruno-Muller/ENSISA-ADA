package body Generic_Resource_Pool is

   procedure Acquire(Map : in Request_Map) is
   begin
      null; -- TODO
   end Acquire;

   procedure Acquire(Id: in Resource_Id) is
   begin
      null; -- TODO
   end Acquire;

   procedure Release(Map: in Request_Map) is
   begin
      null; -- TODO
   end Release;

   procedure Release(Id: in Resource_Id) is
   begin
      null; -- TODO
   end Release;

   protected body Resource is

      procedure Release is
      begin
         Acquired := False;
      end Release;

      entry Acquire when not Acquired is
      begin
         Acquired := True;
      end Acquire;

   end Resource;

end Generic_Resource_Pool;
