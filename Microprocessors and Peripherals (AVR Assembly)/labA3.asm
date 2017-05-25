.include "m16def.inc"
.cseg

.def counter = r22
.def variable = r21


;initialization of necessary vectors
.org 0x0000
	rjmp main
;initialize timer
.org 0x000A
	rjmp TIM1_CAPT
	

main:
	
	; initialize the stack 
	ldi r16, low(RAMEND)
	out spl, r16
	ldi r16, high(RAMEND)
	out sph, r16

	;Next we have to initialize the I/O

	;PortA 
	ldi variable, 0b01111110
	out DDRA, variable

	;PortB
	ser variable
	out DDRB, variable

	;PortD
	ldi variable, 0b10111111
	out DDRD, variable

	;initialize some more stuff
	ldi variable, 0b00000000
	out TCNT1H, variable
	out TCNT1L, variable
	out ICR1H, variable
	out ICR1L, variable
	out ACSR, variable

	ldi variable, 1<<TICIE1
	out TIMSK, variable

	; initialize prescaler
	ldi variable, 0b00000000
	out TCCR1A, variable
	ldi variable, 0b00000011
	out TCCR1B, variable

	inc counter

	sei

wait:
	sbis PINA, 0
	out PORTB, r18
	rjmp wait


TIM1_CAPT:
	cpi counter, 0
	breq reset	
	cpi counter, 1
	breq go
	
	reti

reset:
	ldi counter, 1
	in r20, ICR1L
	sub r20, r17	
	mov r18, r20
	com r18
	
	clr variable
	out TCNT1H, variable
	out TCNT1L, variable	
	out ICR1H, variable
	out ICR1L, variable
	out ACSR, variable	
	reti


go:
	dec counter
	in r17, ICR1L
	reti

