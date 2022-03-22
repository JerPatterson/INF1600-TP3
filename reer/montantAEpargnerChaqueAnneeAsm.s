.data
.text
.globl	_ZN4Reer30montantAEpargnerChaqueAnneeAsmEv

_ZN4Reer30montantAEpargnerChaqueAnneeAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

pushl 8(%esp)
call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
pushl %eax
fildl (%esp)                        # montant final
movl 4(%esp), %eax                  # attributs

numerator:
pushl $100
fildl (%esp)
fildl 20(%eax)                      # taux d'intérêts

fdivp
fmulp

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
fld1
fsubrp
fdivrp

fld1                         # pour contrer l'arrondissement de fistl
pushl $2
fildl (%esp)
fdivrp
fsubrp

fistpl (%esp)
popl %eax
movl %ebp, %esp
# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
