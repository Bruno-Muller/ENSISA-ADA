with Site;

-- Randomizer de place d'entrée et de sortie
package Place_Randomizer is

   -- Obtient une place d'entée aléatoire
   function Random_Input return Site.Input_Places;

   -- Obtient une place de sortie aléatoire
   function Random_Output return Site.Output_Places;

end Place_Randomizer;
