@ initialize an array with ascii values A-Z by looping and then print by looping
.data
.balign 4
MyArray: .skip 26 * 4 
.text
.global main
main:
        ldr     r6, addr_of_MyArray		@ load &MyArray r0 (base addr)
   	mov	r2, #0x40			@ generated values to store
	eor 	r5, r5				@ counter
	eor	r3, r3				@ ARRAY OFFSET 
	str	r2, [r6]			@ store 0 as first value 	
arr_setup:		
	add	r2, r2, #0x01			@ generate value to store
   	add	r3, r6, r5, LSL#2		@ new ARRAY OFFSET = (bp + (counter * 4)) 	
	str     r2, [r3]			@ store values into array addr
	add	r5, #1				@ inc loop counter
	cmp	r5, #26				@ cmp, loop 20 times	
	bne	arr_setup			@ loop until i = 26
	eor	r5, r5				@ reset counter and offset calculation	
print_arr:	
	add	r3, r6, r5, LSL#2		@ calc new array offset = (bp + (counter * 4)) 		
	mov 	r0, #1				@ STDOUT
	mov	r1, r3				@ load addr	
	mov 	r2, #1				@ size to write
	mov 	r7, #4				@ syscall write
	svc 	0				@ invoke syscall (bl write)	
	mov 	r0, #1				@ STDOUT
	ldr	r1, nl_char_addr		@ load new line addr
	mov 	r2, #1				@ size to write
	mov 	r7, #4				@ syscall write
	svc 	0				@ invoke syscall (bl write)		
	add 	r5, r5, #1			@ increment counter
	cmp 	r5, #26 			@ loop 26 times
	bne	print_arr			@ loop print array ascii and new line
exit:
        mov r7, #1                              @ exit syscall
        svc 0	                               	@ invoke syscall
addr_of_MyArray: .word MyArray
nl_char: .ascii "\n"
nl_char_addr: .word nl_char
