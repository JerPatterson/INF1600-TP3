.data
.text
.globl	_ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv

_ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

pushl 8(%esp)
call _ZN4Reer15salaireFinalAsmEv

salary_retirement:
pushl $100
fild (%esp)
pushl %eax
fildl (%esp)                      # salaire final
movl 8(%esp), %eax
fildl 16(%eax)

fmulp
fdivp

pushl $1                         # pour contrer l'arrondissement de fistl
fild (%esp)
pushl $2
fild (%esp)
fdivrp
fsubrp

fistl (%esp)                      # pour avoir le résultat en entier
fildl (%esp)
addl $20, %esp

movl $2, %edx
jmp start_interest

numerator_calculation:
pushl $1
fild (%esp)
fsubrp
fmulp

start_interest:
movl 4(%eax), %ecx                 # années de retraite
subl $1, %ecx

pushl $1
fild (%esp)
fild 20(%eax)                      # taux d'intérêts
pushl $100
fild (%esp)
addl $8, %esp

fdivrp
faddp

interest_rate:
pushl $1
fild (%esp)
fild 20(%eax)                      # taux d'intérêts
pushl $100
fild (%esp)
addl $8, %esp

fdivrp
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
fdivrp

pushl $1                         # pour contrer l'arrondissement de fistl
fild (%esp)
pushl $2
fild (%esp)
fdivrp
fsubrp

fistl (%esp)
popl %eax
addl $8, %esp

# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
