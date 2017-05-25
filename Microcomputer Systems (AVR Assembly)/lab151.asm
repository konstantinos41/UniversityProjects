; LAB1 - Microprocessor Systems, ECE, AUTH
; Mavrodis Konstantinos - 7922
; Schinas  Georgios     - 7985
; This program computes the sum of our AEM numbers, 
; lights up the LEDs according to our AEMs and its sum 
; according to the timing described in the lab-discription 

.include "8515def.inc"
.org 0
.cseg

.def mavrodisH = r27
.def mavrodisL = r26
.def schinasH = r29
.def schinasL = r28
.def sumH = r31
.def sumL = r30

;Macro that takes an input and lights up the respective LEDs
.MACRO light
	mov r17, @0
	com r17
	out PORTB, r17
.ENDMACRO





; initialization of the stack
StackPointerInitialization:
	ldi r16, low(RAMEND)
	out spl, r16
	ldi r16, high(RAMEND)
	out sph, r16



part1:
	ldi mavrodisL, 0b00100010 ; loading our AEMs in BCD format
	ldi mavrodisH, 0b01111001
	ldi schinasL,  0b10000101
	ldi schinasH,  0b01111001

	ldi r17, 0b01100110 ; numbers that are needed during add 
	ldi r18, 0b01100000 ; to maintain BCD format

	
	mov r19, mavrodisL
	mov r20, schinasL
	add r19,r20
	add r19, r18 ; re need to add this to maintain the BCD format of the result
	sts 0x60, r19
	mov sumL,r19 ; we store the sum in a register


	mov r20, mavrodisH
	mov r21, schinasH
	adc r20, r21 ; we use the instruction adc cause we need to take into account the carry from before
	adc r20, r17 ; we need to add this to maintain the BCD format of the result
	; If there is carry , we ignore it 

	sts 0x61, r20
	mov sumH, r20 ; we store the sum in a register

	; we prepare our output
	ser r16
	out DDRB, r16
	
	; we light up the proper LEDs :see the subroutines for more 
	rcall mavrodis
	rcall schinas
	rcall sum

	
part2:
	; we prepare our input
	clr r17
	out DDRD, r17

	ser r17
	out PIND, r17

	switch1:
		sbic PIND, 0b00000000
		rjmp switch1 ; wating to press the button 0
	
		switch1Stage2:
			sbis PIND, 0
			rjmp switch1Stage2 ; waiting to release the button 0
			; light Mavrodis' AEM 
			rcall mavrodis
	
	switch2:
		sbic PIND, 1
		rjmp switch2 ;  wating to press the button 1
	
		switch2Stage2:
			sbis PIND, 1
			rjmp switch2Stage2 ;waiting to release the button 1
			; light Schinas' AEM 
			rcall schinas


	switch31:
		sbic PIND, 2
		rjmp switch31 ;  wating to press the button 2

		switch31stage3:
			sbis PIND, 2
			rjmp switch31stage3 ;  wating to release the button 2
			
			;we light up the LSB of the sum of our AEMs
			mov r17, sumL
			andi r17, 0b00001111 ; here we erase any junk from the first part of the number
			light r17

	switch32:
		sbic PIND, 2
		rjmp switch32 ;  wating to press the button 2

		switch32stage3:
			sbis PIND, 2
			rjmp switch32stage3 ;  wating to release the button 2
			
			; in order to light only the second BCD character we right shift to move them to the rigth position
			mov r17, sumL
			lsr r17
			lsr r17
			lsr r17
			lsr r17 
			andi r17, 0b00001111 ; here we erase any junk from the first part of the number
			light r17


	switch33:
		sbic PIND, 2
		rjmp switch33 ;  wating to press the button 2

		switch33stage3:
			sbis PIND, 2
			rjmp switch33stage3 ;  wating to release the button 2
	
			mov r17, sumH
			andi r17, 0b00001111 ; here we erase any junk from the first part of the number
			light r17

	switch34:
		sbic PIND, 2
		rjmp switch34 ;  wating to press the button 2

		switch34stage3:
			sbis PIND, 2
			rjmp switch34stage3 ;  wating to release the button 2
	
			; in order to light only the second BCD character we right shift to move them to the rigth position
			mov r17, sumH
			lsr r17
			lsr r17
			lsr r17
			lsr r17 
			andi r17, 0b00001111 ; here we erase any junk from the first part of the number
			light r17

	rjmp part2 ; go back to part2 









mavrodis: ; light the AEM of the person with a delay between the LSByte and MSByte
	light mavrodisL
	rcall delay
	light mavrodisH
	rcall delay
	ret
schinas: ; light the AEM of the person with a delay between the LSByte and MSByte
	light schinasL
	rcall delay
	light schinasH
	rcall delay
	ret
sum: ; light the sum of AEMs with a delay between the LSByte and MSByte
	light sumL
	rcall delay
	light sumH
	rcall delay
	ret


delay: ; 10 seconds (apporximately) delay performed with 3 nested loops
	push r23 ; we save the registers we will use
	push r24
	push r25
	;; the numbers 150-255-255 were manually calculated to perform the desired delay
	ldi r23, 150
		
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


	
	
		
	


