.include "m16def.inc"

.def variable = r25

.org 0x0000
	rjmp start


.cseg

start:
	ldi variable, high(RAMEND)
	out SPH, variable
	ldi variable, low(RAMEND)
	out SPL, variable

	ldi variable,0b01111110
	out DDRA, variable
	ldi variable,0b11111111
	out DDRB, variable
	ldi variable,0b00100000
	out DDRD, variable
	ldi variable,0b11000010
	out TCCR1A, variable

	;prescaler
	ldi variable,0b00000001
	out TCCR1B, variable

	;duty cycle increase
	ldi variable, 1
	out OCR1AH, variable
	ldi variable, 154
	out OCR1AL, variable

	clr r17

loop:
	sbis PINA, 0 
	rjmp incr

	sbis PINA, 7
	rjmp decr

	rjmp loop

incr:
	sbic PINA, 0
	rjmp increase

	rjmp incr

increase:
	call delay	
	;get OCR1AH
	in r18, OCR1AH	
	cpi r17, 10
	breq no_inc	
	inc r17
	out PORTB, r17
	
	in variable, OCR1AL
	subi variable, 26
	brcc no_carry
	dec r18	

no_carry:
	out OCR1AH, r18
	out OCR1AL, variable

no_inc:
	rjmp loop

decr:
	sbic PINA, 7
	rjmp decrease
	rjmp decr

decrease:
	call delay

	in r18,OCR1AH	
	cpi r17, 0	
	breq no_inc

	dec r17
	out PORTB, r17

	in variable, OCR1AL
	ldi r19, 26
	add variable, r19
	brcc no_carry

	inc r18

	rjmp no_carry

	
delay:
	ldi r19, 255
outer:
	dec r19
	breq endit
	ldi r20, 255
inner:
	nop
	nop
	dec r20
	breq outer
	rjmp inner

end:
	ret
