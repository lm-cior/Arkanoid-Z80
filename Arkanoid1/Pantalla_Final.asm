    DEVICE ZXSPECTRUM48

    LD A, 0
    OUT ($FE), A

    JP Pantalla_Final_Inicio

TEXTO1: DB "La partida ha finalizado", 0
TEXTO2: DB "Quieres jugar otra partida? S/N ", 0

Pantalla_Final_Inicio:
    LD IX, TEXTO1   // Escribimos el mensaje de finalizar partida
    ; ----------------
    ; Posicionamiento
    ; ----------------
    LD B, 1
    LD C, 4
    LD A, 1
    CALL PRINTAT

    LD IX, TEXTO2 
    LD B, 22
    LD C, 1
    LD A, 6
    CALL PRINTAT

    CALL leer_sn_inicio     // Leemos la respuesta a la pregunta

    LD A, 198
    LD ($5806 + 22*32+24), A

    LD B, 22 ; fila
    LD C, 24  ;columna
    LD A, 6   ;atributo
    RET
    
PANTALLA_FINAL_FIN: JR PANTALLA_FINAL_FIN
