;--------------------------------------------------------------------------------------
;   Volcar datos de forma masiva                                                               
;--------------------------------------------------------------------------------------

    DEVICE ZXSPECTRUM48
    SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION
    ORG $8000
    LD SP, 0

    LD HL, BATMAN
    LD DE, $4000
    LD BC, $5B00 - $4000

BUCLE:
;--------------------------------------------------------------------------------------
    ; LD A, (HL)
    ; EX HL, DE ; intercambia/permuta los valores
    ; LD (HL), A
    ; EX HL, DE ; los vuelvo a dar la vuelta
    ; INC HL : INC DE : DEC BC
;--------------------------------------------------------------------------------------
; ESTO ES LO QUE HACE LO ANTERIOR
;*DE = *HL
; DE++
; HL++
; BC--    
;--------------------------------------------------------------------------------------
    LDIR ; esta instrucción se utiliza para copiar datos

    ; LDDR ---> funciona igual que el LDIR pero al revés
;--------------------------------------------------------------------------------------
    ; LD A, B
    ; OR C
    ; JR NZ, BUCLE
;--------------------------------------------------------------------------------------
; las instrucciones anteriores recorren B hasta que B es 0
;--------------------------------------------------------------------------------------
    ; JR PO, BUCLE
;--------------------------------------------------------------------------------------

; DE ---> MAPATRABAJO
; HL ---> NUMERO CON LOS QUE RECORREMOS EL MAPA
; BC ---> NUMERO MAXIMO QUE TIENE QUE LEER
; METER EL LDIR 


FIN: 
    JR FIN


BATMAN:
    INCBIN "BATMAN.SCR"; Es como un include pero en binario