;Task 04 
;Write a program to read two hex digits A-F, and them and 
;display the subtraction on the next line in decimal.

.MODEL SMALL  
.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE   
    P1 DB "ENTER FIRST HEX DIGIT: $"  
    P2 DB "ENTER SECOND HEX DIGIT: $"
    R DB "IN DECIMAL SUBTRACTION IS $"

.CODE
    MAIN PROC   
        
        MOV AX, @DATA
        MOV DS, AX            
        ; YOUR CODE STARTS HERE 
                 
        ;----------------------------------------------
        ;First we take 2 Hex Digits using 2 prompts
        ;----------------------------------------------
                 
        LEA DX,P1  ;load effective address
        MOV AH,9   ;string output
        INT 21H    ;interrupt
        MOV AH,1   ;string char input for First HEX DIGIT
        INT 21H    ;interrupt
        MOV BH,AL  ;BH=AL=First HEX DIGIT   
        SUB BH,11H
                  
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt
        
        LEA DX,P2  ;load effective address
        MOV AH,9   ;string output
        INT 21H    ;interrupt
        MOV AH,1   ;string char input for Second HEX DIGIT
        INT 21H    ;interrupt
        MOV BL,AL  ;BL=AL=Second HEX DIGIT 
        SUB BL,11H 
        
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt   
        
        ;----------------------------------------------
        ;Now we print the subtraction on the next line in decimal.  
        ;----------------------------------------------
        
        
        LEA DX,R  ;load effective address
        MOV AH,9   ;string output
        INT 21H
         
        SUB BH,BL  ;BH=BH-BL=1st hex-2nd hex (assuming 1st hex>=2nd hex)
        MOV DL,BH  ;DL=BH= 1st hex-2nd hex 
        ADD DL,30H ;DL=DL+30H 
                                                            
                         
        MOV AH,2
        INT 21H    ;interrupt             
             
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN                   
    
    