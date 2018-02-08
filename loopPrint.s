.data
string: .asciz "Hello Joseph\n"

.text
.global main

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
