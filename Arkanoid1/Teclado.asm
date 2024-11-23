TECLADO:
    LD D, 0
TECLADO1:
    LD BC, $FDFE ; recogemos la fila de teclas de A
    IN A, (C) ; hacemos pantallazo
    AND $1F ; A = A & 1F
    CP $1F
    JR NZ, TECLADO2 ; si A no es igual que $1f se va a teclado 2
    LD BC, $BFFE
    IN A, (C)
    AND $1F ; A = A & 1F
    CP $1F
    JR NZ, TECLADO4
    DEC D
    JR NZ, TECLADO1
    LD B, 0
    RET
TECLADO2:

    ; ---------------
    ; Si el usuario teclea la A se mueve a la izquierda
    ; ---------------

    BIT 0, A  ; Z != A[0] // Comprobamos que teclee la letra A
    JR NZ, TECLADO3 ; si no lo hace vamos a teclado3
    LD B, -1 ; La posición que tengo la decremento 1

    JR TECLADOFIN
TECLADO3:

    ; ---------------
    ; Si el usuario teclea la F se muestra pantalla de fin
    ; ---------------

    BIT 3, A
    JR NZ, TECLADO1

    CALL Limpieza_Pantalla_Inicio
    CALL Pantalla_Final_Inicio
TECLADO4:

    ; ---------------
    ; Si el usuario teclea la D se mueve a la derecha
    ; ---------------

    BIT 1, A ; comprobamos si teclea la L
    JR NZ, TECLADO1 ; si no, vuelve a teclado1
    LD B, 1 ; aumentamos posicion en 1

    JR TECLADOFIN
TECLADOFIN:
    NOP
    NOP
    NOP
    NOP
    NOP
    DEC D
    JR NZ, TECLADOFIN
    RET