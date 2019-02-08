#include "stm32f10x.h"

void SystemInit(void)
{
	// Enable HSE
	SET_BIT(RCC->CR, 0x10000);
	// wait for HSE to be ready
	while(!(RCC->CR & 0x20000));

	// PLLSRC
	SET_BIT(RCC->CFGR, 0x10000);
	// PLLXTPRE
	CLEAR_BIT(RCC->CFGR, 0x20000);
	// PLLMUL
	SET_BIT(RCC->CFGR, 0x1c0000);
	// PLLON
	SET_BIT(RCC->CR, 0x1000000);
	// wait for PLL to be ready
	while(!(RCC->CR & 0x2000000));

	// ADCPRE, PPRE1
	SET_BIT(RCC->CFGR, 0x8000); // ADC max 14 MHz
	SET_BIT(RCC->CFGR, 0x400); // APB1 max 34 MHz

	// configure flash latency !!!
	SET_BIT(FLASH->ACR, 0b10);

	// SW: PLL as SysClk input
	SET_BIT(RCC->CFGR, 0b10);

	// 72 MHz are configured
}

int main(void)
{
	// enable the GPIOC and GPIOB clock in RCC_APB2ENR register
	SET_BIT(RCC->APB2ENR, 0x10);
	SET_BIT(RCC->APB2ENR, 0x8);

	// set PC13 (onboard LED) as output in GPIOC_CRH
	SET_BIT(GPIOC->CRH, 0x100000);

	// set PB12 as an input with pull up/down
	CLEAR_BIT(GPIOB->CRH, 0xc0000); // reset state is 0b01 -> clear first
	SET_BIT(GPIOB->CRH, 0x80000);
	// set pull up
	SET_BIT(GPIOB->ODR, 0x1000);

	while(1) {
		if (GPIOB->IDR & 0x1000) {
			// PC13 sinks current so cleared output -> LED on
			GPIOC->BRR = 0x2000;
		} else {
			GPIOC->BSRR = 0x2000;
		}
	}

	return 0;
}
