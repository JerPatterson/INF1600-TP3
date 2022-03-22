.data
.text
.globl	_ZN4Reer29montantAInvestirMaintenantAsmEv

_ZN4Reer29montantAInvestirMaintenantAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

pushl 8(%esp)
call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
pushl %eax
fildl (%esp)                        # salaire final
movl 4(%esp), %eax                  # attributs

start_interest:
movl 24(%eax), %ecx                 # années avant retraite
subl $1, %ecx

fld1
fildl 20(%eax)                      # taux d'intérêts
pushl $100
fildl (%esp)

fdivrp
faddp

interest_rate:
fld1
fildl 20(%eax)                      # taux d'intérêts
pushl $100
fildl (%esp)

fdivrp
faddp
fmulp
loop interest_rate

last_calculation:
fdivrp

fld1                          # pour contrer l'arrondissement de fistl
pushl $2
fildl (%esp)
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
