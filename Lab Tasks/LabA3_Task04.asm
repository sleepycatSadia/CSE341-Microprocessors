;Task 04
;Write a program that takes as input the length of 3 sides of a triangle and check whether a valid triangle 
;can be formed or not. If the sides form a triangle, print “Y”, otherwise print “N”

.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE        
    prompt1 db "1st side: $"
    prompt2 db "2nd side: $"
    prompt3 db "3rd side: $"
      
    yes db "Y $"  
    no db  "N $"  
    
.CODE
    MAIN PROC
  
        MOV AX, @DATA
        MOV DS, AX
                                             
        ; YOUR CODE STARTS HERE       
        
        ;----------------------------------------------
        ;First we take 3 side lengths' using 3 prompts
        ;----------------------------------------------
        
        LEA DX,prompt1        ;SIDE 1 INPUT
        MOV AH,9              ;string output
        INT 21H               ;interrupt
        MOV AH,1              ;string char input 
        INT 21H               ;interrupt
        MOV BH,AL             ;BH=a=1st side
        MOV BL,AL             ;BL=a=1st side
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt

        LEA DX,prompt2        ;SIDE 2 INPUT
        MOV AH,9              ;string output
        INT 21H               ;interrupt
        MOV AH,1              ;string char input 
        INT 21H               ;interrupt
        MOV CH,AL             ;CH=b=2nd side
        MOV CL,AL             ;CL=b=2nd side      
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt
                                   
                               
        LEA DX,prompt3        ;SIDE 3 INPUT  
        MOV AH,9              ;string output                  
        INT 21H               ;interrupt
        MOV AH,1              ;string char input 
        INT 21H               ;interrupt
        MOV DH,AL             ;DH=c=3rd side
        MOV DL,AL             ;DL=c=3rd side 
                                   
        ;----------------------------------------------                      
        ;HERE, BL=BH=a,CH=CL=b,DH=DL=c             
        ;----------------------------------------------
                                                 
                                                 
        SUB BH,30H
        SUB BL,30H  
        SUB CH,30H
        SUB CL,30H
        SUB DH,30H
        SUB DL,30H   
                              
        ADD BH,CH             ;BH=a+b
        ADD CH,DH             ;CH=b+c
        ADD DH,BH             ;dh=c+a
        
        CMP BH,DL
        JLE IMPOSSIBLE        ;ifa+b<=c
        CMP CH,BL
        JLE IMPOSSIBLE        ;ifb+c<=a
        CMP DH,CL
        JLE IMPOSSIBLE        ;ifc+a<=b
        

                 
        
        POSSIBLE: 
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt
        MOV AH, 9
        LEA DX, yes           ;forms a triangle
        INT 21H
        JMP EXIT             
        
        IMPOSSIBLE:  
        MOV AH, 2
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt
        MOV AH, 9
        LEA DX, no            ;does not form a triangle
        INT 21H
        JMP EXIT                        

        EXIT:  
        ; YOUR CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN