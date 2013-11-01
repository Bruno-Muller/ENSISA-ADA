-- Created by Bernard Thirion, 27/04/2010

with OSC_Space;
with OSC_Space.Container;
with OSC_Space.Display;

use OSC_Space;

package OSC_Space.Instances is

   Midi:  OSC_Space.Any := Container.Value("midi",
     (
      Display.Value("noteOn"),
      Display.Value("noteOff")
     )
    );

   Osc_1: OSC_Space.Any := Container.Value("1",
     (
      Display.Value("frequency", "D1"),
      Display.Value("amplitude", "D2")
     )
    );


   Osc_2: OSC_Space.Any := Container.Value("2",
     (
      Display.Value("frequency"),
      Display.Value("amplitude")
     )
    );


   Osc_4: OSC_Space.Any := Container.Value("4",
     (
      Display.Value("noteOn"),
      Display.Value("noteOff")
     )
    );

   Osc:   OSC_Space.Any := Container.Value("oscillator", (osc_1, osc_2, osc_4));

   Root:  OSC_Space.Any := Container.Value("", (Midi, Osc));

end;

