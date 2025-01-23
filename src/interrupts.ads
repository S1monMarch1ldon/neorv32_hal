with HAL; use HAL;

package Interrupts is

   procedure Init;

   type Interrupt_Handler is access procedure;
   procedure Install_Uart0_Rx_Interrupt_Handler (Handler : Interrupt_Handler);

   procedure Global_Machine_Interrupt_Enable;

end Interrupts;