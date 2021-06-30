; Miguel Alejandro Cruz Cader (00019018)

org 100h

    section .text
    MOV     DX,mmsgok
    CALL    write
    MOV     BP,inpt
    CALL    view
    CALL    same
    CALL    write
    INT     20h

    section .data
mssge           DB      "Contra: ", "$"
mmsgok          DB      "Bienvenido", "$"
pass_word       DB      "Didimike16*"
mssgbad         DB      "Denegado", "$"
inpt            times   20      DB      " "

read:
    MOV     AH,01h
    INT     21h
    RET

view:
    XOR     SI,SI
while:
    CALL    read
    cmp     AL,0x0D
    JE      exit
    MOV     [BP+SI],AL
    INC     SI
    JMP     while
exit:
    MOV     byte [BP+SI], "$"
    RET

write:
    MOV     AH,09h
    INT     21h
    RET

same:
    MOV     AL,[pass_word]
    MOV     AH,[inpt]
    cmp     AL,AH
    JE      good
    jne     wrong
    RET
good:
    MOV     DX,mmsgok
    RET
wrong:
    MOV     DX,mssgbad
    RET