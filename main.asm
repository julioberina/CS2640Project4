# Who:  Julio Berina
# What: main.asm (Project 4)
# Why:  Encrypt a source file's content and write it to destination file
# When: 12/5/18
# How:  Prompt user for src file, dst file, and passphrase. XOR characters

# li $a0, SRC_PATH
# li $a1, 0x41
# li $a2, 0x1ff
# li $v0, 13
# syscall

.data
             .align  2
buffer:      .space  1024    # Reading lines in file
sfbuffer:    .space  200
dfbuffer:    .space  200
ppbuffer:    .space  500
src_file:    .asciiz "Enter src file path: "
dst_file:    .asciiz "Enter dst file path: "
passphrase:  .asciiz "Enter passphrase: "
finished:    .asciiz "Finished encrypting file!\n"

.text
.globl main

main:	# program entry
    la $a0, src_file
    li $v0, 4
    syscall

    la $a0, sfbuffer
    li $a1, 200
    li $v0, 8
    syscall

    la $a0, dst_file
    li $v0, 4
    syscall

    la $a0, dfbuffer
    li $a1, 200
    li $v0, 8
    syscall

    la $a0, passphrase
    li $v0, 4
    syscall

    la $a0, ppbuffer
    li $a1, 500
    li $v0, 8
    syscall

open_files:
    la $a0, sfbuffer # open source file
    li $a1, 0
    li $a2, 0

    li $v0, 13
    syscall

    move $s0, $v0

    la $a0, dfbuffer
    li $a1, 0x41
    li $a2, 0x1ff

    li $v0, 13
    syscall

    move $s1, $v0

    # s0 = src file descriptor
    # s1 = dst file descriptor

read_file_contents:
    move $a0, $s0
    la $a1, buffer
    li $a2, 1024
    li $v0, 14
    syscall
    move $s2, $v0

write_to_file:
    move $a0, $s1
    la $a1, buffer
    move $a2, $s2
    li $v0, 15
    syscall

close_files:
    move $a0, $s0
    li $v0, 16
    syscall

    move $a0, $s1
    li $v0, 16
    syscall

exit:
    la $a0, finished
    li $v0, 4
    syscall

    li $v0, 10		# terminate the program
    syscall

