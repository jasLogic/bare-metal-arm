.syntax	unified
.arch	armv7-m

.global	_stack_top

.section .isr_vector
.align	2
.global _isr_vector
_isr_vector:
	.long	_stack_top
	.long	reset

	.long	default
	.long	default
	.long	default
	.long	default
	.long	default
	.long	0
	.long	0
	.long	0
	.long	0
	.long	default
	.long	default
	.long	0
	.long	default
	.long	default


.text
.thumb
.thumb_func
.align	2
.global	reset
.type	reset, %function
reset:
	mov	r0, #0
	mov	r1, #42
loop:
	add	r0, r0, #1
	b	loop

default:
	b	.
