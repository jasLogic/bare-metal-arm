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

/* STM */
	.long	WWDG_IRQHandler
	.long	PVD_IRQHandler
	.long	TAMPER_IRQHandler
	.long	RTC_IRQHandler
	.long	FLASH_IRQHandler
	.long	RCC_IRQHandler
	.long	EXTI0_IRQHandler
	.long	EXTI1_IRQHandler
	.long	EXTI2_IRQHandler
	.long	EXTI3_IRQHandler
	.long	EXTI4_IRQHandler
	.long	DMA1_Channel1_IRQHandler
	.long	DMA1_Channel2_IRQHandler
	.long	DMA1_Channel3_IRQHandler
	.long	DMA1_Channel4_IRQHandler
	.long	DMA1_Channel5_IRQHandler
	.long	DMA1_Channel6_IRQHandler
	.long	DMA1_Channel7_IRQHandler
	.long	ADC1_2_IRQHandler
	.long	USB_HP_CAN1_TX_IRQHandler
	.long	USB_LP_CAN1_RX0_IRQHandler
	.long	CAN1_RX1_IRQHandler
	.long	CAN1_SCE_IRQHandler
	.long	EXTI9_5_IRQHandler
	.long	TIM1_BRK_IRQHandler
	.long	TIM1_UP_IRQHandler
	.long	TIM1_TRG_COM_IRQHandler
	.long	TIM1_CC_IRQHandler
	.long	TIM2_IRQHandler
	.long	TIM3_IRQHandler
	.long	TIM4_IRQHandler
	.long	I2C1_EV_IRQHandler
	.long	I2C1_ER_IRQHandler
	.long	I2C2_EV_IRQHandler
	.long	I2C2_ER_IRQHandler
	.long	SPI1_IRQHandler
	.long	SPI2_IRQHandler
	.long	USART1_IRQHandler
	.long	USART2_IRQHandler
	.long	USART3_IRQHandler
	.long	EXTI15_10_IRQHandler
	.long	RTCAlarm_IRQHandler
	.long	USBWakeUp_IRQHandler


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

	bl	SystemInit

	bl	main

.thumb_func
.weak	SystemInit
.type	SystemInit, %function
SystemInit:
	/* CR and CFGR to reset values*/
	ldr	r0, =(0x40021000)
	ldr	r1, =(0x83)
	str	r1, [r0]

	ldr	r0, =(0x40021004)
	ldr r1, =(0x0)
	str	r1, [r0]
	bx	r14

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

def_irq NMI_Handler
def_irq HardFault_Handler
def_irq	MemManage_Handler
def_irq	BusFault_Handler
def_irq	UsageFault_Handler
def_irq	SVC_Handler
def_irq	DebugMon_Handler
def_irq	PendSV_Handler
def_irq	SysTick_Handler

def_irq	WWDG_IRQHandler
def_irq	PVD_IRQHandler
def_irq	TAMPER_IRQHandler
def_irq	RTC_IRQHandler
def_irq	FLASH_IRQHandler
def_irq	RCC_IRQHandler
def_irq	EXTI0_IRQHandler
def_irq	EXTI1_IRQHandler
def_irq	EXTI2_IRQHandler
def_irq	EXTI3_IRQHandler
def_irq	EXTI4_IRQHandler
def_irq	DMA1_Channel1_IRQHandler
def_irq	DMA1_Channel2_IRQHandler
def_irq	DMA1_Channel3_IRQHandler
def_irq	DMA1_Channel4_IRQHandler
def_irq	DMA1_Channel5_IRQHandler
def_irq	DMA1_Channel6_IRQHandler
def_irq	DMA1_Channel7_IRQHandler
def_irq	ADC1_2_IRQHandler
def_irq	USB_HP_CAN1_TX_IRQHandler
def_irq	USB_LP_CAN1_RX0_IRQHandler
def_irq	CAN1_RX1_IRQHandler
def_irq	CAN1_SCE_IRQHandler
def_irq	EXTI9_5_IRQHandler
def_irq	TIM1_BRK_IRQHandler
def_irq	TIM1_UP_IRQHandler
def_irq	TIM1_TRG_COM_IRQHandler
def_irq	TIM1_CC_IRQHandler
def_irq	TIM2_IRQHandler
def_irq	TIM3_IRQHandler
def_irq	TIM4_IRQHandler
def_irq	I2C1_EV_IRQHandler
def_irq	I2C1_ER_IRQHandler
def_irq	I2C2_EV_IRQHandler
def_irq	I2C2_ER_IRQHandler
def_irq	SPI1_IRQHandler
def_irq	SPI2_IRQHandler
def_irq	USART1_IRQHandler
def_irq	USART2_IRQHandler
def_irq	USART3_IRQHandler
def_irq	EXTI15_10_IRQHandler
def_irq	RTCAlarm_IRQHandler
def_irq	USBWakeUp_IRQHandler
