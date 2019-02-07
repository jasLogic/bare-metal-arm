MEMORY {
	FLASH (rw): ORIGIN = 0x8000000, LENGTH = 64K
	RAM (rwx): ORIGIN = 0x20000000, LENGTH = 20K
}

ENTRY(Reset_Handler)
SECTIONS
{	.text : {
		KEEP(* (.isr_vector))
		* (.text*)
	} > FLASH

	__StackTop = ORIGIN(RAM) + LENGTH(RAM);
}
