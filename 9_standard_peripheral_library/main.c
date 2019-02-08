#include "stm32f10x.h"

void SystemInit(void)
{
	// Enable HSE
	SET_BIT(RCC->CR, RCC_CR_HSEON);
	// wait for HSE to be ready
	while(!(RCC->CR & RCC_CR_HSERDY));

	// PLLSRC
	SET_BIT(RCC->CFGR, RCC_CFGR_PLLSRC);
	// PLLXTPRE
	CLEAR_BIT(RCC->CFGR, RCC_CFGR_PLLXTPRE);
	// PLLMUL
	SET_BIT(RCC->CFGR, RCC_CFGR_PLLMULL_2 | RCC_CFGR_PLLMULL_1 | RCC_CFGR_PLLMULL_0);
	// PLLON
	SET_BIT(RCC->CR, RCC_CR_PLLON);
	// wait for PLL to be ready
	while(!(RCC->CR & RCC_CR_PLLRDY));

	// ADCPRE, PPRE1
	SET_BIT(RCC->CFGR, RCC_CFGR_ADCPRE_DIV6); // ADC max 14 MHz
	SET_BIT(RCC->CFGR, RCC_CFGR_PPRE1_DIV2); // APB1 max 36 MHz

	// configure flash latency !!!
	SET_BIT(FLASH->ACR, FLASH_ACR_LATENCY_2);

	// SW: PLL as SysClk input
	SET_BIT(RCC->CFGR, RCC_CFGR_SW_PLL);

	// 72 MHz are configured
}

int main(void)
{
	// enable the GPIOC and GPIOB clock in RCC_APB2ENR register
	SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPCEN);
	SET_BIT(RCC->APB2ENR, RCC_APB2ENR_IOPBEN);

	// set PC13 (onboard LED) as output in GPIOC_CRH
	SET_BIT(GPIOC->CRH, GPIO_CRH_MODE13_0);

	// set PB12 as an input with pull up/down
	CLEAR_BIT(GPIOB->CRH, GPIO_CRH_CNF12); // reset state is 0b01 -> clear first
	SET_BIT(GPIOB->CRH, GPIO_CRH_CNF12_1);
	// set pull up
	SET_BIT(GPIOB->ODR, GPIO_ODR_ODR12);

	while(1) {
		if (GPIOB->IDR & GPIO_IDR_IDR12) {
			// PC13 sinks current so cleared output -> LED on
			GPIOC->BRR = GPIO_BRR_BR13;
		} else {
			GPIOC->BSRR = GPIO_BSRR_BS13;
		}
	}

	return 0;
}
