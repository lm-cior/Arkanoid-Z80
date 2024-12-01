variable: db 0
leer_mapa:
        
    push hl : push bc : push de

    ld a, (variable)

    ld b, maxLevelsMask

    inc b

    cp b

    jr z, final_programa

    ld hl, maplist

    ld c, a
    ld b, 0

    add hl, bc
    add hl, bc

    inc a
    ld (variable), a

    ld de, (hl)
    ld hl, de

    inc hl

leer_mapa1:
    
    ld a, (hl)

    ld e, a

    inc hl

    ld a, (hl)
    ld b, a

    push hl : push bc
    
    ld b, e

    ld de, $0020    

    ld hl, $5801

bucle_suma:
    add hl, de

    djnz bucle_suma 

    ld de, hl

    pop bc : pop hl
    
bucle_mapa:

    inc hl

    ld a, (hl)
    
    push bc
    ld c, a
    cp 8
    jr z, suma_atributo
    sla a: sla a: sla a
    add a, c
continuacion:
    pop bc

    push bc
    ld b, 2

bucle_mapa2:
    ld (de), a
    inc de
    djnz bucle_mapa2

    pop bc

    djnz bucle_mapa

    inc hl

    ld a, (hl)

    cp 255
    
    jr nz, leer_mapa1
map_end:

    pop de : pop bc: pop hl

    ret
final_programa:
    call Limpieza_Pantalla_Inicio
    call Pantalla_Final_Inicio
suma_atributo:
    sla a: sla a: sla a
    jr continuacion