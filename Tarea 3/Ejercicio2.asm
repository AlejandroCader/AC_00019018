; Miguel Alejandro Cruz Cader Ejercicio 2: 5 Factorial
    org     100h

    section .text
; Se limpia el registro DI
            XOR DI, DI
; Se limpia el registro SI
            XOR SI, SI
; Se declara el tamaño de 5 porque 5 veces se repetirá el proceso
            MOV word CX, 5d
            MOV AL, 1d
; Se salta sin condición alguna, y se dirige a la etiqueta iteración
            JZ factorial

    factorial: 
            MOV BX, CX
            MUL BX
            LOOP factorial
            MOV [20Bh], AL 
    exit:
            int 20h