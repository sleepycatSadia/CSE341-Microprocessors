;Task 01
;Take your name as input in an array. Then your program will have to replace all the capital letters 
;with the letter "G" and all the small letters with the letter "h".
;Sample Input:
;Enter Name: Sadia Tasnim
;Output: Ghhhh Ghhhhh    

.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE         
    NameArr db 12 DUP(?)      ;My Name is Sadia Tasnim=12 characters 
                              ; including the space in between                  
    namePrompt db "Enter your name (Fill up 12 characters,use Space if needed): $"   
    outputPrompt db  "Your name after changes : $"             
    nameLen dw ?
.CODE
    MAIN PROC
  
    MOV AX, @DATA
    MOV DS, AX
                                         
    ; YOUR CODE STARTS HERE       
        
    LEA DX,namePrompt     ;Input Name Prompt
    MOV AH,9              ;string output
    INT 21H               ;interrupt   
    
    MOV CX,12             ;array iteration will be done 12 times
    MOV AH,1              ;Iteration will be done for taking Inputs
    
    LEA SI,NameArr        ;loading the address of array that will be used
                          ;location where the first value/idx is stored in SI
                          ;hence, SI=idx=0
    
    InputArray: 
    INT 21H               ;Interrupt for taking char input
    MOV [SI],AL           ;arr[idx]=Name Char
    INC SI                ;idx++
    LOOP InputArray:      ;if idx <=12 continue LOOP
    
    MOV AH, 2
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt
    
    LEA DX,outputPrompt   ;Output statement
    MOV AH,9              ;string output
    INT 21H               ;interrupt
    
    
    MOV CX,12             ;arr size=12
    MOV AH,2              ;Iteration will be done for Charecter Outputs
    
    LEA SI,NameArr        ;loading the address of array that will be used
                          ;location where the first value/idx is stored in SI
                          ;hence, SI=idx=0
    
    
    ChangeCharAndPrint:
    
    MOV DL,[SI]           ;DL=arr[idx]
    
    CMP DL,20H            ;check if the char == space 
    JE ChangeDone         ;if char=space then dont need to convert to G/h
    
    CMP DL,61H            ;check if char ==Capital Letter
    JL ChangeToG          ;if it is Cap Letter Change to G
    JGE ChangeToh         ;if it is Small Letter Change to h
    
    ChangeDone:           ;Come here after necessery changes are made
    MOV [SI],DL           ;store the updated char in arr
    INT 21h               ;interrupt for printing the char
    INC SI                ;idx++
    LOOP ChangeCharAndPrint;if idx <=12 continue LOOP
    JMP EXIT              ;printing done move to exit
    
    ChangeToG:            
    MOV DL,47H            ;Cap Letter Change to G
    JMP ChangeDone        ;change done
    
    
    ChangeToh:            
    MOV DL,68H            ;Small Letter Change to h
    JMP ChangeDone        ;change done
    
    
 
    EXIT:  
    ; YOUR CODE ENDS HERE
    
    MOV AX, 4C00H
    INT 21H
        
    MAIN ENDP
    END MAIN