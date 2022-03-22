.data
.text
.globl	_ZN4Reer15salaireFinalAsmEv

_ZN4Reer15salaireFinalAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

movl 8(%esp), %eax
fildl 8(%eax)                     # salaire de départ
movl 12(%eax), %edx               # augmentation salariale 
movl 24(%eax), %ecx               # nb années avant retraite

start_coefficient:
subl $2, %ecx
fld1
pushl %edx
fildl (%esp)
pushl $100
fildl (%esp)

fdivrp
faddp
fstps (%esp)
flds (%esp)

salary_coefficient:
flds (%esp)
fmulp
loop salary_coefficient

final_salary:
fmulp

fld1                             # pour contrer l'arrondissement de fistl
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
