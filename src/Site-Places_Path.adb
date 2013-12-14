package body Site.Places_Path is

   function Open(From: in Site.Input_Places; To: Site.Output_Places) return Places_Path.Object is
      Path: Places_Path.Object := Null_Places_Path;
   begin
      Add(Path, From);
      Add(Path, Site.Way_In(From => From));

      if Site.Opposite(Site.Way_In(From => From))=Site.Way_Out(To => To) then
         Add(Path, Site.C);
      elsif Site.Next(Site.Next(Site.Way_In(From => From)))=Site.Way_Out(To => To) then
         Add(Path, Site.Next(Site.Way_In(From => From)));
      elsif Site.Previous(Site.Previous(Site.Way_In(From => From)))=Site.Way_Out(To => To) then
         Add(Path, Site.Previous(Site.Way_In(From => From)));
      end if;

      if Site.Way_In(From => From)/=Site.Way_Out(To => To) then
         Add(Path, Site.Way_Out(To => To));
      end if;

      Add(Path, To);

      return Path;
   end Open;

   function At_End(Path: in Site.Places_Path.Object) return Boolean is
   begin
      return Path.Index>Path.Size;
   end At_End;

   function Value(Path: in Site.Places_Path.Object) return Site.Place_Names is
   begin
      return Path.Values(Path.Index);
   end Value;

   procedure Next(Path: in out Site.Places_Path.Object) is
   begin
      Path.Index := Path.Index + 1;
   end Next;

   procedure Add(Path: in out Places_Path.Object; Place: in Place_Names) is
   begin
      Path := Object'(Size => Path.Size+1, Values => Path.Values & Place, Index => 1);
   end Add;

end Site.Places_Path;
