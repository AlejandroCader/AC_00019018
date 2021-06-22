; Miguel Alejandro Cruz Cader (00019018)
ORG 100h

        section .text
        ; Aquí limpio los registros a utilizar
        XOR     AX, AX
        XOR     SI, SI
        XOR     BX, BX
        XOR     CX, CX
        XOR     DX, DX

        MOV     SI, 0
        MOV     DI, 0d

        MOV     DH, 05 ; Esta es la fila en la que iniciará el puntero
        MOV     DL, 05 ; Esta es la columna en la que iniciará el puntero

        CALL    MODOTEXTO ; llamada a la función que activará el modo texto
        
        ITERAR: 
        ; Declaro la función que me permitirá iterar según la cantidad de caracteres que yo desee
        ; Cabe destacar que solo comento el primer bloque porque los demás es igual
        ; Lo único que cambia es el numero de iteraciones y la fila en la que se escribirán
                MOV     byte [iteraciones], 7 ; Aquí declaro las veces que se va a iterar por cada palabra en mi nombre
                MOV     DH,05   ; Esta es la nueva fila en la que se escribirá el primer caractér
                MOV     DL,05   ; Esta es la columna en la que se escribirá el primer caractér
                XOR     DI,DI   
                CALL    DESPLAZAR ; llamada a la función que irá desplazandose para escribir cada caractér
                MOV     byte [iteraciones], 10
                MOV     DH,07 
                MOV     DL,05 
                XOR     DI,DI 
                CALL    DESPLAZAR 
                MOV     byte [iteraciones], 5 
                MOV     DH,09 
                MOV     DL,05 
                XOR     DI,DI 
                CALL    DESPLAZAR
                MOV     byte [iteraciones], 6
                MOV     DH,11 
                MOV     DL,05 
                XOR     DI,DI 
                CALL    DESPLAZAR
                MOV     byte [iteraciones], 8
                MOV     DH,13 
                MOV     DL,05 
                XOR     DI,DI 
                CALL    DESPLAZAR
                JMP     ESPERARTECLA ; llamada a la función que esperara una entrada desde teclado

        DESPLAZAR:
                CALL    MOVERPUNTERO ; Llamada a la función que posicionará el puntero en pantalla
                MOV     CL, [cadena+SI] ; Desplazamiento de los caracteres dentro de la cadena
                CALL    ESCRIBIRCARACTER ; Llamada a la función que escribirá cada caractér
                INC     SI ; Se incrementa 1 espacio para escribir el siguiente caracter
                INC     DL ; Se incrementa 1 espacio para desplazarse a la siguiente columna
                INC     DI ; Se incrementa 1 espacio para llegar a la comparación con las iteraciones
                CMP     DI, [iteraciones] ; Comparación de DI con el numero de iteraciones para ver si la palabra está escrita
                JB      DESPLAZAR  ; Recursión
                RET

        MODOTEXTO: 
                MOV     AH, 0h  ; Activación del modo texto
                MOV     AL, 03h ; Modo gráfico utilizado - 80x25, 16 colores, 8 páginas
                INT     10h
                RET

        MOVERPUNTERO:
                MOV     AH, 02h ; Posicionamiento del puntero en la pantalla
                MOV     BH, 0h  ; La página en que estamos ubicados
                INT     10h
                RET

        ESCRIBIRCARACTER:
                MOV     AH, 0Ah ; Aquí se escribe el caractér según la posición del puntero
                MOV     AL, CL  ; Aquí se denota el caracter - su valor debe estar escrito em  base a la tabla ASCII
                MOV     BH, 0h  ; Número de la página
                MOV     CX, 1h  ; Número de veces que se va a escribir el caracter
                INT     10h
                RET

        ESPERARTECLA:
                MOV     AH, 00h ; Espera al búffer del teclado para poder avanzar a la siguiente instrucción
                INT     16h

        SALIR:
                INT     20h

    section .data

    cadena      DB      'Miguel Alejandro Cruz Cader 00019018' ; Variable con el nombre completo y carnet
    iteraciones DB       0 ; Variable con numero de iteraciones