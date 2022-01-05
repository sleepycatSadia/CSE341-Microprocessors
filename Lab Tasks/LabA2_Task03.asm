;Task 03 
;Write a program to: (a) prompt the user, (b) read first initial, then the second,
;and then the third and finally last initial, and then (c) display them the way Shown below.
.MODEL SMALL 
.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE   
    P1 DB "Enter First Initial: $"  
    P2 DB "Enter Second Initial: $"
    P3 DB "Enter Third Initial: $"
    P4 DB "Enter Last Initial: $"
.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX
        ; YOUR CODE STARTS HERE 
        ;----------------------------------------------
        ;First we take 4 inputs using 4 prompts
        ;----------------------------------------------
                 
        LEA DX,P1  ;load effective address
        MOV AH,9   ;string output
        INT 21H    ;interrupt
        MOV AH,1   ;char input for First Initial
        INT 21H    ;interrupt
        MOV BH,AL  ;BH=AL=First Initial
                  
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt
        
        LEA DX,P2  ;load effective address
        MOV AH,9   ;string output
        INT 21H    ;interrupt
        MOV AH,1   ;char input for Second Initial
        INT 21H    ;interrupt
        MOV CH,AL  ;CH=AL=Second Initial 
        
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt
        
        LEA DX,P3  ;load effective address
        MOV AH,9   ;string output
        INT 21H    ;interrupt
        MOV AH,1   ;char input for Third Initial
        INT 21H    ;interrupt
        MOV CL,AL  ;CL=AL=Third Initial
        
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt

        LEA DX,P4  ;load effective address
        MOV AH,9   ;string output
        INT 21H    ;interrupt
        MOV AH,1   ;char input for Last Initial
        INT 21H    ;interrupt
        MOV BL,AL  ;BL=AL=LastInitial
        
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt

        ;----------------------------------------------
        ;Now we print the outputs 
        ;----------------------------------------------

        
        MOV DL,BH  ;DL=first initial
        MOV AH,2   ;string char output
        INT 21H    ;interrupt
                         
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt


        MOV DL,CH  ;DL=second initial
        MOV AH,2   ; char output
        INT 21H    ;interrupt
        MOV DL,CL  ;DL=third initial
        MOV AH,2   ;char output
        INT 21H    ;interrupt

                       
        MOV AH, 2
        MOV DL, 0DH;carriage return
        INT 21H    ;interrupt             
        MOV DL, 0AH;line feed
        INT 21H    ;interrupt      
        
        
        MOV DL,BL  ;DL=Last initial
        MOV AH,2   ; char output
        INT 21H    ;interrupt
             
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN   
    
