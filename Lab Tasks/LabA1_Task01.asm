.MODEL SMALL  

.STACK 100H  

.DATA
    ; DEFINE YOUR VARIABLES HERE

.CODE
    MAIN PROC
        
        MOV AX, @DATA
        MOV DS, AX
        
        MOV AL, 3 ;AL=3
        MOV BL, 8 ;BL=8
        
        ; Code for Swap two numbers using ADD/SUB instructions only.
        
        ADD DL,BL ;DL=DL+8=0+8=8 Here, DL is used for storing BL register's value temporarily 
        ADD BL,AL ;BL=BL+AL=8+3=11    
        SUB BL,DL ;BL=BL-DL=11-8=3 So,BL=3
        SUB AL,AL ;AL=AL-AL=3-3=0 
        ADD AL,DL ;AL=AL+DL=0+8=8
                  ;SWAP complete as now, AL=8     
  
        ; MY CODE ENDS HERE
        
        MOV AX, 4C00H
        INT 21H
        
    MAIN ENDP
    END MAIN