generic
   type Resource_Id is (<>);

package Generic_Mailbox is

   protected type Mailbox is
      procedure Put(Id: in Resource_Id);
      procedure Get(Id: out Resource_id);
   end Mailbox;

end Generic_Mailbox;
