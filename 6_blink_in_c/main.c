#define RCC_APB2ENR	*((int *)(0x40021000 + 0x18))
#define GPIOC_CRH	*((int *)(0x40011000 + 0x04))
#define GPIOC_BSRR	*((int *)(0x40011000 + 0x10))
#define GPIOC_BRR	*((int *)(0x40011000 + 0x14))

static int initialized_data = 31415;
static int uninitialized_data;
static const int read_only_data = 27182;

int main(void)
{
	/*
	initialized_data += ro_data;
	uninitialized_data = initialized_data;*/

	/* enable the GPIOC clock in RCC_APB2ENR register */
	RCC_APB2ENR = (1 << 4);
	/* set PC13 as output in GPIOC_CRH */
	GPIOC_CRH = (1 << 20);

	while(1) {
		int i;

		/* set PC13 in GPIOC_BSRR register */
		GPIOC_BSRR = (1 << 13);
		/* delay loop */
		for(i = 0; i < 200000; ++i);
		/* reset PC13 in GPIOC_BRR reister */
		GPIOC_BRR = (1 << 13);
		/* delay loop */
		for(i = 0; i < 200000; ++i);
	}
}
