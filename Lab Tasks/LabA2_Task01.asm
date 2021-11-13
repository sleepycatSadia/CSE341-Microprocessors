;Task 01 
;Take two numbers as input, add them, print the message "The result is" and then 
;display the result in the next line.

.MODEL SMALL  

.STACK 100H  

.DATA
    ; DEFINE YOUR VARIABLES HERE   
    S DB "The result is $"  
.CODE
    MAIN PROC   
        
        MOV AX, @DATA
        MOV DS, AX
            
        ; YOUR CODE STARTS HERE 
          
        
        MOV AH,1   ;string char input for num 1
        INT 21H    ;interrupt
        MOV BL,AL  ;BL=AL=num 1 input
                  
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt
        
        MOV AH,1   ;string char input for num 2
        INT 21H    ;interrupt 
             
        ADD BL,AL  ;BL = BL+AL = num1+ num2
                                                
        MOV AH, 2
        MOV DL, 0DH;carriage return 
        INT 21H    ;interrupt         
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt
                   
        LEA DX,S   ;load effective address
        MOV AH,9   ;string output
        INT 21H    ;interrupt
        
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt          
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt 
              
        MOV DL,BL  ;DL = BL = num1 + num2
        SUB DL,30H ;DL=DL-30H= num1+num2-30H
        
        MOV AH,2   ;string char output
        INT 21H    ;interrupt
             
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN   
    