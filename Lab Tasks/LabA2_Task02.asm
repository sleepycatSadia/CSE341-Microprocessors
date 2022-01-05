
;Task 02 
;Take a lowercase letter as input from the user (omit error checking, so you do not
;have to write code for checking whether the user is inputting uppercase or lower
;case), and display it at the next position on the next line in upper case.

.MODEL SMALL  

.STACK 100H  

.DATA
    ; DEFINE YOUR VARIABLES HERE   
.CODE
    MAIN PROC   
        
        MOV AX, @DATA
        MOV DS, AX
            
        ; YOUR CODE STARTS HERE 
          
        
        MOV AH,1   ;char input for lowercase letter
        INT 21H    ;interrupt
        MOV DL,AL  ;DL=lowercase letter ascii value
        
        SUB DL,20H ;DL=DL-20H =uppercase letter ascii value
        MOV BL,DL  ;BL=DL =uppercase letter ascii value
        
        MOV AH,2       
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt 
        
        MOV DL,BL  ;DL=BL =uppercase letter ascii value
        MOV AH,2   ;char output
        INT 21H    ;interrupt
        
             
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN   
