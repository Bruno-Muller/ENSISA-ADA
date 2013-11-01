-- Created by Bernard Thirion 23/04/2010

with Nio_Buffer.Byte_Buffer;
with Constant_Byte_Source;
use  Constant_Byte_Source, Nio_Buffer.Byte_Buffer;

package OSC_Packet_Instances is

   NUL: constant Byte  := 0;                 -- String terminator

   P1: constant Bytes := Bytes'(1..1 => 0); -- padding constants
   P2: constant Bytes := Bytes'(1..2 => 0);
   P3: constant Bytes := Bytes'(1..3 => 0);

   M1: constant Constant_Byte_Source.Object := Value(
                                                     As_Bytes ("/oscillator/4/frequency") & NUL &
                                                     As_Bytes (",fiss"                  ) & NUL & P2 &
                                                     Bytes'(16#43#, 16#dc#, 0, 0        ) &
                                                     Bytes'(1..4 => 16#FF#              ) &
                                                     As_Bytes ("hello world !"          ) & NUL & P2 &
                                                     As_Bytes ("hello universe !"       ) & NUL & P3
                                                    );


   M2: constant Constant_Byte_Source.Object := Value(
                                                     As_Bytes ("/oscillator/4/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"                ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  1              ) &
                                                     Bytes'(0, 0, 0,  15             ) &
                                                     Bytes'(0, 0, 0, 100             )
                                                    );


   M3: constant Constant_Byte_Source.Object := Value(
                                                     As_Bytes ("/music/midi/betaOn") & NUL & P1 &
                                                     As_Bytes (",ifi"              ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  60           ) &
                                                     Bytes'(16#43#, 16#dc#, 0, 0   ) &
                                                     Bytes'(16#FF#, 16#FF#, 0, 0   )
                                                    );


   B1: constant Constant_Byte_Source.Object := Value(
                                                     As_Bytes ("#bundle"     ) & NUL &
                                                     Bytes'(  0, 0, 0,   7   ) &               -- Time Tag 1
                                                     Bytes'(128, 0, 0,  32   ) &               -- Time Tag 2
                                                     Bytes'(  0, 0, 0,  40   ) &               -- Size
                                                     As_Bytes ("/midi/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"        ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  1      ) &
                                                     Bytes'(0, 0, 0,  15     ) &
                                                     Bytes'(0, 0, 0, 100     ) &               -- end of first bundle element
                                                     Bytes'(7, 7, 7,   7     )                 -- Should be ignored by parser, not part of the message
                                                    );


   B2: constant Constant_Byte_Source.Object := Value(
                                                     As_Bytes ("#bundle"     ) & NUL &
                                                     Bytes'(  0, 0, 0,   0   ) &               -- Time Tag 1
                                                     Bytes'(  0, 0, 0,   0   ) &               -- Time Tag 2
                                                     Bytes'(  0, 0, 0,  40   ) &               -- Size
                                                     As_Bytes ("/midi/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"        ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  1      ) &
                                                     Bytes'(0, 0, 0, 60      ) &
                                                     Bytes'(0, 0, 0, 80      ) &               -- end of first bundle element
                                                     Bytes'(7, 7, 7,  7      ) &               -- Should be ignored by parser, not part of the element

                                                     Bytes'(  0, 0, 0,  36   ) &
                                                     As_Bytes ("/midi/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"        ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  2      ) &
                                                     Bytes'(0, 0, 0, 77      ) &
                                                     Bytes'(0, 0, 0, 88      ) &

                                                     Bytes'(  0, 0, 0,  36   ) &
                                                     As_Bytes ("/midi/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"        ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  3      ) &
                                                     Bytes'(0, 0, 0, 34      ) &
                                                     Bytes'(0, 0, 0, 56      )
                                                    );

   B3: constant Constant_Byte_Source.Object := Value(
                                                     As_Bytes ("#bundle"     ) & NUL &
                                                     Bytes'(  0, 0, 0,   0   ) &
                                                     Bytes'(  0, 0, 0,   0   ) &
                                                     Bytes'(  0, 0, 0,  36   ) &
                                                     As_Bytes ("/midi/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"        ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  1      ) &
                                                     Bytes'(0, 0, 0,  2      ) &
                                                     Bytes'(0, 0, 0,  3      ) &

                                                     Bytes'(  0, 0, 0,  56   ) &
                                                     As_Bytes ("#bundle"     ) & NUL &
                                                     Bytes'(  0, 0, 0,   7   ) &
                                                     Bytes'(  0, 0, 0,   8   ) &
                                                     Bytes'(  0, 0, 0,  36   ) &
                                                     As_Bytes ("/midi/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"        ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  4      ) &
                                                     Bytes'(0, 0, 0,  5      ) &
                                                     Bytes'(0, 0, 0,  6      ) &

                                                     Bytes'(  0, 0, 0,  36   ) &
                                                     As_Bytes ("/midi/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"        ) & NUL & P3 &
                                                     Bytes'(0, 0, 0,  7      ) &
                                                     Bytes'(0, 0, 0,  8      ) &
                                                     Bytes'(0, 0, 0,  9      ) &

                                                     Bytes'(  0, 0, 0,  36   ) &
                                                     As_Bytes ("/midi/noteOn") & NUL & P3 &
                                                     As_Bytes (",iii"        ) & NUL & P3 &
                                                     Bytes'(0, 0, 0, 10      ) &
                                                     Bytes'(0, 0, 0, 11      ) &
                                                     Bytes'(0, 0, 0, 12      )
                                                    );

end;

