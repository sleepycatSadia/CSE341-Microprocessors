;Task 01
;Write a program which takes in 3 digits as input from the user and finds the maximum
.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE        
    string1 db "enter 1st digit : $"              
    string2 db "enter 2nd digit : $" 
    string3 db "enter 3rd digit : $"
    
.CODE
    MAIN PROC
  
        MOV AX, @DATA
        MOV DS, AX
                                             
        ; YOUR CODE STARTS HERE       
        
        ;----------------------------------------------
        ;First we take 3 digit inputs using 3 prompts
        ;----------------------------------------------
        
        LEA DX,string1        ;DIGIT 1 INPUT
        MOV AH,9              ;string output
        INT 21H               ;interrupt
        MOV AH,1              ;string char input 
        INT 21H               ;interrupt
        MOV BL,AL             ;BL=a=1st digit 
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt

        LEA DX,string2        ;DIGIT 2 INPUT
        MOV AH,9              ;string output
        INT 21H               ;interrupt
        MOV AH,1              ;string char input 
        INT 21H               ;interrupt
        MOV CL,AL             ;CL=b=2nd digit        
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt
                                   
                               
        LEA DX,string3        ;DIGIT 3 INPUT  
        MOV AH,9              ;string output                  
        INT 21H               ;interrupt
        MOV AH,1              ;string char input 
        INT 21H               ;interrupt
        MOV BH,AL             ;BH=c=3rd digit      
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt
                                   
        ;----------------------------------------------                      
        ;FINDING THE MAX DIGIT
        ;HERE, BL=a,CL=b,BH=c  
        ;WE WILL STORE THE MAX DIGIT IN DL REGISTER            
        ;----------------------------------------------
        
        CMP BL,CL             ;compare a and b
        JGE A_GREATER_EQUAL_B ;check if a>=b 
        JL  B_GREATER_A       ;check if b>a  
                            
       
        
        A_GREATER_EQUAL_B:    ;as a>=b ,now we will check if a>=c too
        CMP BL,BH             ;compare a and c 
        JL C_MAX              ;check if a<c
                              ;if true we jump to C_MAX                   
        MOV DL,BL             ;if not true : MAX=a=1st digit
        JMP PRINT_MAX_DIGIT   ;MAX digit sent for printing
        
        
        B_GREATER_A:          ;as b>a ,now we will check if b>=c too
        CMP CL,BH             ;compare MAX value and c [b & c]
        JL C_MAX              ;check if b<c or MAX<c   
                              ;if true we jump to C_MAX 
        MOV DL,CL             ;if not true  MAX=b=2nd digit
        JMP PRINT_MAX_DIGIT   ;MAX digit sent for printing
         
           
              
        C_MAX:                ;when c is tha MAX digit
        MOV DL,BH             ;update MAX=c=3rd digit
                 
        
        PRINT_MAX_DIGIT:
        MOV AH,2              ;string char output
        INT 21H               ;interrupt
        JMP EXIT              ;end the program as soon as
                              ;max digit printing is done
        
       
        
        EXIT:  
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN