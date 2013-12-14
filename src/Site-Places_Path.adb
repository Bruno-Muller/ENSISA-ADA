package body Site.Places_Path is

   function Open(From: in Site.Input_Places; To: Site.Output_Places) return Places_Path.Object is
   begin


      -- TODO : something like this:


--        Trj.Route := Path.Null_Path;
--        Trj.At_End := False;
--        Trj.Segment := 1;
--        Trj.K := 0.0;
--        Trj.Speed := Speed;
--
--        Path.Add(Trj.Route, Site.Get_Point(Pnt => From));
--        Path.Add(Trj.Route, Site.Get_Point(Site.Way_In(From => From)));
--
--        if Site.Opposite(Site.Way_In(From => From))=Site.Way_Out(To => To) then
--           Path.Add(Trj.Route, Site.Get_Point(Site.C));
--        elsif Site.Next(Site.Next(Site.Way_In(From => From)))=Site.Way_Out(To => To) then
--           Path.Add(Trj.Route, Site.Get_Point(Site.Next(Site.Way_In(From => From))));
--        elsif Site.Previous(Site.Previous(Site.Way_In(From => From)))=Site.Way_Out(To => To) then
--           Path.Add(Trj.Route, Site.Get_Point(Site.Previous(Site.Way_In(From => From))));
--        end if;
--
--        Path.Add(Trj.Route, Site.Get_Point(Site.Way_Out(To => To)));
--        Path.Add(Trj.Route, Site.Get_Point(Pnt => To));




      return Null_Place_Path;
   end Open;

   function At_End(Path: in Site.Places_Path.Object) return Boolean is
   begin
      return Path.Size>=Path.Actual_Index;
   end At_End;

   function Value(Path: in Site.Places_Path.Object) return Site.Place_Names is
   begin
      return Path.Values(Path.Actual_Index);
   end Value;

   procedure Next(Path: in out Site.Places_Path.Object) is
   begin
      Path.Actual_Index := Path.Actual_Index + 1;
   end Next;

end Site.Places_Path;
