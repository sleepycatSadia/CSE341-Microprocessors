.MODEL SMALL  

.STACK 100H  

.DATA
    ; DEFINE YOUR VARIABLES HERE     
.CODE
    MAIN PROC   
        
        MOV AX, @DATA
        MOV DS, AX
        
        ; YOUR CODE STARTS HERE  
        
        MOV AX, 5 ;AX=5
        MOV BX, 2 ;BX=2
        MUL BX    ;AX=(5*2)
        
        MOV BX, 4 ;BX=4
        SUB BX, 0 ;BX=(4-0)
        
        ADD AX,BX ;AX=AX+BX=(5*2)+(4-0)
        
        MOV BX, 5 ;BX=5
        ADD BX, 3 ;BX=5+3
        ADD BX, 2 ;BX=5+3+2
        
        ADD AX,BX ;AX=AX+BX=(5*2)+(4-0)+(5+3+2)
        MOV BX,AX ;BX=AX=(5*2)+(4-0)+(5+3+2)
        
        MOV AX, 6 ;AX=6
        MOV CX, 2 ;CX=2
        DIV CX    ;AX=AX/CX=6/2
        
        SUB BX, AX;BX=BX-AX=(5*2)+(4-0)+(5+3+2)-(6/2)
                  ;arithmetic operation is completed & result stored in BX 
        
        
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN