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
pushl $1
fild (%esp)
pushl %edx
fild (%esp)
pushl $100
fild (%esp)

fdivrp
faddp
subl $2, %ecx

salary_coefficient:
pushl $100
fild (%esp)
pushl %edx
fild (%esp)
fdivp

pushl $1
fildl (%esp)
faddp

fmulp
loop salary_coefficient

final_salary:
fmulp

pushl $1                         # pour contrer l'arrondissement de fistl
fild (%esp)
pushl $2
fild (%esp)
fdivrp
fsubrp

fistl (%esp)
popl %eax
movl %ebp, %esp

# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
