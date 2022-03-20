.text
.globl syracuse_s_rec
.globl afficher
syracuse_s_rec:
pushl  %ebp
movl   %esp, %ebp
pushl %ebx
# DEBUT COMPLETION

init:
movl 12(%esp), %eax
movl 16(%esp), %ecx

print:
pushl %eax
pushl %ecx
call afficher
popl %ecx
popl %eax
incl %ecx

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
mul %ebx
addl $1, %eax
jmp call_again

even:
movl $0, %edx
movl $2, %ebx
idiv %ebx

call_again:
popl %ebx
pushl %ecx
pushl %eax
call syracuse_s_rec


# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
