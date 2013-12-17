package body Generic_Mailbox is

   -- l'objet protégé représentant une mailbox générique contenant des messages (cf cours)
   protected body Object is

      Procedure Shift (I: in out Positive) is -- SP privé (cf Cours)
      begin
         if I=Size then
            I:= 1;
         else
            I:= I + 1;
         end if;
      end Shift;

      -- ajoute un message, bloque si la mailbox est pleine
      entry Put(Msg: in Message) when Count/=Size is
      begin
         Shift(Last);
         Content(Last) := Msg;
         Count := Count + 1;
      end Put;

      -- récupère un message, bloqe si la mailbox est vide
      entry Get(Msg: out Message) when Count>0 is
      begin
         Msg := Content(First);
         Shift(First);
         Count := Count - 1;
      end Get;

   end Object;

end Generic_Mailbox;
