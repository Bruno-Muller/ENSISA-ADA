generic
   type Message is (<>);

   -- Type générique de mailbox contenant des messages (cf cours)
package Generic_Mailbox is

   -- Tableau de messages
   type Messages is array(Positive range <>) of Message;

   -- l'objet protété de Mailbox
   protected type Object(Size: Positive) is
      entry Put(Msg: in Message); -- bloquant si la mailbox est pleine
      entry Get(Msg: out Message); -- bloquant si la mailbox est vide
   private
      -- Une sorte de buffer/tableau circulaire
      Content: Messages(1..Size);
      First: Positive := 1;
      Last: Positive := Size;
      Count: Natural := 0;
   end;

end Generic_Mailbox;
