package body Generic_Mailbox is

   protected body Object is

      Procedure Shift (I: in out Positive) is
      begin
         if I=Size then
            I:= 1;
         else
            I:= I + 1;
         end if;
      end Shift;

      entry Put(Msg: in Message) when Count/=Size is
      begin
         Shift(Last);
         Content(Last) := Msg;
         Count := Count + 1;
      end Put;

      entry Get(Msg: out Message) when Count>0 is
      begin
         Msg := Content(First);
         Shift(First);
         Count := Count - 1;
      end Get;

   end Object;

end Generic_Mailbox;
