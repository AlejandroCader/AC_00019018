; Miguel Alejandro Cruz Cader 00019018 

            ORG     100h

            section .text

            MOV     BL, contador
            CALL    Determinar ; Aquí se hace la llamada a la función Determinar
            int     20h

            section .data

arreglo     db      16, 10, 1999, 777, 17, 56, 255, 8, 1, 79, 33 ; Arreglo 
contador    equ     2   
auxiliar    equ     0    

;Aquí se determina si el numero es par o impar 
;y se guarda su valor

    Determinar:
            XOR     SI, SI   
            XOR     DI, DI   
            XOR     AX, AX  

    Repetir:
            MOV     AL, [arreglo+SI]  
            CMP     AL, 0xA         
            JE      Finalizar             
            MOV     DL, AL           
            DIV     BL              
            CMP     AH, auxiliar   
            JE      Par      
            JMP     Impar        
            JMP     Finalizar         

    Finalizar:
            RET

    ;Aquí se guarda el par
    Par:
            MOV     [300h+DI], DL
            INC     DI
            INC     SI
            JMP     Repetir

    ;Aquí se guarda el impar
    Impar:
            MOV     [320h+DI], DL
            INC     DI
            INC     SI
            JMP     Repetir
