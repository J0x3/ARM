@We will initialize table a, directly with the numbers, not in a loop as follows:
@.data
@.balign 4
@
@addr_of_a:
@    .word 44
@    .word 49
@.....  make up 10 numbers
@
@.. change the loop from 100 to 40 (i.e. 40 bytes for 10 numbers)
@Change the program in two parts: before the loop and in the loop.
@
@Before the loop:
@   ldr r6, #0    /* initialize maximum to zero */
@   ldr r5, MAX_VALUE /* load address of the variable MAX_ into r5
@   str r6, [r5]   /* store value ZERO into the location of MAX_VAL
@In the loop:
@    ldr r5, MAX_VAL /* r5<- MAX_VALUE
@    ldr r6, [r5]    /* r6<- value of MAX_VAL
@    cmp r6, [r3]  /* compare scanned value in array against MAX_VA
@    bls    NO_NEW_MAX /* no new max, skip code below */
@    ldr r6, [r3]   /* found new max, load into r6
@    str r6, [r5]  /* store the new max indirectly through r5
@NO_NEW_MAX:  /* finish the loop as usual */

MyArray: .skip 20 * 4

.text
.global main

main:
        ldr     R0, =MyArray
        mov     R1, #42
        str     R1, [R0], #4
        mov     R1, #43
        str     R1, [R0], #4
        mov r7, #1                      @ exit syscall
        swi #0                          @ invoke syscall

main:
    mov r3, #0                      @ initialize loop counter
print:
    mov r0, #1                      @ STDOUT
    ldr r1, addr_of_string          @ memory address of string
    mov r2, #13                     @ size of string
    mov r7, #4                      @ write syscall
    swi #0                          @ invoke syscall
loop:
    cmp r3, #5                      @ compare counter to 5
    beq exit                        @ exit loop if 5
    add r3, r3, #1                  @ increment counter
    b print                         @ loop print
exit:
    mov r7, #1                      @ exit syscall
    swi #0                          @ invoke syscall

addr_of_string: .word string
