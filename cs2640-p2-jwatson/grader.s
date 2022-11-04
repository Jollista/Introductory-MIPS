# 
# Name:		Watson, June 
# Project:	# 2
# Due:		April 1st, 2022 
# Course:	cs-2640-03-sp22 
# 
# Description: 
#	A program to sort an array using a selection sort algorithm, find its average,
#	and output the array.


	.data
grades:	.word	14, 36, 20, 23, 6, 17, 38, 49, 13, 50, 56, 49, 93, 55, 22, 63, 6, 68, 19, 51, 47, 77, 11, 16, 96, 51, 49, 78, 84, 97, 95, 89, 59, 16, 23, 11, 34, 3, 21, 32, 16, 82, 24, 90, 83, 39, 48, 11, 75, 19, 79, 92, 46, 80, 53, 34, 38, 16, 82, 24, 78, 59, 93, 63, 1, 12, 92, 48, 17, 38, 84, 31, 60, 79, 98, 97, 19, 17, 38, 93, 69, 29, 11, 70, 69, 31, 67, 19, 46, 9, 9, 44, 72
header: .asciiz	"Grader by J. Watson\n\n"
origin:	.asciiz	"Original:\n"
sorted:	.asciiz	"Sorted:\n"
avg:	.asciiz	"Average = "
	.text
main:
	la	$a0, header	#print header
	li	$v0, 4
	syscall

	la	$a0, origin	#print origin
	syscall

	la	$a0, grades	#unsorted array
	li	$a1, 93		#size
	li	$a2, 8		#num elements to print per line
	jal 	print		#call print

	li	$a0, '\n'	#print two newlines
	li	$v0, 11		#
	syscall			#
	syscall			#

	la	$a0, grades	#unsorted array
	li	$a1, 93		#size
	jal	selsort		#call selsort

	la	$a0, sorted	#print origin
	li	$v0, 4		#
	syscall			#

	la	$a0, grades	#sorted array
	li	$a1, 93		#size
	li	$a2, 8		#num elements to print per line
	jal	print		#call print
	
	li	$a0, '\n'	#print two newlines
	li	$v0, 11		#
	syscall			#
	syscall			#

	la	$a0, avg	#print avg message
	li	$v0, 4		#
	syscall			#

	la	$a0, grades	#sorted array
	li	$a1, 93		#size
	jal	getave		#call getave, return value: v0

	move	$a0, $v0	#print return value, v0
	li	$v0, 1		#
	syscall			#

	li	$a0, '\n'	#print newline
	li	$v0, 11		#
	syscall			#

	li	$v0, 10		#end program
	syscall

#
# void selsort (address int array, int size)
#	sorts array of length size using a selection sort algorithm
# parameters:
#	a0: address int array
#	a1: size
# return values:
#	rtype void, so no value returned
#
selsort:	li	$t0, 0			#startScan = 0
		move	$t1, $a0		#values[]=array
		move	$t2, $a1		#t2=size
		sub	$t2, $t2, 1		#t2=size-1
while0:		bge	$t0, $t2, endw0		#while(startScan < size-1)

		move	$t3, $t0		#minIndex = startScan
		lw	$t4, ($t1)		#minValue = values[startScan]

		move	$t5, $t0		#index = startScan
		addi	$t5, $t5, 1		#index = startScan+1
		addi	$t6, $t1, 4		#t6=[index]
while1:		bge	$t5, $a1, endw1		#while (index < size)
		lw	$t7, ($t6)		#t7=values[index]

		bge	$t7, $t4, endif0	#if values[index] < minValue
		move	$t4, $t7		#minValue=values[index]
		move	$t3, $t5		#minIndex=index
endif0:		
		addi	$t5, $t5, 1		#index++
		addi	$t6, $t6, 4		#increment to next address
		b	while1			#loop(inner)
endw1:
		lw	$t6, ($t1)		#t6=values[startScan]
		mul	$t7, $t3, 4		#
		add	$t7, $t7, $a0		#t7=[minIndex]
		sw	$t6, ($t7)		#values[minIndex]=values[startScan]
		sw	$t4, ($t1)		#values[startScan]=minValue

		addi	$t0, $t0, 1		#startScan++
		addi	$t1, $t1, 4		#increment to next address
		b	while0			#loop(outer)
endw0:
		jr	$ra			#end of procedure


#
# void print (address int array, int size, int perline)
#	prints elements in array of length size perline elements per line
# parameters:
#	a0: address int array
#	a1: size
#	a2: number of elements printed per line
# return values:
#	rtype void, so no value returned
#
print:	li	$t0, 0			#index = 0
	move	$t1, $a0		#values[] = array
	move	$t2, $a1		#t2=size
	sub	$t2, $t2, 1		#t2=size-1
while2:	bge	$t0, $t2, endw2		#while (index < size-1)
	
	sub	$t4, $a1, $t0		#t4=size-1-index
					#@12th row, should print 5 elements instead of 8
	blt	$t4, $a2, endif1	#if (size - index >= num elements per line)
	move	$t4, $a2		#then t4 = num elements per line, else size-1-index
endif1:
	li	$t3, 0			#j = 0
while3:	bge	$t3, $t4, endw3		#while (j < t4)

	lw	$a0, ($t1)		#print values[index]
	li	$v0, 1			#
	syscall				#

	li	$a0, '\t'		#print tab
	li	$v0, 11			#
	syscall				#

	addi	$t3, $t3, 1		#j++
	addi	$t0, $t0, 1		#index++
	addi	$t1, $t1, 4		#increment to next address
	b	while3			#loop
endw3:

	li	$a0, '\n'		#print newline
	li	$v0, 11			#
	syscall				#

	b	while2			#loop
endw2:
	
	jr	$ra			#end of procedure

#
# int getave (address int array, int size)
#	calculates the average of the elements in array of length size
# parameters:
#	a0: address int array
#	a1: size
# return values:
#	v0: average of elements in array
#
getave:	li	$t0, 0		#index = 0
	move	$t1, $a0	#values[] = array
	move	$t2, $a1	#t2=size
	sub	$t2, $t2, 1	#t2=size-1

	li	$t3, 0		#sum=0
while4:	bge	$t0, $t2, endw4	#while (t0 < size-1)
	lw	$t4, ($t1)	#t4 = values[index]
	add	$t3, $t3, $t4	#sum += values[index]
	addi	$t0, $t0, 1	#index++
	addi	$t1, $t1, 4	#increment to next address
	b	while4		#loop
endw4:
	div	$v0, $t3, $a1
	jr	$ra