	.data

str:
str_a:	.asciiz "a("
str_b:	.asciiz "b("
str_d:	.asciiz "d("
str_,:	.asciiz ","
str_e:	.asciiz ")="
str_s:	.asciiz "     "
str_n:  .asciiz "\n\n"

	.text
	
main:	
	addi $s4, $zero, 3				#boithitikos kataxwritis
	
	lui $a1, 0x1000					#fortwsi dieuthinsewn mnimis twn pinakwn stous kataxwrites a1,a2,a3
	ori $a1, $a1, 0x0000
	lui $a2, 0x1000
	ori $a2, $a2, 0x0100
	lui $a3, 0x1000
	ori $a3, $a3, 0x0200

A:
	li $s0, 0						#i=0
A_loop_i:	
	li $s1, 0						#j=0
	jal A_loop_j	
	addi $s0, $s0, 1				#i=i+1
	bne $s0, $s4, A_loop_i			#if(i!=3) xanatrexe
	j B

A_loop_j:	
	la $a0, str_a					#print a(i,j)=
	addi $v0, $zero, 4
	syscall							
	add $a0, $zero, $s0
	addi $v0, $zero, 1
	syscall							
	
	la $a0, str_,					
	addi $v0, $zero, 4
	syscall
	
	add $a0, $zero, $s1
	addi $v0, $zero, 1
	syscall
	
	la $a0, str_e,
	addi $v0, $zero, 4
	syscall
	
	li $t0, 0				#dieuthinsi= dieuthinsi basis + (i*3+j)*4
	add $t0, $s0, $s0
	add $t0, $t0, $s0
	
	add $t0, $t0, $s1
	
	add $t1, $t0, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	
	add $t1, $t1, $a1
	
	li $v0,7					#insert value to f0
	syscall
	
	sdc1 $f0, 0($t1)			#value to stack
	
	
	addi $s1, $s1, 1
	bne $s1, $s4, A_loop_j
	j $ra

B:
	li $s0, 0
B_loop_i:	
	li $s1, 0	
	jal B_loop_j	
	addi $s0, $s0, 1	
	bne $s0, $s4, B_loop_i
	j D

B_loop_j:
	
	la $a0, str_b
	addi $v0, $zero, 4
	syscall
	add $a0, $zero, $s0
	addi $v0, $zero, 1
	syscall
	
	la $a0, str_,
	addi $v0, $zero, 4
	syscall
	
	add $a0, $zero, $s1
	addi $v0, $zero, 1
	syscall
	
	la $a0, str_e
	addi $v0, $zero, 4
	syscall
	
	li $t0, 0
	add $t0, $s0, $s0
	add $t0, $t0, $s0
	
	add $t0, $t0, $s1
	
	add $t1, $t0, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0	
	add $t1, $t1, $a2
	
	li $v0,7
	syscall
	sdc1 $f0, 0($t1)
	
	
	addi $s1, $s1, 1
	bne $s1, $s4, B_loop_j
	jr $ra


D:
	li $s0, -1
D_loop_i:
	
	li $s1, -1
	addi $s0, $s0, 1
	beq $s0, $s4, end_print
	
	la $a0, str_n					#print change line
	addi $v0, $zero, 4
	syscall
	
	j D_loop_j
	
	
D_loop_j:
	
	li $s2, 0
	addi $s1, $s1, 1
	beq $s1, $s4, D_loop_i
	
	la $a0, str_d					#print d(i,j)
	addi $v0, $zero, 4
	syscall
	
	add $a0, $zero, $s0
	addi $v0, $zero, 1
	syscall							
	
	la $a0, str_,					
	addi $v0, $zero, 4
	syscall
	
	add $a0, $zero, $s1
	addi $v0, $zero, 1
	syscall
	
	la $a0, str_e,
	addi $v0, $zero, 4
	syscall
	
	j D_loop_k
	

D_loop_k:
	
	li $t0, 0
	add $t0, $s0, $s0
	add $t0, $t0, $s0
	
	add $t0, $t0, $s2
	
	add $t1, $t0, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	add $t1, $t1, $t0
	
	add $t1, $t1, $a1			#t1=dieuthinsi a[i][k]
	
	li $t0, 0
	add $t0, $s2, $s2
	add $t0, $t0, $s2
	
	add $t0, $t0, $s1
	
	add $t2, $t0, $t0
	add $t2, $t2, $t0
	add $t2, $t2, $t0
	add $t2, $t2, $t0
	add $t2, $t2, $t0
	add $t2, $t2, $t0
	add $t2, $t2, $t0
	
	add $t2, $t2, $a2			#t2=dieuthinsi b[k][j]
	
	
	li $t0, 0
	add $t0, $s0, $s0
	add $t0, $t0, $s0
	
	add $t0, $t0, $s1
	
	add $t3, $t0, $t0
	add $t3, $t3, $t0
	add $t3, $t3, $t0
	add $t3, $t3, $t0
	add $t3, $t3, $t0
	add $t3, $t3, $t0
	add $t3, $t3, $t0
	
	add $t3, $t3, $a3			#t3=dieuthinsi d[i][j]
	
	ldc1 $f0, 0($t1)
	ldc1 $f2, 0($t2)
	
	
	mul.d $f4, $f0, $f2
	add.d $f12, $f12, $f4
	
	
	addi $s2, $s2, 1
	bne $s2, $s4, D_loop_k
	
	sdc1 $f12, 0($t3)			#apothikeusi apotelesmatos sto stack
	
	li $v0, 3					#print result
	syscall
	
	la $a0, str_s				#print space					
	addi $v0, $zero, 4
	syscall
	
	add.d $f12, $f6, $f6		#f12=0 afou o f6 exei ex' orismou timi 0
	j D_loop_j

	
end_print:						#telos programmatos