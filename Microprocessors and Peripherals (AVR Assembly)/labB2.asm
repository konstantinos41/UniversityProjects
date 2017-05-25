.include "m16def.inc"
.cseg

.def variable = r26
.def counter = r25

.org 0x0000
	rjmp reset

.org 0x0012
	rjmp TIM0_OVFL

reset:
	ldi variable, high(RAMEND)
	out SPH, variable
	ldi variable, low(RAMEND)
	out SPL, variable
	
	;init TIMSK -> TOIE0==1
	ldi variable, 1<<TOIE0
	out TIMSK, variable

	;**TIMER0**
	
	;init TCNT0
	ldi variable, 12
	out TCNT0, variable

	;init TCCR0
	ldi variable, 0b00000101
	out TCCR0, variable

	ldi counter, 16

	ldi variable,0b00100000
	out DDRD, variable
	ldi variable,0b01111110
	out DDRA, variable
	ldi variable,0b11111111
	out DDRB, variable
	
	;**TIMER1**
	
	;TCCR1B/A
	ldi variable,0b11000010
	out TCCR1A, variable
	ldi variable,0b00000001
	out TCCR1B, variable

	;OCR1AH/L
	ldi variable,1
	out OCR1AH, variable
	ldi variable,54
	out OCR1AL, variable

	
	;init r17
	ldi r17, 0
	out PORTB, r17	
	;init r23
	ldi r23, 0xFF

	sei

loop:
	rjmp loop

increase:
	in r18, OCR1AH
	out PORTB, r17

	in variable, OCR1AL
	subi variable, 26
	brcc without

	dec r18

without:
	out OCR1AH, r18
	out OCR1AL, variable

	ret

decrease:
	in r18,OCR1AH
	out PORTB, r17

	in variable, OCR1AL
	ldi r19, 26
	add variable, r19
	brcc without2

	inc r18

without2:
	out OCR1AH, r18
	out OCR1AL, variable

	ret

TIM0_OVFL:
	dec counter
	brne restart

	ldi counter,16
	cpi r17, 10
	breq inverse

df: 
	inc r17
	cpi r23, 0
	breq decrease
	call increase

	rjmp restart

decrease:
	call decrease

	rjmp restart

inverse:
	com r23
	clr r17

	rjmp df

restart:
	ldi variable, 12
	out TCNT0,variable

	reti
