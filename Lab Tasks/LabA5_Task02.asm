;Task 02
;Take four 8 bit inputs from the user, store them in an array and print the sum of only the odd 
;numbers
;Sample Input:
;Enter Three numbers: 1 2 3 4
;Output:
;Sum: 4

.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE         
    NumArr DW 4 DUP(?)       
    inputPrompt1 DB "Please Input Four 2 bit HEX numbers in Range 00-FF below: $"    
    inputPrompt2 DB "Kindly use CAPITAL letter when inputting HEX numbers. $"    
    inputPrompt3 DB "Example: Use F instead of f to get correct output. Thank you. $"
    inputPrompt4 DB "Append a 0 before if you insert single digit.eg write 04 instead of 4. $"  
    numPrompt DB "Enter number in 2 HEX bits= $"             
    outputPromptDec DB  "Sum of ODD Numbers in DECIMAL : $"          
    one DB 01
    base DB 16  
    
    divisor10    DB 10 
    divisor10W   DW 10 
        
    bit4 DB ?
    bit3 DB ?
    bit2 DB ?
    

    divisor2 DB 2  

    sum  DB ?
.CODE
    MAIN PROC
  
        MOV AX, @DATA
        MOV DS, AX
                                             
        ; YOUR CODE STARTS HERE       
        
        ;----------------------------------------------
        ;First we take 4 2bit HEX inputs using prompts
        ;----------------------------------------------
        
        LEA DX,inputPrompt1   ;Input Prompt
        MOV AH,9              ;print string
        INT 21H               ;interrupt   
        
        MOV AH, 2             ;set cursor position.
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H  
        
        LEA DX,inputPrompt4   ;Input Prompt
        MOV AH,9              ;print string
        INT 21H
        
        MOV AH, 2             ;set cursor position.
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H 
        
        LEA DX,inputPrompt2   ;Input Prompt
        MOV AH,9              ;print string
        INT 21H
        
        MOV AH, 2             ;set cursor position.
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H  
        
        LEA DX,inputPrompt3   ;Input Prompt
        MOV AH,9              ;print string
        INT 21H
        
        MOV AH, 2             ;set cursor position.
        MOV DL, 0DH           ;carriage return
        INT 21H               ;interrupt             
        MOV DL, 0AH           ;line feed
        INT 21H               ;interrupt

        MOV CX,4              ;arr size=4
        LEA SI,NumArr         ;loading the address of array that will be used
                              ;location where the first value/idx is stored in SI
                              ;hence, SI=idx=0  
        
        InputArray:                                

        LEA DX,numPrompt      ;number input Prompt
        MOV AH,9              ;print string
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
        LOOP InputArray       ;if idx<4 continue loop
        
        JMP OddSumCalc        ;if idx>=4 ,calculate OddNumSum 
        
        
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
        ;Calculate Sum of ODD numbers
        ;-----------------------------------------------------
        OddSumCalc:
        MOV BX,00                ;BX=SumOfOdd=0
        MOV CX,4                 ;arr size=4
        LEA SI,NumArr            ;loading the address of array that will be used
                                 ;location where the first value/idx is stored in SI
                                 ;hence, SI=idx=0  
         
        OddSumCalcLoop:
   
        MOV AX,00                ;resetting AX
        MOV AX,NumArr[SI]        ;storing arr[idx] into AX
        MOV AH,00                ;resetting AH just in case
        MOV DL,AL                ;DL=arr[idx] stored so that we can add the
                                 ;the value of arr[idx] from DL
                                 ;incase it turns out to be ODD
        DIV divisor2             ;div by 2 check EVEN/ODD
        CMP AH,one               ;check if remainder is one
        JE AddNumToSum           ;if rem=one its ODD,add to sum
        DoneAdding:              ;num was added into sum if needed
        INC SI                   ;idx++
        LOOP OddSumCalcLoop      ;if idx<4 continue Loop
        
        
        
    
        LEA DX,outputPromptDec   ;output statement
        MOV AH,9                 ;string output
        INT 21H                  ;interrupt
                
        PrintDec:
        
    ;--------------------------------------
    ;Printing the sum bit by bit     
    ;We considered the sum is in 4 dec bits
    ;First we will split all 4 bits
    ;then we print them
    ;--------------------------------------
    
    ;SUM is in BX right now
    
    MOV AX,00                ;reset AX
    MOV DX,00                ;reset DX 
    
    ;--------------
    ;splitting bits
    ;--------------
    
    PrintSum:                ;sum is stored in CX
           
    ;---------------------------------------------------
    ;We will extract the 1st bit 
    ;by manually dividing the sum by 10
    ;and then get the remainder 
    ;the remainder will be the 1st bit
    ;We used manual division because
    ;if the sum is big,then after dividing by 10,
    ;the quotient we will get will be more tha FF.   
    ;example : 2567/10 Q=256>FF(255d)  
    ;
    ;If the quotient is more than FF, then it
    ;can't be stored in AL(default location for quotient) 
    ;because AL=8 bit register so max value that can be
    ;stored here without causing any overflow is 255d /FF
    ;
    ;So while manually dividing we will store the 
    ;quotient  in BX -will be used to extract next(2nd) bit
    ;remainder in AX -will be pushed in STACK     
    ;
    ;While doing repetitive subtraction
    ;the subtraction result will be in AX
    ;---------------------------------------------------
    
    MOV DX,BX                ;DX=sum
    MOV BX,00H               ;BX=subCount=0
                             ;it keeps track how many times we 
                             ;could subtract 10 from the sum
                             ;BX=quotient will be stored here
    
    MOV AX,DX                ;AX=4 DEC bits of Sum
    
    LoopFor1stBit:           ;loop for extracting 1st bit
    
    CMP AX,divisor10W        ;compare current subtraction result with 10
    JL breakLoop             ;if current sub result < 10,
                             ;then break the repetitive subtraction  
                             
                             ;else sub result>=10,we can subtract again
    SUB AX,divisor10W        ;sum=sum-10
    INC BX                   ;subCount++
    
    JMP LoopFor1stBit        ;continue subtracting loop
    breakLoop:               ;manual division complete 
    MOV AH,AL                ;the rem is in AL,we move it to AH
    MOV AL,00                ;reset AL 
    PUSH AX                  ;AX=remainder=1st bit=pushed to stack
    MOV DX,BX                ;BX=quotient
    
    ;----------------------------------------                         
    ;DX has the quotient found from prev step  
    ;dividing this quotient by 10
    ;remainder=3rd bit=will be pushed to stack 
    ;----------------------------------------
    
    MOV AX,DX                ;AX=3 DEC bits of Sum
    DIV divisor10            ;AX/10
    MOV DX,AX                ;storing the rem and quotient
    MOV AL,00                ;we just need the rem so reset AH
    PUSH AX                  ;storing the 2nd DEC bit
    MOV DH,00                ;reset DH                         
    ;----------------------------------------                         
    ;DX has the quotient found from prev step  
    ;dividing this quotient by 10
    ;remainder=2nd bit=will be pushed to stack 
    ;----------------------------------------
    
    MOV AX,DX                ;AX=2 DEC bits of Sum
    DIV divisor10            ;AX/10
    MOV DX,AX                ;storing the rem and quotient
    MOV AL,00                ;we just need the rem so reset AH
    PUSH AX                  ;storing the 3rd DEC bit
    MOV DH,00                ;reset DH               
    
    ;----------------------------------------                         
    ;DX has the quotient found from prev step  
    ;dividing this quotient by 10
    ;remainder=1st bit=will be pushed to stack 
    ;----------------------------------------
    
    MOV AX,DX                ;AX=1 DEC bit  of Sum
    DIV divisor10            ;AX/10
    MOV DX,AX                ;storing the rem and quotient      
    MOV AL,00                ;we just need the rem so reset AH
    PUSH AX                  ;storing the 4th DEC bit
               
     
    
    ;--------------
    ;printing bits
    ;--------------
    
     
               
    ;Here 4th bit=MSB bit, 1st bit=LSB bit
    ;3rd & 2nd bits are bits in between 1st & 4th
    ;If the Total Decimal Sum=3125 ,then
    ;bit4=3, bit3=1, bit2=2, bit1=5
               
    ;--------------------------
    ;Skipping/Printing 4th bit  
    ;if bit4=0 we don't print it
    ;else we print it
    ;--------------------------           
    
    POP AX                   ;popping 4th DEC bit
    MOV DL,AH                ;DL=4th bit
    MOV bit4,DL              ;storing 4th bit in bit4 var
    CMP bit4,00              ;check if 4th bit is 0
    JE SkipPrintBit4         ;if bit4 is 0,no need to print it
                             ;if bit4 not 0,we print it    
                             
    ADD DL,30H               ;getting proper Ascii value    
    MOV AH,2                 ;printing char
    INT 21H                  ;interrupt
    
    SkipPrintBit4:           ;move on with/without printing bit4
    
    ;-------------------------------------------
    ;Skipping/Printing 3rd bit       
    ;if bit3,bit4 both =0,we don't print bit3 
    ;else we print it   
    ;-------------------------------------------
    
    
    POP AX                   ;popping 3rd DEC bit
    MOV DL,AH                ;DL=3rd bit
    MOV bit3,DL              ;storing 3rd bit in bit3 var 
    CMP bit3,00              ;check if 3rd bit is 0
    
    JE CheckBit4is0forPrintingBit3 ;if bit3 is 0  ,
                                   ;We check if bit4=0 too/not 
                                         
    JG PrintBit3             ;if bit3=0,no need to check bit4
                             ;we print bit3
    
    CheckBit4is0forPrintingBit3:
    CMP bit4,00              ;compare bit 4 with 0
    JE SkipPrintBit3         ;if bit4=0 given that bit3=0
                             ;we skip printing bit3
                             
                             ;if bit3=0 but bit4 not 0
                             ;we print the bit3
                             
    PrintBit3:               ;prints bit3
                             
                              
    ADD DL,30H               ;getting proper Ascii value
    MOV AH,2                 ;printing char
    INT 21H                  ;interrupt
    
    
    SkipPrintBit3:           ;move on  with/without printing bit3
    
                
    ;----------------------------------------
    ;Skipping/Printing 2nd bit  
    ;if bit2=bit3=bit4=0 we don't print bit2
    ;else we print it
    ;---------------------------------------- 
    
    POP AX                   ;popping 2nd DEC bit
    MOV DL,AH                ;DL=2nd bit
    MOV bit2,DL              ;storing 2nd bit in bit2 var
    CMP bit2,00              ;check if 2nd bit is 0
    
    JE CheckBit3is0forPrintingBit2 ;if bit2 is 0    
                                   ;We check if bit3=0 too/not    
    
    JG PrintBit2             ;if bit2 not 0
                             ;we print bit2
                              
   
    CheckBit3is0forPrintingBit2:
    CMP bit3,00                    ;compare bit3 with 0
    JE CheckBit4is0forPrintingBit2:;if bit3=0 
                                   ;we need to check if bit4=0 too/not
   
    JG PrintBit2             ;if bit3 not 0 even though bit2= 0
                             ;we need to print bit2
    
    CheckBit4is0forPrintingBit2:
    CMP bit4,00              ;compare bit4 with 0
    JE SkipPrintBit2         ;if bit4=0 too ,then bit4=bit3=bit2=0
                             ;we skip printing bit2
                             
                             ;if bit2=bit3=0 but bit4 not 0
                             ;we print the 2nd bit
                             
    PrintBit2:               ;prints bit2
                             
    ADD DL,30H               ;getting proper Ascii value
    MOV AH,2                 ;printing char
    INT 21H                  ;interrupt
    
    SkipPrintBit2:           ;move on  with/without printing bit2
    
    ;--------------------------
    ;Printing 1st bit
    ;-------------------------- 
    
    
    POP AX                   ;popping 1st DEC bit
    MOV DL,AH                ;DL=1st bit
    ADD DL,30H               ;getting proper Ascii value
    MOV AH,2                 ;printing char
    INT 21H                  ;interrupt
   
    JMP EXIT 
        
        
        
        AddNumToSum: 
        
        ADD BX,DX                ;add ODD num in sum
        JMP DoneAdding  
    
    EXIT:    
    ; YOUR CODE ENDS HERE
    
    MOV AX, 4C00H
    INT 21H
    
    MAIN ENDP    5
    END MAIN 
message.txt
21 KB
