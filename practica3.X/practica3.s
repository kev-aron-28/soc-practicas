
        .equ __30F4013, 1
        .include "p30F4013.inc"
        config __FOSC, CSW_FSCM_OFF & FRC   
        config __FWDT, WDT_OFF 
        config __FBORPOR, PBOR_ON & BORV27 & PWRT_16 & MCLR_EN
;..............................................................................
;SE DESACTIVA EL CÓDIGO DE PROTECCIÓN
;..............................................................................
   	config __FGS, CODE_PROT_OFF & GWRP_OFF      
        .global _wreg_init     
;..............................................................................
;ETIQUETA DE LA PRIMER LINEA DE CÓDIGO
;..............................................................................
        .global __reset          
;..............................................................................
;DECLARACIÓN DE LA ISR DEL TIMER 1 COMO GLOBAL
;..............................................................................
        .global __T1Interrupt    

.text					;INICIO DE LA SECCION DE CODIGO

__reset:
        MOV	#__SP_init, 	W15	;INICIALIZA EL STACK POINTER

        MOV 	#__SPLIM_init, 	W0     	;INICIALIZA EL REGISTRO STACK POINTER LIMIT 
        MOV 	W0, 		SPLIM

        NOP                       	;UN NOP DESPUES DE LA INICIALIZACION DE SPLIM

        CALL 	_WREG_INIT          	;SE LLAMA A LA RUTINA DE INICIALIZACION DE REGISTROS
                                  	;OPCIONALMENTE USAR RCALL EN LUGAR DE CALL
        CALL    INI_PERIFERICOS
CICLO:
	;BTSC	PORTD,	#0
	;GOTO	CICLO
	
	BTG	PORTB, #0
	CALL	_RETARDO_1s
	BRA	CICLO
		   

;/**@brief ESTA RUTINA INICIALIZA LOS PERIFERICOS DEL DSC
; */
INI_PERIFERICOS:
	CLR	PORTF	    ;PORTF = 0
	NOP
	CLR	LATF	    ;LATF = 0
	NOP
	SETM	TRISF	    ;TRISF = 0XFFFF
	NOP
	
	CLR	PORTD	    ;PORTD = 0
	NOP
	CLR	LATD	    ;LATD = 0
	NOP
	SETM	TRISD	    ;TRISD = 0XFFFF
	NOP
	
	CLR	PORTC	    ;PORTD = 0
	NOP
	CLR	LATC	    ;LATD = 0
	NOP
	SETM	TRISC	    ;TRISD = 0XFFFF
	NOP
	

	CLR	PORTB	    ;PORTB = 0
	NOP
	CLR	LATB	    ;LATB = 0
	NOP
	CLR	TRISB	    ;TRISB = 0
	NOP
	SETM	ADPCFG
	
        RETURN

;/**@brief ESTA RUTINA INICIALIZA LOS REGISTROS Wn A 0X0000
; */
_WREG_INIT:
        CLR 	W0
        MOV 	W0, 				W14
        REPEAT 	#12
        MOV 	W0, 				[++W14]
        CLR 	W14
        RETURN

;/**@brief ISR (INTERRUPT SERVICE ROUTINE) DEL TIMER 1
; * SE USA PUSH.S PARA GUARDAR LOS REGISTROS W0, W1, W2, W3, 
; * C, Z, N Y DC EN LOS REGISTROS SOMBRA
; */
__T1Interrupt:
        PUSH.S 


        BCLR IFS0, #T1IF           ;SE LIMPIA LA BANDERA DE INTERRUPCION DEL TIMER 1

        POP.S

        RETFIE                     ;REGRESO DE LA ISR


.END                               ;TERMINACION DEL CODIGO DE PROGRAMA EN ESTE ARCHIVO