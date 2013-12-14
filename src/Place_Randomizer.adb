with Ada.Numerics.Discrete_Random;
with Site;

package body Place_Randomizer is

   package Integer_Randomizer is new Ada.Numerics.Discrete_Random(Integer);
   package Input_Randomizer is new Ada.Numerics.Discrete_Random(Site.Input_Places);
   package Output_Randomizer is new Ada.Numerics.Discrete_Random(Site.Output_Places);

   Integer_Generator: Integer_Randomizer.Generator;
   Input_Generator: Input_Randomizer.Generator;
   Output_Generator: Output_Randomizer.Generator;

   function Random_Input return Site.Input_Places is
   begin
	return Input_Randomizer.Random(Input_Generator);
   end Random_Input ;

   function Random_Output return Site.Output_Places is
   begin
	return Output_Randomizer.Random(Output_Generator);
   end Random_Output ;

begin
   Integer_Randomizer.Reset(Gen => Integer_Generator);

   Input_Randomizer.Reset(Gen =>Input_Generator,
                          Initiator => Integer_Randomizer.Random(Integer_Generator));

   Output_Randomizer.Reset(Gen => Output_Generator,
                          Initiator => Integer_Randomizer.Random(Integer_Generator));

end Place_Randomizer;
