.text
.globl quicksort_s
quicksort_s:
pushl %ebp
movl %esp, %ebp
pushl %ebx
# DEBUT COMPLETION

movl 12(%esp), %eax
movl 16(%esp), %ebx     # %ebx -> left
movl 20(%esp), %ecx     # %ecx -> right

check_recursive_end:
movl $2, %edx
addl %ebx, %edx
cmpl %eax, %edx
jbe retour              # Deux éléments ou moins -> return

get_pivot:
pushl %ecx
pushl %ebx
pushl %eax
call medianOfThree
movl %eax, %edx         # %edx -> pivot
popl %eax
#popl %ebx
popl %ecx

preparation_for_loop:
subl $1, %ecx           # Donc maintenant %ebx -> i et %ecx -> k

left_to_pivot:
incl %ebx
cmpl (%eax, %ebx, 1), %edx
jae pivot_to_left
jmp left_to_pivot

pivot_to_left:
subl $1, %ecx
cmpl (%eax, %ecx, 1), %edx
jbe conditions
jmp pivot_to_left

conditions:
cmpl %ebx, %ecx
jae prepare_next_call

permutation:
pushl (%eax, %ebx, 1)     # T[i]
pushl (%eax, %ecx, 1)     # T[k]
popl (%eax, %ebx, 1)      # T[i] = T[k]
popl (%eax, %ecx, 1)      # T[k] = T[i]
jmp left_to_pivot

prepare_next_call:
pushl (%eax, %ebx, 1)     # T[i]
pushl -4(%eax, %ecx, 1)   # pivot
popl (%eax, %ebx, 1)      # T[i] = pivot
popl -4(%eax, %ecx, 1)    # pivot = T[i]

call_again:
subl $1, %ebx
pushl %ebx
pushl 12(%esp)            # left
pushl %eax
call quicksort_s
popl %eax
addl $8, %esp

addl $2, %ebx
pushl 16(%esp)            # right
pushl %ebx
pushl %eax
call quicksort_s


# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
