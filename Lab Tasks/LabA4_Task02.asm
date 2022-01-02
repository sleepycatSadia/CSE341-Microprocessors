;Task 02
;Find the sum of the following sequence using loops and print the result.
;0 + 2 + 2 + 4 + 6 + 10 + 16 + 26 + 42 + 68 + 110      
.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE        
    
.CODE 
     
 MAIN PROC
  
        MOV AX, @DATA
        MOV DS, AX
                                             
        ; YOUR CODE STARTS HERE       
        
        ;----------------------------------------------
        ;python code  
        ;----------------------------------------------
        ;a=0
        ;b=2
        ;sum=0
        ;while(True):
        ;  sum=sum+a
        ;  if(b>110):
        ;    break
        ;  sum=sum+b
        ;  a=a+b
        ;  b=a+b
        ;print(sum)
        ;----------------------------------------------
        
        MOV BX, 0d
        MOV CX, 2d    
        MOV DX, 0d
        
        LOOP:     
        ADD DX,BX
        CMP CX,110d
        JG PRINT
        ADD DX,CX
        ADD BX,CX
        ADD CX,BX
        JMP LOOP
      
            
        PRINT:
        
        MOV CL,10d
        
        MOV AX, DX
        DIV CL
        MOV DX,AX
        MOV AL,00
        PUSH AX 
        
        MOV  DH,00   
        MOV AX,DX
        DIV CL
        MOV DX,AX
        MOV AL,00
        PUSH AX   
        
        MOV  DH,00  
        MOV AX,DX  
        DIV CL
        MOV AL,00
        PUSH AX
        
        POP AX 
        MOV DL,AH  
        ADD DL,30H
        MOV AH,2
        INT 21H
        POP AX 
        MOV DL,AH 
        ADD DL,30H
        MOV AH,2
        INT 21H
        POP AX 
        MOV DL,AH
        ADD DL,30H
        MOV AH,2
        INT 21H

        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN