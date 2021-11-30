;Task 03
;Write a program which takes in a digit from 1 to 6 where each digit represents a month in a 
;calendar year. For example the digit 1 represents January, 2 represents February, and 3 represents 
;March and so on. Your program should then output the total number of days in that month

.MODEL SMALL  

.STACK 100H  

.DATA
    ; DEFINE YOUR VARIABLES HERE
    inputPrompt db "ENTER MONTH DIGIT BETWEEN 1 TO 6: $"
      
    string31 db "31 $"  
    string30 db "30 $"     
    string28 db "28 $"

.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        ; YOUR CODE STARTS HERE
        MOV AH, 9
        LEA DX, inputPrompt
        INT 21H
        
        MOV AH, 1
        INT 21H  
         
         
        SUB AL,30H
        
        CMP AL, 1D
        JE thirty-one
        
        CMP AL, 2D
        JE twenty-eight 
                
        CMP AL, 3D
        JE thirty-one
                   
        CMP AL, 4D
        JE thirty
        
        CMP AL, 5D
        JE thirty-one
                
        CMP AL, 6D
        JE thirty
       

        
        thirty-one: 
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H 
        MOV AH, 9
        LEA DX, string31
        INT 21H  
        JMP EXIT
        
        thirty:
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H
         MOV AH, 9
        LEA DX, string30
        INT 21H
        JMP EXIT
        
        twenty-eight:
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H 
        MOV AH, 9
        LEA DX, string28
        INT 21H
        JMP EXIT
          
        EXIT:
        
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN
