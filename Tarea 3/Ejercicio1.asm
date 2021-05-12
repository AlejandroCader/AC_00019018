; Miguel Alejandro Cruz Cader Ejercicio 1: Carnet
    org     100h

    section .text
; Se limpia el registro DI
            XOR DI, DI 
; Se limpia el registro SI
            XOR SI, SI 
; Se declara el tamaño de 8 por el numero de caracteres del carnet
            MOV word CX, 8d
            XOR AX, AX
; Se salta sin condición alguna, y se dirige a la etiqueta iteración
            jmp iteracion 
    iteracion: 
            MOV byte AL, [carnet_estudiante+DI]
            MOV byte [200h+SI], AL
            MOV AH, [200h+SI]
            XOR AH, 48d
            ADD BL, AH
            INC DI
            INC SI
; Se utiliza LOOP para repetir la etiqueta iteración
            LOOP iteracion
            XOR AX, AX
            MOV Al, BL
            MOV BX, 08h
            DIV BL
            MOV [20Ah], BL
    exit:
            int 20h

    section .data

    carnet_estudiante DB "00019018"