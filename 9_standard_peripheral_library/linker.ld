MEMORY {
	FLASH (rw): ORIGIN = 0x8000000, LENGTH = 64K /* vlt 800 000 */
	RAM (rwx): ORIGIN = 0x20000000, LENGTH = 20K
}

ENTRY(Reset_Handler)
SECTIONS
{	.text : {
		KEEP(* (.isr_vector))
		* (.text*)
		* (.rodata*)
		__etext = ALIGN(4);
	} > FLASH

	.data : AT(__etext) {
		__data_start__ = .;
		* (.data*)
		. = ALIGN(4);
		__data_end__ = .;
	} > RAM

	.bss : {
		. = ALIGN(4);
		__bss_start__ = .;
		* (.bss*)
		. = ALIGN(4);
		__bss_end__ = .;
	} > RAM

	__StackTop = ORIGIN(RAM) + LENGTH(RAM);
}
