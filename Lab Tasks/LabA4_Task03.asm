;Task 03
;Write a program which stores a large number in BX, stores another smaller number in AX.
;Now ask whether the user wants to divide or multiply. 
;If the user wants to divide, then perform BX / AX using repeated subtraction and print the final remainder.
;And if the user wants to multiply then perform BX * AX using repeated summation and print the final result.
;You will not be able to use the "DIV" or the "MUL" function here.
;And you do not have to take overflow into account 
;i.e. the test cases should be done without using any numbers which can cause overflow.

   
.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE  
    choice db "Type 1 for Multiplication Type 2 for Division $"    
    string1 db "Enter larger number (0-9): $"              
    string2 db "Enter smaller number (0-9): $"   
    result db "Result is:(Remainder for division/final summation for multiplication) $"

.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        ; YOUR CODE STARTS HERE
        MOV CX,00
        MOV BX,00
        
        LEA DX,string1
        MOV AH,9
        INT 21H
        MOV AH, 1
        INT 21H
        MOV CL, AL
        
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt 
        
        LEA DX,string2
        MOV AH,9
        INT 21H
        MOV AH, 1
        INT 21H
        MOV BL, AL      
        
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt 
        
        LEA DX,choice
        MOV AH,9
        INT 21H
        MOV AH, 1
        INT 21H      
 
        
        CMP AL,31H
        JE MULTIPLICATION
        JMP DIVISION
        
        DIVISION:
        MOV AX,CX
        MOV BX,BX
        SUB AX,30H
        SUB BX,30H
        MOV CX,BX

        REPEATED_SUBTRACTION:
        SUB AX,CX
     
        CMP AX,CX
        JL NEXT
 
        JMP REPEATED_SUBTRACTION     
        NEXT:
         
        MOV BX,AX
                
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt
        MOV DL, 0AH           ;line feed
        INT 21H        
        LEA DX,result
        MOV AH,9
        INT 21H
        
        MOV DX,BX
        JMP PRINT 
        
        
        MULTIPLICATION:
        MOV AX,BX
        MOV BX,CX
        SUB AX,30H
        SUB BX,30H
        MOV CX,AX

        REPEATED_SUM:
        ADD AX,CX
        SUB BX,1H
        CMP BX,1
        JG REPEATED_SUM
 
        MOV BX,AX
                
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt
        MOV DL, 0AH           ;line feed
        INT 21H        
        LEA DX,result
        MOV AH,9
        INT 21H
        
        MOV DX,BX
        JMP PRINT  
        
        
        
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
