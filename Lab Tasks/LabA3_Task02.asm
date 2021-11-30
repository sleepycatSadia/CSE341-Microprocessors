;Task 02
;Take two digits as input from the user and multiply them. If the result is divisible by 2 or 5 but not 
;both, print "Divisible". Otherwise print"Not divisible"


.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE        
    string1 db "Enter digit 1: $"              
    string2 db "Enter digit 2: $" 
    resultDiv  db "Divisible $"    
    resultNotDiv  db "Not divisible $"  
.CODE
    MAIN PROC
  
        MOV AX, @DATA
        MOV DS, AX
                                             
        ; YOUR CODE STARTS HERE       
        
        ;----------------------------------------------
        ;First we take 2 digit inputs using 2 prompts
        ;----------------------------------------------
        MOV CX,0000H
        LEA DX,string1        ;DIGIT 1 INPUT
        MOV AH,9              ;string output
        INT 21H               ;interrupt
        MOV AH,1              ;string char input 
        INT 21H               ;interrupt
        MOV CL,AL
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt      
        
        LEA DX,string2        ;DIGIT 1 INPUT
        MOV AH,9              ;string output
        INT 21H               ;interrupt
        MOV AH,1              ;string char input 
        INT 21H               ;interrupt
        MOV BL,AL

        ;----------------------------------------------                      
        ;checking divisibility           
        ;----------------------------------------------
        
        SUB BL, 30H
        SUB CL, 30H
        
        MOV AX,CX
        MUL BL
        MOV CX,AX  
        MOV DH,2d  ;DH=2      for checking divisibility by 2 only
        MOV DL,5d  ;DL=5      for checking divisibility by 2 only
        MOV BH,00d ;BH=0      for checking if remainder is zero or not
               
        DIV DH                ;num/2
        MOV AH,00H            ;making remainder zero so that now
                              ; we can divide the quotient by 5
        DIV DL                ;num/5
        CMP AH,BH             ;for checking if remainder is zero
                              ; after dividing by both 2 and 5
        JE DIV_BY_2_5_Both_or_None ;if remainder==0 
                                   ;the num is divisible by both 2 and 5
        
        MOV AX,CX             ;keeping the value of multiplication
                              ; again in AX          
        DIV DH                ;num/2
        CMP AH,BH             ;checking if remainder is zero
                              ; after dividing by 2
        JE DIV_BY_2_or_5_NotBoth   ;num divisible by 2
        MOV AX,CX             ;keeping the value of multiplication
                              ; again in AX
        DIV DL                ;num/5
        CMP AH,BH             ;for checking if remainder is zero
                              ; after dividing by 5
        JE DIV_BY_2_or_5_NotBoth   ;num divisible by 5
        
        DIV_BY_2_5_Both_or_None: 
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H 
        LEA DX,resultNotDiv   
        MOV AH,9              ;string output
        INT 21H 
        JMP EXIT
        
        DIV_BY_2_or_5_NotBoth:
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H 
        LEA DX,resultDiv      ;divisible by 2 or 5 but not both
        MOV AH,9              ;string output
        INT 21H 
        
        EXIT:  
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN