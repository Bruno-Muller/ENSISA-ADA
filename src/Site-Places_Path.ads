package Site.Places_Path is

   type Object is private;

   Null_Place_Path: constant Object;

   type Places is array (Natural range <>) of Site.Place_Names;

   function Open(From: in Site.Input_Places; To: Site.Output_Places) return Places_Path.Object;
   function At_End(Path: in Site.Places_Path.Object) return Boolean;
   function Value(Path: in Site.Places_Path.Object) return Site.Place_Names;
   procedure Next(Path: in out Site.Places_Path.Object);

private

   subtype Count is Natural range 0..50;
   subtype Index is Natural range 0..50;

   type Object (Size: Count := 0) is record
      Values: Places(1..Size);
      Actual_Index: Index;
   end record;

   Null_Place_Path : constant Object := Object'(Size => 0, Values => <>, Actual_Index => 0);

end Site.Places_Path;
