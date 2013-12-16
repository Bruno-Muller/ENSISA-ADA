generic
   type Message is (<>);

package Generic_Mailbox is

   type Messages is array(Positive range <>) of Message;

   protected type Object(Size: Positive) is
      entry Put(Msg: in Message);
      entry Get(Msg: out Message);
   private
      Content: Messages(1..Size);
      First: Positive := 1;
      Last: Positive := Size;
      Count: Natural := 0;
   end;

end Generic_Mailbox;
