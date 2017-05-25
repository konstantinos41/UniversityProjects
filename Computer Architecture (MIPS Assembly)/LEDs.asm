	.data 0x10008000
str:
	.asciiz "Switch 1:"
	.asciiz "\nSwitch 2:"
	.asciiz "\nSwitch 3:"
	.asciiz "\nRun the program:"
	.asciiz "\nLED1 is "
	.asciiz "\nLED2 is "
	.asciiz "\nLED3 is "
	.asciiz "OFF"
	.asciiz "ON"
	
	.text

main:
	addi $s0, $zero, 107      #load asccii of k to s0
	
	and $v0, $v0, $zero
	lui $a0, 0x1000           #Switch 1
	ori $a0, $a0, 0x8000  
	ori $v0, 4
	syscall
	
	and $v0, $v0, $zero
	ori $v0, 5
	syscall
	add $t0, $v0, $zero
	
	and $a0, $a0, $zero        #Switch 2
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x800a
	ori $v0, 4
	syscall
	
	and $v0, $v0, $zero 
	ori $v0, 5
	syscall
	add $t1, $v0, $zero
	
	and $a0, $a0, $zero        #Switch 3
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8015
	ori $v0, 4
	syscall
	
	and $v0, $v0, $zero
	ori $v0, 5
	syscall
	add $t2, $v0, $zero
	
run:
	and $a0, $a0, $zero       #Run the program
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8021
	ori $v0, 4
	syscall
	
	and $v0, $v0, $zero
	ori $v0, 12
	syscall
	add $t3, $v0, $zero
	
	
	
	bne $s0, $v0, run        #compare
	
	j led1	
	
	and $v0, $v0, $zero
	ori $v0, 10
	syscall
	
	jr $ra
	
led1:
	and $a0, $a0, $zero      #LED 1 is...
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8032
	ori $v0, 4
	syscall
	beq $t0, $zero, off1
	bne $t0, $zero, on1

off1:
	and $a0, $a0, $zero #...OFF
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8050
	ori $v0, 4
	syscall
	j led2
	
on1:
	and $a0, $a0, $zero #...ON
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8054
	ori $v0, 4
	syscall
	j led2



	
led2:
	and $a0, $a0, $zero      #LED 2 is...
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x803c
	ori $v0, 4
	syscall
	beq $t1, $zero, off2
	bne $t1, $zero, on2
	
	
off2:
	and $a0, $a0, $zero    #...OFF
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8050
	ori $v0, 4
	syscall
	j led3	
on2:
	and $a0, $a0, $zero     #...ON
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8054
	ori $v0, 4
	syscall
	j led3

led3:
	and $a0, $a0, $zero      #LED 3 is...
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8046
	ori $v0, 4
	syscall
	beq $t2, $zero, off3
	bne $t2, $zero, on3
	
off3:
	and $a0, $a0, $zero #...OFF
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8050
	ori $v0, 4
	syscall
	jr $ra
on3:
	and $a0, $a0, $zero #...ON
	and $v0, $v0, $zero
	lui $a0, 0x1000
	ori $a0, $a0, 0x8054
	ori $v0, 4
	syscall
	jr $ra	