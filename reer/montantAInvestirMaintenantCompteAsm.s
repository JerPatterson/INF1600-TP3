.data
taux:
.float 1.04
.text
.globl _ZN6Compte29montantAInvestirMaintenantAsmEv

_ZN6Compte29montantAInvestirMaintenantAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

pushl 8(%esp)
call _ZN4Reer15salaireFinalAsmEv
pushl %eax
movl 4(%esp), %eax                # attribut
fildl 28(%eax)                    # encaisse
movl 24(%eax), %ecx               # annee avant retaite
fildl (%esp)                      # salaire final

start_amount:
subl $1, %ecx
flds taux

amount:
flds taux
fmulp
loop amount

final_amount:
fdivrp
fsubrp

fld1                             # pour contrer l'arrondissement de fistl
pushl $2
fildl (%esp)
fdivrp
faddp

fistpl (%esp)
popl %eax

# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
