variable: db 0, 1, 2 3
leer_mapa:
    
    ; dirección de memoria del mapa
    
    push hl : push bc : push de

    ld hl, (maplist)

    cp maxLevelsMask

    jr z, final_programa

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
    sla a: sla a: sla a
    add a, c
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