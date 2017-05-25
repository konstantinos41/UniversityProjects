.include "m16def.inc"
.org 0
.def flag = r25
; macro that lights up the Leds according to input
.MACRO light
	mov r17, @0
	com r17
	out PORTB, r17
.ENDMACRO

; performs the division by counting how many times 6 can fit to our number
.MACRO divide
	push r16
	andi r16, 0
	cpi @0,6
	brlt done 
	loop:
		inc r16
		subi @0,6
		cpi @0,6
		brge loop
	done:
	mov @1, r16
	pop r16
.ENDMACRO

; lights up the Leds for the part2 according to the input and with the same way as in part1
.MACRO light_after_press
	cpi flag , 0 ; the flag knows keeps track for which student we are talking about
	brne step	 ; here we initialize Z to the respective student
	ldi ZH, high(2*Table)
	ldi ZL, low(2*Table)
	rjmp end
	step:
	ldi ZH, high(2*Table2)
	ldi ZL, low(2*Table2)
	end:
	lsl @0  	; here we move Z to point at the grade position we desire
	mov r17 , @0
	cpi r17, 0
	breq goto2
	goto1:
	adiw Z, 1
	dec r17
	brne goto1
	goto2:
	; put to r17 the grade of the subject
	lpm r17, Z+
	mov r16, r17
	lsr r17 ; cutting the 0,5
	andi r17, 0b00001111  ; r17 contains the grade at bits 0-3 --- deleting any grabage in the front
	andi r16, 0b000100000 ; isolate the bit of the grade 10!
	cpi r16, 0
	breq tag1 ; if not 10, skip-- go to tag, else load binary 10
	ldi r17, 0b00001010	
		; put in r18 the code of the subject
	tag1:
	lpm r18, Z+
	lsl r18
	lsl r18
	lsl r18
	lsl r18
	andi r18, 0b11110000 ; formating r18 to be ready for LEDS 7-4
	or r18, r17
	light r18 ;
	
.ENDMACRO

.cseg
; initialize the stack 
StackPointerInitialization:
	ldi r16, low(RAMEND)
	out spl, r16
	ldi r16, high(RAMEND)
	out sph, r16


part1:
	ldi ZH, high(2*Table)
	ldi ZL, low(2*Table)
	
	ldi r21, 12
	ser r16
	out DDRB, r16

	main_loop:	
		; put to r17 the grade of the subject
		lpm r17, Z+
		mov r16, r17
		lsr r17 ; cutting the 0,5
		andi r17, 0b00001111  ; r17 contains the grade at bits 0-3 --- deleting any grabage in the front
		andi r16, 0b000100000 ; isolate the bit of the grade 10!
		cpi r16, 0
		breq tag ; if not 10, skip-- go to tag, else load binary 10
		ldi r17, 0b00001010	

		; put in r18 the code of the subject
		tag:
		lpm r18, Z+
		lsl r18
		lsl r18
		lsl r18
		lsl r18
		andi r18, 0b11110000 ; formating r18 to be ready for LEDS 7-4
		or r18, r17
		light r18 ; the desired result
		rcall delay_5s
		
		; this loop creates a blinking to the leds
		ldi r19, 0x8
		ldi r20, 255
		blink_loop:
			light r20
			com r20
			rcall delay_05s
			dec r19
			brne blink_loop	

		dec r21
		brne main_loop

;----------------------------
	ldi ZH, high(2*Table)
	ldi ZL, low(2*Table)
	andi r19, 0 ; r19 (will) contains the sum
	ldi r16, 6
	sumStart:
	lpm r17, Z+
	adiw Z,1
	mov r18, r17
	andi r18, 0b00100000 ; if the grade is 10, we need to turn it to binary
	cpi r18, 0
	breq lessThanTen
	ldi r17 , 0b00010100
	lessThanTen:
	add r19, r17
	dec r16
	brne sumStart

	; finding the average by dividing sum with six
	divide r19, r19 ; divides r19 with 6 and returns the result to the (second) r19 register
	ori r19, 0b01000000 ; this label means this is for the first student
	light r19
	mov r26, r19 ; we save the result here for later use
	rcall delay_2s
	
	;same as above but for the second student
	andi r19, 0 ; r19 contains the sum
	ldi r16, 6
	sumStart1:
	lpm r17, Z+
	adiw Z,1
	mov r18, r17
	andi r18, 0b00100000
	cpi r18, 0
	breq moveOnDude1
	ldi r17 , 0b00010100
	moveOnDude1:
	add r19, r17
	dec r16
	brne sumStart1

	divide r19, r19
	ori r19, 0b10000000
	light r19
	mov r27, r19 ; we save the result here for later use
	rcall delay_2s

