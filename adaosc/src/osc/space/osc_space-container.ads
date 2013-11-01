-- Created by Bernard Thirion, 27/04/2010

with OSC_Space;

package OSC_Space.Container is

   type Object is new OSC_Space.Object with private;

   function  Value(Name: String) return Object;
   function  Value(Name: String; Children:OSC_Space.Objects) return Object;

   function  Value(Name: String; Children:OSC_Space.Objects) return OSC_Space.Any;

   overriding procedure Tell (Self: in Object; Message: in String;
                              Arguments: in OSC_Argument.Arguments);

   overriding procedure Free (Self: in out Object); -- no reference counting use with care or avoid shared nodes

   procedure Add(Self: in out Object; Child:    OSC_Space.Any);
   procedure Add(Self: in out Object; Children: OSC_Space.Objects  );

private

    type Cell;
    type Cell_Ref is access Cell;

    type Cell is record
	   Value: OSC_Space.Any;
	   Next:  Cell_Ref;
    end record;

   type Object is new OSC_Space.Object with record
	  First_Child:  Cell_Ref;
	  Last_Child:   Cell_Ref;
   end record;

   function Can_Handle(O: in Object; Message: in String) return Boolean;

end;

