with neorv32.TRNG; use neorv32.TRNG;
package body Random is

   procedure Init is
   begin
      for I in 0 .. 1_000_000 loop
         null;
      end loop;
      TRNG_Periph.CTRL.TRNG_CTRL_EN := 1;
      TRNG_Periph.CTRL.TRNG_CTRL_FIFO_CLR := 1;
      -- Put_Line("TRNG_EN is at the end of Init : " & TRNG_Periph.CTRL.TRNG_CTRL_EN'Image);
   end Init;

   function Random return Byte is
      N : Byte;
   begin
      if (TRNG_Periph.CTRL.TRNG_CTRL_AVAIL) /= 0 then
         N := TRNG_Periph.DATA.TRNG_DATA;
      else 
         N:= 16#FF#;
      end if;
      return N;
   end Random;

end Random;



--  The TRNG provides two memory mapped interface register. One control register (CTRL) for configuration and 
--  status check and one data register (DATA) for obtaining the random data. The TRNG is enabled by setting 
--  the control register’s TRNG_CTRL_EN. As soon as the TRNG_CTRL_AVAIL bit is set a new random data byte is 
--  available and can be obtained from the lowest 8 bits of the DATA register. If this bit is cleared, there is 
--  no valid data available and the reading DATA will return all-zero.