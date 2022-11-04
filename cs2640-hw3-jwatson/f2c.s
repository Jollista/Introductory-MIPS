# 
# Name:     Watson, June
# Homework: # 3
# Due:       
# Course:   cs-2640-03-sp22 
# 
# Description: 
#           Fahrenheit to Celcius
#           temperature converter in assembly
# 

.data
    head:   .ascii  "Temperature by J. Watson\n\n"
    inmsg:  .asciiz "Enter degree in F? "
    fzero:  .float  0.0
    oumsg:  .asciiz " C"
    num1:   .float  32.0
    num2:   .float  5.0
    num3:   .float  9.0

.text
main:
    # Print header and input prompt
    li  $v0, 4
    la  $a0, head
    syscall

    la  $a0, inmsg
    syscall

    # Get user input
    li  $v0, 6
    syscall

    # Calculate degrees C
    ldc1    $f2, num1
    ldc1    $f4, num2
    ldc1    $f6, num3
    sub.s     $f0, $f0, $f2
    mul.s     $f0, $f0, $f4
    div.s     $f0, $f0, $f6

    # Print out degrees C and output message
    ldc1    $f4, fzero
    li      $v0, 2
    add.s   $f12, $f0, $f4
    syscall

    li  $v0, 4
    la  $a0, oumsg
    syscall

    # terminate
    li  $v0, 10
    syscall