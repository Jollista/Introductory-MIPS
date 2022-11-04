# 
# Name:		Watson, June
# Homework:	#4
# Due:		3/21/2022
# Course: 	cs-2640-03-sp22 
# 
# Description:
#	Creates and prints an array where each element is a power of two
# 

	.data
header:	.asciiz	"Array by J. Watson\n\n"
pow2:	.word	0:10

	.text
main:
	la	$a0, header	#Print header
	li	$v0, 4
	syscall

				#Input loop

	la	$t1, pow2	#set t1 to address of first value in array
	li	$t0, 0		#i=0
while0:	bge	$t0, 10, endw0	#outer input loop, for(i=0;i<10;i++)
	li	$t2, 0			#j=0
	li	$t3, 1			#power=1
while1:	bge	$t2, $t0, endw1		#inner input loop, for(j=0;j<i;j++)
	mul	$t3, $t3, 2		#power=power*2
	addi	$t2, $t2, 1		#j++
	b	while1			#loop
endw1:	sw	$t3, ($t1)	#pow2[i]=power
	addi	$t1, $t1, 4	#set t1 to address of next value in array
	addi	$t0, $t0, 1	#i++
	b	while0		#loop
endw0:	

				#Output loop

	la	$t1, pow2	#set t1 to address of first value in array
	li	$t0, 0		#i=0
while2:	bge	$t0, 10, endw2	#output loop, for(i=0;i<10;i++)
	lw	$a0, ($t1)	#print $t1
	li	$v0, 1
	syscall
	li	$a0, '\n'	#output newline
	li	$v0, 11
	syscall
	addi	$t1, $t1, 4	#set t1 to address of next value in array
	addi	$t0, $t0, 1	#i++
	b	while2		#loop
endw2:
	li	$v0, 10
	syscall