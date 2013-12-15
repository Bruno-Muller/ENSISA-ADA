generic
   type Resource_Id is (<>);

package Generic_Mailbox is

   protected type Mailbox is
      procedure Put(Id: Resource_Id);
   end Mailbox;

end Generic_Mailbox;
