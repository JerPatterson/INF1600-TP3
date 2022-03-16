.text
.globl quicksort_s
quicksort_s:
pushl %ebp
movl %esp, %ebp
pushl %ebx
# DEBUT COMPLETION

movl 8(%esp), %eax
movl 12(%esp), %ebx     # left
movl 16(%esp), %ecx     # right

movl $2, %edx
addl %ebx, %edx
cmpl %eax, %edx
jb retour               # Deux éléments ou moins -> return

pushl %ecx
pushl %ebx
pushl %eax
call medianOfThree
popl %edx               # pivot
popl %eax
popl %ebx
popl %ecx


left_to_pivot:
cmpl (%eax, %ebx, 1), %edx
jae sort
jmp left_to_pivot

pivot_to_left:
cmpl -4(%eax, %ecx, 1), %edx
jbe sort
jmp pivot_to_left

sort:



# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
