.MODEL SMALL  

.STACK 100H  

.DATA
    ; DEFINE YOUR VARIABLES HERE     
    W db 1
    X db 2
    Y db 3
    Z db 4

.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        ; YOUR CODE STARTS HERE  
        
        MOV AL, X ;AL=X
        MOV BL, Z ;BL= Z
        MUL BL    ;AX=AL*BL =X*Z  
        MOV CX,AX ;CX=AX=X*Z
        
        MOV AL, Y ;AL=Y
        MOV BL, W ;BL=W
        MUL BL    ;AX=AL*BL = AX=Y*W  
        MOV DX,AX ;DX=Y*W
        
        MOV AX,CX ;AX=X*Y
        DIV DL    ;AX=AX/DL = (X*Y)/(Y*W)
                  
        MOV CX,AX ;CX=AX    = CX=(X*Y)/(Y*W) 
        
        MOV AL, Z ;AL=Z
        MOV BL, X ;BL=X
        MUL BL    ;AX=AL*BL = AX=Z*X  
        
        MOV DX,AX ;DX=Z*X    
        
        MOV AX,CX ;AX=CX    = (X*Y)/(Y*W)
        DIV DL    ;AX=AX/DL = (X*Y)/(Y*W)/(Z*X) 
        MOV X,AL  ;mathematical operation is completed and result is stored in X
        
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN
