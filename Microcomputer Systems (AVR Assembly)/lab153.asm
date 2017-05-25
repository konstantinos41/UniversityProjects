.include "m16def.inc"
.org 0

.def currentLedState = r18
.def coldOpen = r19
.def hotOpen = r20
.def numberOfHotTriggers = r21
.def secondsVolume = r22

; macro that lights up the Leds according to input
.MACRO light
	mov r17, @0
	com r17
	out PORTB, r17
.ENDMACRO


.cseg
; initialize the stack 
StackPointerInitialization:
	ldi r16, low(RAMEND)
	out spl, r16
	ldi r16, high(RAMEND)
	out sph, r16


main:
	;preparing the pins
	clr r17
	out DDRD, r17

	ser r17
	out PIND, r17


	ser r16
	out DDRB, r16
	out PORTB, r16
	; initializing the registers we will use
	andi r18, 0
	andi r21, 0
	andi r22, 0
	andi r23, 0
	andi r24, 0
	andi r25, 0
	
	;loop that waits for a key to be pressed. 
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
		sbis PIND, 7
		rjmp switch7_pressed
;up to this point the loop is exactly the same as in our previous excercise
		
		mov r25, numberOfHotTriggers
		lsl r25
		lsl r25
		andi r25, 0b00011100 ; moving the bits of the register in the right position
		andi currentLedState, 0b11100011 ;filitering and keeping the specific bits
		or currentLedState, r25 ;join the two registers modified in the previous lines 

		light currentLedState ;lighting the Led as modified before
; we have a counting system, that only after we count to the number we want, we add the "one second passed" in our logic.
; only then we see if cold or hot or both are open and at the secondsVolum register we add this 'amount of water'. 
; if it exceeds the limit, we exit ! 
		; from here ----
		inc r23
		brne continue
		inc r24
		brne continue
		inc r25
		
		cpi r25, 3
		brlt continue
		
		cpi coldOpen, 0
		breq nextStep
		inc secondsVolume

		nextStep:
		cpi hotOpen, 0
		breq nextStep2
		inc secondsVolume
		
		nextStep2:
		cpi secondsVolume, 56
		brge exit
		; till here --------
		continue:
		rjmp wait_for_press ;loop back to the top, and wait for a button to be pressed

	
	

	;if one of these is pressed, we enter the respective infinite loop and wait for release
	;the logic is the same as for what we did in the previous excercise
	switch0_pressed:
		sbis PIND, 0
		rjmp switch0_pressed
		ldi coldOpen, 1 ;we put the flag of wehter the cold is open or not 
		ori currentLedState, 0b00000001		; this turns on the respective LED 
		rjmp wait_for_press

	switch1_pressed:
		sbis PIND, 1
		rjmp switch1_pressed
		ldi hotOpen, 1 ;we put the flag of wehter the hot is open or not 
		ori currentLedState, 0b00000010 ; this turns on the respective LED 
		inc numberOfHotTriggers ; we need to count the times it is opened 
		rjmp wait_for_press

	switch2_pressed:
		sbis PIND, 2
		rjmp switch2_pressed
		ldi hotOpen, 0 ; close te flag 
		andi currentLedState, 0b11111101	;clode the LED 
		rjmp wait_for_press

	switch3_pressed:
		sbis PIND, 3
		rjmp switch3_pressed
		ldi hotOpen, 1 ; open flag 
		ori currentLedState, 0b00000010 ;open LED
		inc numberOfHotTriggers ; count times hot is opened 
		rjmp wait_for_press

	switch4_pressed:
		ori currentLedState, 0b00100000 ; a little trick we put 
		light currentLedState           ; while you press the button it is lighting 
		sbis PIND, 4
		rjmp switch4_pressed
		andi currentLedState, 0b11011110 ; close LED for cold the the effect-trick 
		ldi coldOpen, 0		 ; close flag 
		rjmp wait_for_press

	switch5_pressed:
		ori currentLedState, 0b01000000 ; same trick as above
		light currentLedState			; 
		sbis PIND, 5			
		rjmp switch5_pressed
		andi currentLedState, 0b10111101  ; close LED for hot and the effect-trick
		ldi hotOpen, 0		; close flag 
		rjmp wait_for_press
		

	switch7_pressed:
		ori currentLedState, 0b10000000 ; same trick 
		light currentLedState
		sbis PIND, 7
		rjmp switch7_pressed
		andi currentLedState, 0b01111100 ; close LEDS for open hot, open cold and effect-trick
		ldi hotOpen, 0 ;close flags 
		ldi coldOpen,0 ; close flags
		rjmp wait_for_press


	
	; exit - lights all LED to signal the exit 
	exit:
		ldi r20, 255
		light r20
		rjmp exit


	
