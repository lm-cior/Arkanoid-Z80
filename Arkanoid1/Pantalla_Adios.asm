PANTALLA_ADIOS:
    LD A, 0
    OUT($FE), A

    JP PANTALLA_ADIOS_INICIO
JUGAR: DB "ADIOS!!!!", 0    // Comentario el cual queremos que aparezca en pantalla
PANTALLA_ADIOS_INICIO:

    CALL Limpieza_Pantalla_Inicio   // Llamamos a limpiar pantalla para que cuando se ponga el mensaje de despedida, solo aparezca el mensaje
    
    LD IX, JUGAR          // Escribe el mensaje

    ; ----------------
    ; Posicionamiento
    ; ----------------
    LD B, 10
    LD C, 12
    LD A, 80

    CALL PRINTAT
    RET
PANTALLA_ADIOS_FIN: JR PANTALLA_ADIOS_FIN
