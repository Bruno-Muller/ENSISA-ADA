with Robot;
with Adagraph;
with Site;
with Parking;
with Generic_Mailbox;

package Agency is

   -- Fonction appelée pour demander à l'agence de gérer un transfert de robot de From vers To
   procedure Handle_Transfer(From: Site.Input_Places; To: Site.Output_Places);

   -- Ferme l'agence,
   procedure Shutdown;

   -- Signal d'arrêt utilisé par le Listener (cf Cours)
   protected type Signal is
      entry Wait;
      procedure Signal;
   private
      Arrived: Boolean := False;
   end Signal;

private
   -- Task qui surveille les fins de mission de ronot
   task Mission_Listener;

   -- Type pour décrire un tableau de robot
   type Robot_Table is array(Robot.Robot_Id) of access Robot.Object;

   -- Rq: si on voulait créer les tasks robot ici, il aurait fallu utiliser un pragrma
   --     les tasks sont créées dans la partie élaboration du body
   Agency_Robot_Table: Robot_Table;

   -- Signal d'arrêt utilisé par le Listener (cf Cours)
   Cancel: Signal;
   Agency_Parking: Parking.Object;

   -- On créer une mailbox dont la capacité et égale au nombre de robots pouvant exister
   Mailbox:  access Robot.Robot_Mailbox.Object := new Robot.Robot_Mailbox.Object(Robot.Robot_Id'Size);

end Agency;
