.syntax	unified
.arch	armv7-m

.global	__StackTop

.section .isr_vector
.align	2
.global _isr_vector
_isr_vector:
	.long	__StackTop
	.long	Reset_Handler
	.long	NMI_Handler
	.long	HardFault_Handler
	.long	MemManage_Handler
	.long	BusFault_Handler
	.long	UsageFault_Handler
	.long	0
	.long	0
	.long	0
	.long	0
	.long	SVC_Handler
	.long	DebugMon_Handler
	.long	0
	.long	PendSV_Handler
	.long	SysTick_Handler
	

.text
.thumb
.thumb_func
.align	2
.global	Reset_Handler
.type	Reset_Handler, %function
Reset_Handler:
	/* copy variables from flash to ram */
	ldr	r1, =__etext
	ldr	r2, =__data_start__
	ldr	r3, =__data_end__
cloop:
	/* copy loop */
	cmp	r2, r3
	ittt	lt
	ldrlt	r0, [r1], #4
	strlt	r0, [r2], #4
	blt	cloop

	/* init bss (constants) to 0 */
	ldr	r1, =__bss_start__
	ldr	r2, =__bss_end__
	mov	r0, 0
zloop:
	/* zero loop */
	cmp	r1, r2
	itt	lt
	strlt	r0, [r1], #4
	blt	zloop

	bl	main

/* make a weak default handler so that interrupt handlers can overwrite this */
.thumb_func
.weak	Default_Handler
.type	Default_Handler, %function
Default_Handler:
	b	.

/* creating a macro to create weak default handlers which are set to thr default handler */
.macro	def_irq handler
.weak	\handler
.set	\handler, Default_Handler
.endm

def_irq	NMI_Handler
def_irq	HardFault_Handler
def_irq	MemManage_Handler
def_irq	BusFault_Handler
def_irq	UsageFault_Handler
def_irq	SVC_Handler
def_irq	DebugMon_Handler
def_irq	PendSV_Handler
def_irq	SysTick_Handler