;--------------------------------------- PART 2 -------------------------------------------
part2:
	;preparing the pins
	clr r17
	out DDRD, r17

	ser r17
	out PIND, r17

	ldi ZH, high(2*Table)
	ldi ZL, low(2*Table)
	ldi flag, 0
	;entering infinite loop and wait for press
	wait_for_press:
		sbis PIND, 0
		rjmp switch0_pressed
		sbis PIND, 1
		rjmp switch1_pressed
		sbis PIND, 2
		rjmp switch2_pressed
		sbis PIND, 3
		rjmp switch3_pressed
		sbis PIND, 4
		rjmp switch4_pressed
		sbis PIND, 5
		rjmp switch5_pressed
		sbis PIND, 6
		rjmp switch6_pressed
		sbis PIND, 7
		rjmp switch7_pressed

		rjmp wait_for_press
	
	;if one of these is pressed, we enter the respective infinite loop and wait for release
	switch0_pressed:
		sbis PIND, 0
		rjmp switch0_pressed
		ldi r16, 0
		light_after_press r16 ; when released we light up the led with the correct input
		rcall delay_5s		  ; wait
		ldi r16, 0
		light r16			  ; turn off the led after a while
		rjmp wait_for_press
	switch1_pressed:
		sbis PIND, 1
		rjmp switch1_pressed
		ldi r16, 1
		light_after_press r16
		rcall delay_5s
		ldi r16, 0
		light r16
		rjmp wait_for_press
	switch2_pressed:
		sbis PIND, 2
		rjmp switch2_pressed
		ldi r16, 2
		light_after_press r16
		rcall delay_5s
		ldi r16, 0
		light r16
		rjmp wait_for_press
	switch3_pressed:
		sbis PIND, 3
		rjmp switch3_pressed
		ldi r16, 3
		light_after_press r16
		rcall delay_5s
		ldi r16, 0
		light r16
		rjmp wait_for_press
	switch4_pressed:
		sbis PIND, 4
		rjmp switch4_pressed
		ldi r16, 4
		light_after_press r16
		rcall delay_5s
		ldi r16, 0
		light r16
		rjmp wait_for_press
	switch5_pressed:
		sbis PIND, 5
		rjmp switch5_pressed
		ldi r16, 5
		light_after_press r16
		rcall delay_5s
		ldi r16, 0
		light r16
		rjmp wait_for_press
	; when this is pressed we change the flag that signals for whom student we are lighting up the leds
	switch6_pressed:
		sbis PIND, 6
		rjmp switch6_pressed
		ldi r16, 6
		com flag			;
		rjmp wait_for_press
	; we use r26,r27 where we saved the average from before to speed things up
	switch7_pressed:
		sbis PIND, 7
		rjmp switch7_pressed
		ldi r16, 7
		cpi flag, 0
		breq mpampis
		light r27 ; for seconde student
		rjmp mpampis2
		mpampis:
		light r26 ; for first student
		mpampis2:
		rjmp wait_for_press


;---------------------------
Table: ; Schinas
	.dw 0b0001000100010001; texniki mixaniki
	.dw 0b0001001000010000; fusiki
	.dw 0b0001001100001111; sustimata
	.dw 0b0001010000100000; logismos
	.dw 0b0001010100100000; grammiki
	.dw 0b0001011000010001; sxedio
Table2: ; Mavrodis
	.dw 0b0001000100010010; texniki mixaniki
	.dw 0b0001001000001010; fusiki
	.dw 0b0001001100100000; sustimata
	.dw 0b0001010000001011; logismos
	.dw 0b0001010100100000; grammiki
	.dw 0b0001011000010001; sxedio
;----------------------------

rjmp part1

;delays - no need to be explained
delay_5s:
	push r23
	push r24
	push r25
		
	ldi r23, 75
		
	tag23:			
		ldi r24, 255
			
		tag24:				
			ldi r25, 255
				
			tag25:
				nop
				dec r25
				brne tag25
				
			dec r24	
			brne tag24

		dec r23	
		brne tag23		

	pop r25
	pop r24
	pop r23
	ret

delay_2s:
	push r23
	push r24
	push r25
		
	ldi r23, 30
		
	tag23b:			
		ldi r24, 255
			
		tag24b:				
			ldi r25, 255
				
			tag25b:
				nop
				dec r25
				brne tag25b
				
			dec r24	
			brne tag24b

		dec r23	
		brne tag23b	

	pop r25
	pop r24
	pop r23
	ret

delay_05s:
	push r23
	push r24
	push r25
		
	ldi r23, 7
		
	tag23c:			
		ldi r24, 255
			
		tag24c:				
			ldi r25, 255
				
			tag25c:
				nop
				dec r25
				brne tag25c
				
			dec r24	
			brne tag24c

		dec r23	
		brne tag23c

	pop r25
	pop r24
	pop r23
	ret




