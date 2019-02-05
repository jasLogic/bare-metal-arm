MEMORY {
	FLASH (rw): ORIGIN = 0x8000000, LENGTH = 64K
	RAM (rwx): ORIGIN = 0x20000000, LENGTH = 20K
}

ENTRY(reset)
SECTIONS
{	.text : {
		KEEP(* (.isr_vector))
		* (.text*)
	} > FLASH

	_stack_top = ORIGIN(RAM) + LENGTH(RAM);
}
