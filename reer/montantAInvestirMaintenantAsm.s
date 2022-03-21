.data
.text
.globl	_ZN4Reer29montantAInvestirMaintenantAsmEv

_ZN4Reer29montantAInvestirMaintenantAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

pushl 8(%esp)
call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
movl %eax, %ecx
pushl %eax
fildl (%esp)                        # salaire final
movl 4(%esp), %eax                  # attributs

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

last_calculation:
fdivrp

pushl $1                          # pour contrer l'arrondissement de fistl
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
