package Site.Places_Path is

   type Object is private;

   Null_Places_Path: constant Object;

   type Places is array (Natural range <>) of Site.Place_Names;

   function Open(From: in Site.Input_Places; To: Site.Output_Places) return Places_Path.Object;
   function At_End(Path: in Site.Places_Path.Object) return Boolean;
   function Value(Path: in Site.Places_Path.Object) return Site.Place_Names;
   procedure Next(Path: in out Site.Places_Path.Object);

private

   subtype Count is Natural range 0..50;
   subtype Cursor is Natural range 0..50;

   type Object (Size: Count := 0) is record
      Values: Places (1..Size);
      Index: Cursor :=0;
   end record;

   procedure Add(Path: in out Places_Path.Object; Place: in Place_Names);

   Null_Places_Path : constant Object := Object'(Size => 0, Values => <>, Index => 0);

end Site.Places_Path;
