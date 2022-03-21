.data
.text
.globl	_ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv

_ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

salary_retirement:
pushl 8(%esp)
call _ZN4Reer15salaireFinalAsmEv

pushl %eax
fild 4(%esp)                      # salaire final
movl 12(%esp), %eax
fild 16(%eax)
pushl $100
fild (%esp)
addl $8, %esp

fmulp
fdivp

movl $2, %edx
jmp start_interest

numerator_calculation:
fmulp

start_interest:
movl 4(%eax), %ecx                 # années de retraite
subl $2, %ecx

pushl $1
fild (%esp)
fild 20(%eax)                      # taux d'intérêts
pushl $100
fild (%esp)
addl $8, %esp

fdivp
faddp

interest_rate:
pushl $1
fild (%esp)
fild 20(%eax)                      # taux d'intérêts
pushl $100
fild (%esp)
addl $8, %esp

fdivp
faddp
fmulp
loop interest_rate

subl $1, %edx
cmpl $0, %edx
jne numerator_calculation

final_amount:
pushl $100
fild (%esp)
pushl 20(%eax)
fild (%esp)
addl $8, %esp

fdivp
fmulp
fistl (%esp)
popl %eax

# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
