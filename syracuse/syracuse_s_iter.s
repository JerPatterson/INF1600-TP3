.text
.globl syracuse_s_iter
.globl afficher
syracuse_s_iter:
pushl   %ebp
movl    %esp, %ebp
pushl %ebx
# DEBUT COMPLETION

movl $0, %ecx
movl 12(%esp), %eax
check_number:
cmpl $1, %eax
je retour

movl $1, %ebx
andl %eax, %ebx
cmpl $1, %ebx
je odd
jne even

odd:
movl $3, %ebx
imul %ebx, %eax
addl $1, %eax
jmp print

even:
movl $0, %edx
movl $2, %ebx
idiv %ebx
jmp print

print:
pushl %ecx
pushl %eax
call afficher
addl $8, %esp
incl %ecx
jmp check_number


# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
