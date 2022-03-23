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
fildl (%esp)
pushl %eax
fildl (%esp)                       # salaire final
movl 8(%esp), %eax
fildl 16(%eax)                     # salaire voulu retraite

fmulp
fdivp

fld1                               # pour contrer l'arrondissement de fistl
pushl $2
fildl (%esp)
fdivrp
fsubrp

fistl (%esp)                       # pour avoir le résultat en entier
fildl (%esp)

movl $2, %edx
jmp start_interest

numerator_calculation:
fld1
fsubrp
fmulp

start_interest:
movl 4(%eax), %ecx                 # années de retraite
subl $1, %ecx

fld1
fildl 20(%eax)                     # taux d'intérêts
pushl $100
fildl (%esp)

fdivrp
faddp

interest_rate:
fld1
fildl 20(%eax)                     # taux d'intérêts
pushl $100
fildl (%esp)

fdivrp
faddp
fmulp
loop interest_rate

subl $1, %edx
cmpl $0, %edx
jne numerator_calculation

final_amount:
pushl $100
fildl (%esp)
pushl 20(%eax)
fildl (%esp)

fdivp
fmulp
fdivrp

fld1                         # pour contrer l'arrondissement de fistl
pushl $2
fildl (%esp)
fdivrp
fsubrp

fistpl (%esp)
popl %eax

# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
