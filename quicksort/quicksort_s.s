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
cmpl %ecx, %edx
ja retour              # Deux éléments ou moins -> return

get_pivot:
pushl %ecx
pushl %ebx
pushl %eax
call medianOfThree
movl %eax, %edx         # %edx -> pivot
popl %eax
popl %ebx
popl %ecx

preparation_for_loop:
subl $1, %ecx           # Donc maintenant %ebx -> i et %ecx -> k

left_to_pivot:
incl %ebx
cmpl (%eax, %ebx, 4), %edx
jbe pivot_to_left
ja left_to_pivot

pivot_to_left:
subl $1, %ecx
cmpl (%eax, %ecx, 4), %edx
jae conditions
jb pivot_to_left

conditions:
cmpl %ebx, %ecx
jbe prepare_next_call

permutation:
pushl %edx
pushl %ecx                # k
pushl %ebx                # i
pushl %eax                # T_
call swapRefs
popl %eax
popl %ebx
popl %ecx
popl %edx
jmp left_to_pivot

prepare_next_call:
movl 20(%esp), %ecx
subl $1, %ecx             # right - 1
pushl %ecx
pushl %ebx                # i
pushl %eax                # T_
call swapRefs
popl %eax
popl %ebx
popl %ecx

call_again:
subl $1, %ebx
pushl %ebx
movl 20(%esp), %esi
pushl 20(%esp)            # left
pushl %eax
call quicksort_s
popl %eax
addl $4, %esp
popl %ebx

addl $2, %ebx
movl 20(%esp), %esi
pushl 20(%esp)            # right
pushl %ebx
pushl %eax
call quicksort_s


# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
