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
movl 24(%eax), %ecx                # annee avant retaite
fildl (%esp)                      # salaire final


start_coefficient:
subl $1, %ecx
flds taux

salary_coefficient:
flds taux
fmulp
loop salary_coefficient

final_salary:
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
