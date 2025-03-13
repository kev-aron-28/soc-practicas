.INCLUDE "P30F4013.INC"

.global	    _RETARDO_1s	    ;RETARDO DE 1.06 SEGUNDOS
.global	    _RETARDO_1ms
    
 _RETARDO_1s:
    PUSH    W0
    PUSH    W1
    
    MOV	    #10,    W1
CICLO2_1s:
    CLR	    W0
CICLO1_1s:
    DEC	    W0,	    W0
    BRA	    NZ,	    CICLO1_1s
    
    DEC	    W1,	    W1
    BRA	    NZ,	    CICLO2_1s
    
    POP W1
    POP W0
    
    RETURN

;@PARAM:	    W0, VALOR DEL RETARDO EN ms
_RETARDO_1ms:
    PUSH    W0
    
CICLO2_1ms:	    ;RETARDO DE 1 MSEGUNDOS
    MOV	    #614,   W1
CICLO1_1ms:
    DEC	    W1,	    W1
    BRA	    NZ,	    CICLO1_1ms
    
    DEC	    W0,	    W0
    BRA	    NZ,	    CICLO2_1ms
    
    POP	W1
    
    RETURN