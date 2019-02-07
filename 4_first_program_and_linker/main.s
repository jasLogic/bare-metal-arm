.syntax	unified
.arch	armv7-m

.global	__StackTop

.section .isr_vector
.align	2
.global _isr_vector
_isr_vector:
	.long	__StackTop /* we will need this later */
	.long	Reset_Handler
	.long	Default_Handler
	.long	Default_Handler
	.long	Default_Handler
	.long	Default_Handler
	.long	Default_Handler
	.long	0
	.long	0
	.long	0
	.long	0
	.long	Default_Handler
	.long	Default_Handler
	.long	0
	.long	Default_Handler
	.long	Default_Handler


.text
.thumb
.thumb_func
.align	2
.global	Reset_Handler
.type	Reset_Handler, %function
Reset_Handler:
	mov	r0, #0
	mov	r1, #42
loop:
	add	r0, r0, #1
	b	loop


Default_Handler:
	b	.
