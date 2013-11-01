-- Created by Bernard Thirion 04/05/2010

package Midi is

   type    Object is limited interface;
   subtype Class  is Object'Class;
   type    Any    is access all Class;

   procedure Note_On      (Self: in out Object; Channel, Key, Velocity: Natural)  is abstract;
   procedure Bend         (Self: in out Object; Channel: Natural; Value: Integer) is abstract;
   procedure All_Notes_Off(Self: in out Object; Channel: Natural)                 is abstract;

end;

