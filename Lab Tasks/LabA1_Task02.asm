
.STACK 100H
  
.DATA
    ; DEFINE YOUR VARIABLES HERE     
    A db 1
    C db 3
    D db 4

.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        ;CODE STARTS HERE
             
        ; Code for If A, B, C and D are 4 byte sized non zero variables,
        ; perform the given mathematical operation D = A - (C - A) + D
        
        MOV AL, A ; AL=A 
        MOV CL, C ; CL=C
        MOV DL, D ; DL=D
        
                                      
        SUB CL,AL ; CL=CL-AL = C-A 
        SUB AL,CL ; AL=AL-CL =>A  = A-(C-A)  
        ADD AL,DL ; AL=AL+DL =>AL = A-(C-A)+D    
        MOV D,AL  ; mathematical operation is completed and result is stored in D
           
        ;CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN
