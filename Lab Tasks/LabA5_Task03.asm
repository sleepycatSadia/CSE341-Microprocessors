;Task 03
;Take an array of size 5, then populate the array with 8 bit values.
;Your program will then sort the 
;array in ascending order and print the elements as output. 

.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE         
    NumArr DB 5 DUP(?)       
    inputPrompt1 DB "Please Input FIVE 2 bit HEX numbers in Range 00-FF below: $"
    inputPrompt2 DB "Kindly use CAPITAL letter when inputting HEX numbers. $"
    inputPrompt3 DB "Example: Use F instead of f to get correct output. Thank you. $"
    inputPrompt4 DB "Append a 0 before if you insert single digit.eg write 04 instead of 4. $"  
    numPrompt DB "Enter number in 2 HEX bits= $"             
    outputPrompt DB  "Array Sorted in Ascending order in HEX : $"           
    space DB " $"     
    store DW 0
    base db 16              
    min_idx dw 0
    temp dw 0    
    divisor16 DB 16  
    num10 DB 10
.CODE
    MAIN PROC

    MOV AX, @DATA
    MOV DS, AX
                                         
    ; YOUR CODE STARTS HERE       
    
    ;----------------------------------------------
    ;Taking FIVE 2bits HEX number inputs in array
    ;----------------------------------------------
    
    LEA DX,inputPrompt1   ;Input Prompt address loaded
    MOV AH,9              ;printing the prompt
    INT 21H               ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt 
    
    LEA DX,inputPrompt4   ;Input Prompt address loaded
    MOV AH,9              ;printing the prompt
    INT 21H               ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H    
               
    LEA DX,inputPrompt2   ;Input Prompt address loaded
    MOV AH,9              ;printing the prompt
    INT 21H               ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H    
    
    LEA DX,inputPrompt3   ;Input Prompt address loaded
    MOV AH,9              ;printing the prompt
    INT 21H               ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H 
               
    
    MOV CX,5              ;arr size=5
    
    LEA SI,NumArr         ;SI=idx=0
    
    InputArray:                                

    LEA DX,numPrompt      ;num Input Prompt
    MOV AH,9              ;printing the prompt
    INT 21H               ;interrupt   
    
    MOV DX,00             ;num will be stored in DX

    MOV AH, 1             ;taking input of 1st bit 
    INT 21H               ;interrupt 
    MOV AH,00             ;resetting AH
    SUB AL,30H            ;for ease of calculation
    PUSH AX               ;1st bit pushed in stack
    
    MOV AH, 1             ;taking input of 2nd bit 
    INT 21H               ;interrupt 
    MOV AH,00             ;resetting AH
    SUB AL,30H            ;for ease of calculation
    PUSH AX               ;2nd bit pushed in stack
                                                    
                                                    
                                                    
    POP AX                ;2nd bit that was entered is popped 
                          ;AX=2nd bit *16^0
    CMP AL,11H            ;to check if 2nd bit is in range 0h-9h
    JGE CHANGE1           ;if 2nd bit is originally in range A-F      
                          ;change the popped bit to HEX
                          ;example : popped 11>> A,popped 14>>D       
    DONE1:                ;back her when change is done
    ADD DX,AX             ;add the 2nd bit in DX    
    
            
      

    POP AX                ;1st bit that was entered is popped 
                          ;AX=1st bit *16^0
    CMP AL,11H            ;to check if 2nd bit is in range 0h-9h
    JGE CHANGE2           ;if 1st bit is originally in range A-F
                          ;change the popped bit to HEX
    MUL base              ;AX=1st bit *16^0*16 =>AX=1st bit *16^1
    DONE2:                ;back her when change is done
    ADD DX,AX             ;add the 1st bit in DX  
                   
    MOV [SI],DL           ;arr[idx]=2bits HEX num
    
    MOV AH, 2             ;set cursor position. 
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt 
    
    INC SI                ;idx++
   
    LOOP InputArray       ;if idx<5
    JMP  Sort             ;now go to sort array
    
    CHANGE1:
    CMP AL,11H            
    JE MakeA1
    CMP AL,12H
    JE MakeB1
    CMP AL,13H
    JE MakeC1
    CMP AL,14H
    JE MakeD1
    CMP AL,15H
    JE MakeE1
    CMP AL,16H
    JE MakeF1

    MakeA1:
    MOV AL,10            ;11H>>A
    JMP DONE1
    MakeB1:
    MOV AL,11            ;12H>>B
    JMP DONE1
    MakeC1:
    MOV AL,12            ;13H>>C
    JMP DONE1
    MakeD1:
    MOV AL,13            ;14H>>D
    JMP DONE1 
    MakeE1:
    MOV AL,14            ;15H>>E
    JMP DONE1
    MakeF1:
    MOV AL,15            ;16H>>F
    JMP DONE1
    
    CHANGE2:     
    CMP AL,11H
    JE MakeA2
    CMP AL,12H
    JE MakeB2
    CMP AL,13H
    JE MakeC2
    CMP AL,14H
    JE MakeD2
    CMP AL,15H
    JE MakeE2
    CMP AL,16H
    JE MakeF2

    MakeA2:
    MOV AL,160           ;11H>>A0
    JMP DONE2 
    MakeB2:
    MOV AL,176           ;12H>>B0
    JMP DONE2
    MakeC2:
    MOV AL,192           ;13H>>C0
    JMP DONE2
    MakeD2:
    MOV AL,208           ;14H>>D0
    JMP DONE2 
    MakeE2:
    MOV AL,224           ;15H>>E0
    JMP DONE2            
    MakeF2:
    MOV AL,240           ;16H>>F0
    JMP DONE2
    
    
    ;-----------------------------------------------------
    ;JAVA Selection SORT algo
    ;-----------------------------------------------------
    ;for (int i = 0; i < n-1; i++){
    ;    int min_idx = i;
    ;    for (int j = i+1; j < n; j++)
    ;        if (arr[j] < arr[min_idx])
    ;            min_idx = j;
    ;    int temp = arr[min_idx];
    ;    arr[min_idx] = arr[i];
    ;    arr[i] = temp;
    ;}
    ;-----------------------------------------------------
    Sort:  
    
    LEA DX,outputPrompt         ;output statement
    MOV AH,9                    ;string output
    INT 21H                     ;interrupt
            
    LEA SI, NumArr              ;loading the address of array that will be used
                                ;location where the first value/idx is stored in SI
                                ;hence, SI=idx=0     
                                 
    MOV BX, 0                   ;i=0
    MOV CX, 0                   ;j=0
    
    OuterLoop:
    CMP BX, 4                   ;compare i & 4                     
    JGE PrintArr                ;if i>=4 break outer loop
    MOV min_idx, BX             ;if i< 4 min_idx=i
    MOV CX, BX                  ;j=i
    ADD CX, 1                   ;j=i+1
    
    InnerLoop:
    CMP CX, 5                   ;compare j & 5
    JGE SWAP                    ;if j>=5 break inner loop  and do swap
    
    MOV TEMP, BX                ;temp=i
    MOV BX, CX                  ;i=j
    
    MOV AL, [SI+BX]             ;AL=NumArr[j]
    MOV BX, min_idx             ;i=min_idx
    MOV AH, [SI+BX]             ;AH=NumArr[min_idx]
    MOV BX, TEMP                ;i=temp
    
    MOV store,DX                ;storing DX 's current vale
    MOV DX,00                   ;reset DX
    MOV DL,AH                   ;moving NumArr[j] in DL
    MOV AH,00                   ;reset AH
                                ;now AX=NumArr[j],DX=NumArr[min_idx] 
    CMP AX, DX                  ;compare NumArr[j] &NumArr[min_idx]
    MOV DX,store                ;restoring DX's value
    JL UPDATE                   ;if NumArr[j] < NumArr[min_idx] then Update min_idx
    BACK:
    INC CX                      ;j++
    JMP InnerLoop  
    
    
    UPDATE:
    MOV min_idx, CX             ;min_idx=j     
    JMP BACK   
    
    
    SWAP:
    MOV temp, BX                ;temp=i
    MOV BX, min_idx             ;i=min_idx
    MOV DL, [SI+BX]             ;DL=NumArr[min_idx]
    MOV BX, temp                ;i=temp
    MOV DH, [SI+BX]             ;DH=NumArr[i]
    MOV BX, min_idx             ;i=min_idx
    MOV [SI+BX], DH             ;NumArr[min_idx]=NumArr[i]
    MOV BX, temp                ;i=temp
    MOV [SI+BX], DL             ;NumArr[i]=temp=NumArr[min_idx]
    INC BX                      ;i++
    JMP OuterLoop              
    ;-----------------------------------------------------

    Print2HexBits:           ;now 2 HEX bits are in DL
    MOV AX,00                ;resetting AX
    MOV DH,00                ;resetting DH
    MOV AX,DX                ;keeping 2 HEX bits in AX
    DIV divisor16            ;hex num /16 to get remainder

    MOV DL,AL                ;storing the quotient in DL
    MOV DH,AH                ;storing remainder in DH
    
    CMP DL ,num10            ;check if bit is in range A-F
    JGE GetAscii1            ;if bit >=10h fix ascii accordingly
    ADD DL,30H               ;if bit is range 1h-9h
    Ascii1Done:              ;ascii fixed
    MOV AH,2                 ;printing bit
    INT 21H                  ;interrupt
    
    MOV DL,DH                ;moving the remainder in DL to print
    
    CMP DL ,num10            ;check if bit is in range A-F
    JGE GetAscii2            ;if bit >=10h fix ascii accordingly
    ADD DL,30H               ;if bit is range 1h-9h
    Ascii2Done:              ;ascii fixed
    MOV AH,2                 ;printing bit
    INT 21H                  ;interrupt
    
    LEA DX,Space             ;loading address of space 
    MOV AH,9                 ;printing space
    INT 21H                  ;interrupt
          
    JMP  Print2HexBitsDone   ;2 HEX bits printing completed
     
     
     
    GetAscii1:
    ADD DL,37H               ;example : HEX A >> A+37 = HEX 41 = ascii A
    JMP Ascii1Done:      
    
    GetAscii2:
    ADD DL,37H               ;example : HEX B >> B+37 = HEX 42 = ascii B
    JMP Ascii2Done:
    
    
    
    PrintArr:  
    LEA SI, NumArr             ;loading the address of array that will be used
                               ;location where the first value/idx is stored in SI
                               ;hence, SI=idx=0     
                                 
    PRINT:                     ;print loop
    MOV AH, 2                  ;set cursor position
    MOV DL, [SI]               ;DL=arr[idx] 
    JMP Print2HexBits          ;print the 2 HEX bits in DL
    Print2HexBitsDone:         ;2 HEX bits print done
    INT 21H                    ;interrupt
    INC SI                     ;idx++
    LOOP PRINT                 ;if idx<5
    
    
    
    
    
    EXIT:    
    ; YOUR CODE ENDS HERE
    
    MOV AX, 4C00H
    INT 21H
    
    MAIN ENDP
    END MAIN