# All program code is placed after the
# .text assembler directive
.text

# Declare main as a global function
.globl	main

j main

# code for fib
fib:
# Entering a new scope.
# Symbols in symbol table:
#  println 
#  i 
#  return 
# Update the stack pointer.
addi $sp $sp 0
lw $t0 -4($sp)
li $t1 0
sub $t0 $t0 $t1
bne $t0 $zero datalabel0
li $t0 1
sw $t0 -8($sp)
j datalabel1
datalabel0:
datalabel1:

lw $t0 -4($sp)
li $t1 1
sub $t0 $t0 $t1
bne $t0 $zero datalabel2
li $t0 1
sw $t0 -8($sp)
j datalabel3
datalabel2:
datalabel3:

# Calling function fib
# Save $ra to a register
move $t0 $ra
# Save $t0-9 registers
sw $t0 -12($sp)
# Evaluate parameters and save to stack
lw $t1 -4($sp)
li $t2 1
sub $t1 $t1 $t2
sw $t1 -16($sp)
# Update the stack pointer
addi $sp $sp -12
# Call the function
jal fib
# Restore the stack pointer
addi $sp $sp 12
# Restore $t0-9 registers
lw $t0 -12($sp)
# Restore $ra
move $ra $t0
# Load the value returned by the function
lw $t0 -20($sp)
# Calling function fib
# Save $ra to a register
move $t1 $ra
# Save $t0-9 registers
sw $t0 -12($sp)
sw $t1 -16($sp)
# Evaluate parameters and save to stack
lw $t2 -4($sp)
li $t3 2
sub $t2 $t2 $t3
sw $t2 -20($sp)
# Update the stack pointer
addi $sp $sp -16
# Call the function
jal fib
# Restore the stack pointer
addi $sp $sp 16
# Restore $t0-9 registers
lw $t0 -12($sp)
lw $t1 -16($sp)
# Restore $ra
move $ra $t1
# Load the value returned by the function
lw $t1 -24($sp)
add $t0 $t0 $t1
sw $t0 -8($sp)

# Exiting scope.
addi $sp $sp 0
jr $ra

# code for main
main:
# Entering a new scope.
# Symbols in symbol table:
#  println 
#  i 
# Update the stack pointer.
addi $sp $sp 0

li $t0 0
sw $t0 -4($sp)

# Calling function println
la $a0 datalabel4
li $v0 4
syscall
la $a0 newline
li $v0 4
syscall


# Exiting scope.
addi $sp $sp 0
li $v0 10
syscall

# All memory structures are placed after the
# .data assembler directive
.data

newline:      .asciiz "\n"
datalabel4:   .asciiz "This program prints the first 12 numbers of the Fibonacci sequence."
# t: [false, false, false, false, false, false, false, false, false, false]