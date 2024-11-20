    DEVICE ZXSPECTRUM48
    org $8000
    LD SP, 0
    JP inicio
Jugar:
    DB "Quieres jugar (S/N)?", 0 ; db es para indicar uso binario e imprimir por pantalla el string puesto
    ; Comentarios / Parámetros IN / Parámetros OUT / Registros modificados    
inicio:
    LD A , 0
    OUT($FE), A
    CALL Pantalla_Arkanoid ; llamamos a la rutina de pantalla
    LD IX, Jugar ; llamamos a jugar
    LD B, 22 ; fila de inicio
    LD C, 2 ; columna de inicio de la impresión por pantalla
    LD A, 70 ; el atributo para escoger el color en A es tal que la suma de los valores de sus bits necesarios
    CALL PRINTAT ; llamamos a la función printat
    LD A, 198 ; ponemos brillante el cursor
    LD ($5800 + 22*32+23),A ; dirección de memoria del cursor
    CALL leer_sn_inicio ; Llamamos a leer_sn
fin:
    jr fin
Pantalla_Arkanoid:    
    LD HL,$4000 ; HL es la dirección de carga
    LD IX, RLEData ; posicion de RLEData (array de datos en panatlla_inicio)
PARK1:
    LD A, (IX)
    OR A
    RET Z ; se puede usar en return como condición C y Z también
    INC IX
    LD B, A
    LD A, (IX)
    INC IX
PARK2:
    LD (HL), A
    INC HL
    DJNZ PARK2 ; decrecimiento de B hasta que valga 0
    JR PARK1
include:
    include "Pantalla inicio Arkanoid.asm"
    include "printat.asm"
    include "leer_sn.asm"
    include "Pala.asm"
    include "Limpieza_Pantalla.asm"
    include "Pantalla_Final.asm"
    include "Cuba.asm"
    include "Pantalla_Adios.asm"