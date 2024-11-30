    DEVICE ZXSPECTRUM48
	SLDOPT COMMENT WPMEM, LOGPOINT, ASSERTION 

CUBA_Inicio:
    LD A, 0
    OUT ($FE), A             ; Borde de la pantalla en negro
    LD HL, $5800             ; Cargamos la dirección inicial en HL

    
Fila_Superior:
    LD B, %00001001          ; Guardamos en B el color de la cuba
    LD C, 32                 ; Guardamos en C el número de columnas
Columnas_Superior:
    LD (HL), B               ; Ponemos el color en cada una de las columnas
    INC HL                   ; Incrementamos HL para avanzar a la siguiente columna
    DEC C                    ; Decrementamos C para quitar la columna que ya ha sido pintada
    JR NZ, Columnas_Superior ; Lo repetimos hasta que se pinten las 32 columnas

    LD D, 22                 ; Número de filas para los bordes laterales
  
Dibuja_LateralIzquierdo:
    LD (HL), B                ; Pinta el borde izquierdo en la posición de HL
    PUSH DE
    PUSH HL                   ; Guardamos HL
    

    LD A, H
    ADD A, 1                  ; Movemos a la siguiente columna
    LD H, A                   ; Actualizamos H con la nueva columna
    LD (HL), B                ; Pintar el borde 

    POP HL                    ; Recuperamos la posición original 
    LD DE, $0020              ; Avanzamos 32 bytes a la siguiente fila
    
    ADD HL, DE                
    POP DE
    DEC D                     ; Decrementamos D por la fila que ya se haya pintado
    JR NZ, Dibuja_LateralIzquierdo

    LD HL, $583F             ; Iniciamos la segunda fila en el borde derecho de la cuba
    LD D, 23

Dibuja_LateralDerecho:
    PUSH DE
    LD (HL), B               ; Pintamos el borde derecho en la posición de HL
    LD DE, $0020             ; Se avanza 32 para poder pintar la misma columna slo que en una flia más abajo
    ADD HL, DE               
    POP DE
    DEC D                    
    JR NZ, Dibuja_LateralDerecho  ; Repetir hasta completar las 22 filas

Llamado_pala:
    CALL leer_mapa
    CALL Pala_inicio
    RET