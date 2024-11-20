    DEVICE ZXSPECTRUM48
PALA_Inicio: 
    LD A, 0
    LD HL, $5800+23*32+13 
    OUT ($FE), A 
    CALL imprimir_pala
    CALL captura_tecla
    RET
imprimir_pala:
    PUSH AF
    LD A, %00010010 ; Asignamos un valor de color a A 
    LD B, 5 ; Longitud
bucle_imprimir_pala:
    LD (HL), A ; Imprimimos la pala con el color escogido
    INC HL 
    DJNZ bucle_imprimir_pala ; repetimos el proceso hasta que B = 0
    POP AF
    RET
borra_pala:

    ; -------------------------------------------------------------------------
    ; Creamos una rutina que se encargue de borrar la pala en su posición actual
    ; Sigue la misma lógica que imprimir pala
    ; -------------------------------------------------------------------------

    DEC HL 
    PUSH AF
    LD A, 0 
    LD B, 5 
bucle_borrar_pala:
    LD (HL), A 
    DEC HL 
    DJNZ bucle_borrar_pala 
    POP AF
    RET
captura_tecla:

    ; -------------------------------------------------------------------------
    ; Creamos una rutina que se encargue de comprobar cuales son las teclas pulsadas 
    ; Se le da prioridad de captura al movimiento de la izquierda
    ; Última opción es la de salirse de la pantalla
    ; -------------------------------------------------------------------------

    LD A, $FD 
    IN A, ($FE)
    BIT 0, A ; Comprobamos si la tecla que deseamos está pulsada con esta instrucción
    JR Z, puedo_mover_izq 

    LD A, $BF
    IN A, ($FE)
    BIT 1, A ; Comprobamos si la tecla que deseamos está pulsada con esta instrucción
    JR Z, puedo_mover_dcha 

    LD A, $FD
    IN A, ($FE)
    BIT 3, A ; Comprobamos si la tecla que deseamos está pulsada con esta instrucción 
    JR Z, pulsar_salir 

    CALL ESPERAR  
    JR captura_tecla  

puedo_mover_izq :
    LD A, L
    CP ($E7) ; Comprobamos si la dirección de memoria del extremo izquierdo de la pala es correspondiente al límite del borde izquierdo
    JR C, captura_tecla 
mover_izquierda:
    CALL borra_pala
    CALL imprimir_pala
    CALL ESPERAR
    JR captura_tecla

puedo_mover_dcha:
    LD A, L
    CP ($FF) ; Comprobamos si la dirección de memoria del extremo izquierdo de la pala es correspondiente al límite del borde derecho
    JR NC, captura_tecla 
mover_derecha:
    CALL borra_pala
    INC HL
    INC HL
    CALL imprimir_pala
    CALL ESPERAR
    JR captura_tecla

pulsar_salir:
    CALL Limpieza_Pantalla_Inicio
    CALL Pantalla_Final_Inicio
    RET
ESPERAR:
    LD BC, $1611
ESPERAR1:
    DEC BC
    LD A, B
    OR C
    JR NZ, ESPERAR1
    RET
