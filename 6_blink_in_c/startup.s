.syntax	unified
.arch	armv7-m

.global	__StackTop

.section .isr_vector
.align	2
.global _isr_vector
_isr_vector:
	.long	__StackTop
	.long	reset
	.long	nmi_handler
	.long	hardfault_handler
	.long	memmanage_handler
	.long	busfault_handler
	.long	usagefault_handler
	.long	0
	.long	0
	.long	0
	.long	0
	.long	svc_handler
	.long	debugmonitor_handler
	.long	0
	.long	pendsv_handler
	.long	systick_handler

	.long	default

.text
.thumb
.thumb_func
.align	2
.global	reset
.type	reset, %function
reset:
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
.weak	default
.type	default, %function
default:
	b	.

/* creating a macro to create weak default handlers which are set to thr default handler */
.macro	def_irq handler
.weak	\handler
.set	\handler, default
.endm

def_irq	nmi_handler
def_irq	hardfault_handler
def_irq	memmanage_handler
def_irq	busfault_handler
def_irq	usagefault_handler
def_irq	svc_handler
def_irq	debugmonitor_handler
def_irq	pendsv_handler
def_irq	systick_handler
