package body Generic_Resource_Pool is

   procedure Acquire(Map : in Request_Map) is
   begin
      for Rsc in Resource_Id'First..Resource_Id'Last loop
         if Map(Rsc) then
            Acquire(Rsc);
         end if;
      end loop;
   end Acquire;

   procedure Acquire(Id: in Resource_Id) is
   begin
      Resource_Pool(Id).Acquire;
   end Acquire;

   procedure Release(Map: in Request_Map) is
   begin
      for Rsc in Resource_Id'First..Resource_Id'Last loop
         if Map(Rsc) then
            Release(Rsc);
         end if;
      end loop;
   end Release;

   procedure Release(Id: in Resource_Id) is
   begin
      Resource_Pool(Id).Release;
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
