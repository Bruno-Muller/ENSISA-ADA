package body Generic_Resource_Pool is

   procedure Acquire(Map : in Request_Map) is
   begin
      null;
   end Acquire;

   procedure Acquire(Id: in Resource_Id) is
   begin
      null;
   end Acquire;

   procedure Release(Map: in Request_Map) is
   begin
      null;
   end Release;

   procedure Release(Id: in Resource_Id) is
   begin
      null;
   end Release;


   protected body Resource is

      procedure Release is
      begin
         null;
      end Release;

      entry Acquire when true is
      begin
         null;
      end Acquire;

   end Resource;

end Generic_Resource_Pool;
