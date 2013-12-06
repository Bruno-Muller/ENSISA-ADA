package body Robot is

   task body Object is
   begin
      loop
         select
            accept Follow(P: Path.Object) do
               null;
            end;
         or
            accept Shutdown do
               null;
            end;
         end select;
      end loop;
   end;

end Robot;
