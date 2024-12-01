; --------------------------------------------------------------
; Esta rutina se encarga de recorrer la pantalla en su totalidad y poner el color negro
; tanto en el paper como en el ink
; --------------------------------------------------------------

Limpieza_Pantalla_Inicio:

    ; --------------------------------------------------------------
    ; Establecemos los registros que se van a usar y la dirección de memoria inicial de la pantalla
    ; --------------------------------------------------------------

    LD A, 0
    LD B, 0 
    LD E, 0
    OUT($FE), A
    LD HL, $5800
Bucle_Limpieza:
    
    ; --------------------------------------------------------------
    ; Bucle para limpiar la pantalla recorriendo filas y columnas
    ; --------------------------------------------------------------    

    LD (HL), B
    INC HL
    INC A
    CP 32
    JR C, Bucle_Limpieza
    
    INC E
    LD A, E
    CP 25
    LD A, 0
    JR C, Bucle_Limpieza

    LD HL, $5B00

Bucle_atributos:
    LD (HL), B
    INC HL
    LD A, H

    CP $60

    JR NZ, Bucle_atributos

    RET