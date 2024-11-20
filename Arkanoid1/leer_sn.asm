Mensa_SN: 
    DB 0, 0
leer_sn_inicio:
    LD B, 32 ; nº de filas de la pantalla
    LD C, 23 ; nº de columnas de la pantalla
    LD A, 6 
    CALL LEER_SN
    LD A, (Mensa_SN)
    ; si se pulsa la S se pasa a la rutina que limpia la pantalla e imprime la cuba
    CP 'S'
    JR Z, Pantalla_Juego
    ; si se pulsa la N se pasa a la rutina que limpia la pantalla e imprime el mensaje Final de "Adiós"
    CP 'N'
    JR Z, Pantalla_Final
    JR leer_sn_inicio
    RET
Pantalla_Juego:
    
    ; ------------------------------------------------------------
    ; Rutina para llamar a otros métodos
    ; ------------------------------------------------------------

    CALL Limpieza_Pantalla_Inicio
    CALL CUBA_Inicio
    RET
LEER_SN: 
    PUSH AF
LSN1:    

    ; ------------------------------------------------------------
    ; Comprobamos cual tecla está siendo pulsada, si la s o la n
    ; Si no hay ninguna que está siendo pulsada entonces se repite el bucle
    ; ------------------------------------------------------------

    LD A, $FD
    IN A, ($FE)
    BIT 1, A
    ; Si se reconoce que se pulsa una S, se asigna al registro A la letra S
    JR Z, Puls_S
    LD A, $7F
    IN A, ($FE)
    BIT 3, A
    JR NZ, LSN1
    ; Si se reconoce que se pulsa una N, se asigna al registro A la letra N
    LD A, 'N'
    LD (Mensa_SN), A
    JR LSN2
Puls_S:
    LD A, 'S'
LSN2:
    LD (Mensa_SN), A
    POP AF
    CALL PRINTAT
    ; Comprobamos que en Mensa_SN esté registrada la tecla que queremos, bien sea la S o la N
    LD A, (Mensa_SN)
    CP 'S'
    JR Z, LSN3
    LD A, $7E
    JR LSN4
LSN3:
    LD A, $FD
LSN4: 
    IN A, ($FE)
    CP $FF
    JR Z, LSN4
    CALL ESPERAR_SN 
    RET
ESPERAR_SN:
    LD BC, $3FFF
ESPERAR_1_SN:
    DEC BC
    LD A, B
    OR C
    JR NZ, ESPERAR_1_SN
    RET
Pantalla_Final:
    CALL PANTALLA_ADIOS_INICIO
    RET