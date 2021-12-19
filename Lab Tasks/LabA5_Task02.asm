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
    outputPromptHex DB  "Sum of ODD Numbers in HEXADECIMAL : $"             
    one DB 01
    base DB 16  
    divisor256 DW 256
    divisor2 DB 2  
    divisor10 DB 10     
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
        
        
        
    
        LEA DX,outputPromptHex   ;output statement
        MOV AH,9                 ;string output
        INT 21H                  ;interrupt
        
        Print3HexBits:           ;now 3 HEX bits are in BX
        MOV AX,00                ;resetting AX
        MOV CX,BX                ;storing sum in CX to use 
                                 ;it when printing dec version
        MOV AX,BX                ;moving 3 HEX bits in AX
        CMP AX,255               ;to check if the sum has 3 HEX bits 
        JG ThirdBitNot0          ;if sum>=255D it has non zero third bit 
        MOV DL,00                ;if sum<255D third bit of sum=0
        JMP ThirdBitIsInDLnow:   ;required third bit stored in DL
        
        ThirdBitNot0:            ;calculate to get nonzero 3rd bit
        DIV divisor256           ;hex num /256 to get quotient
        
        MOV DL,AL                ;DL=quotient=non zero 3rd bit
        
        ThirdBitIsInDLnow:
        CMP DL ,divisor10        ;check if bit is in range A-F
        JGE GetAscii3            ;if bit >=10h fix ascii accordingly
        ADD DL,30H               ;if bit is range 1h-9h
        Ascii3Done:              ;ascii fixed
        MOV AH,2                 ;printing bit
        INT 21H 
        
        MOV AX,00                ;resetting AX
        MOV AL,CL                ;now print remaining 2 bits of HEX sum
        DIV base                 ;hex num /16 to get remainder
    
        MOV DL,AL                ;storing the quotient in DL
        MOV DH,AH                ;storing remainder in DH
        
        CMP DL ,divisor10        ;check if bit is in range A-F
        JGE GetAscii1            ;if bit >=10h fix ascii accordingly
        ADD DL,30H               ;if bit is range 1h-9h
        Ascii1Done:              ;ascii fixed
        MOV AH,2                 ;printing bit
        INT 21H                  ;interrupt
        
        MOV DL,DH                ;moving the remainder in DL to print
        
        CMP DL ,divisor10        ;check if bit is in range A-F
        JGE GetAscii2            ;if bit >=10h fix ascii accordingly
        ADD DL,30H               ;if bit is range 1h-9h
        Ascii2Done:              ;ascii fixed
        MOV AH,2                 ;printing bit
        INT 21H                  ;interrupt
        
        MOV AH, 2                ;set cursor position
        MOV DL, 0DH              ;carriage return
        INT 21H                  ;interrupt             
        MOV DL, 0AH              ;line feed
        INT 21H                  ;interrupt
              
        JMP  PrintDec            ;3 HEX bits printing completed
            
            
            
        GetAscii1:
        ADD DL,37H               ;example:HEX A >> B+37=HEX 41=ascii A
        JMP Ascii1Done:      
        
        GetAscii2:
        ADD DL,37H               ;example:HEX C >> C+37=HEX 43=ascii C
        JMP Ascii2Done:
            
        GetAscii3:
        ADD DL,37H               ;example:HEX F >> F+37=HEX 46=ascii F
        JMP Ascii3Done:
                
        PrintDec:
        
        LEA DX,outputPromptDec   ;output statement
        MOV AH,9                 ;string output
        INT 21H                  ;interrupt
        
        PrintSum:                ;sum is stored in CX
        MOV DX,CX                ;DX=sum
        
        MOV AX,DX                ;AX=4 DEC bits of OddSum
        DIV divisor10            ;AX/10
        MOV DX,AX                ;storing the rem and quotient
        MOV AL,00                ;we just need the rem so reset AH
        PUSH AX                  ;storing the 1st DEC bit
        
        MOV DH,00                ;reset DH
        
        MOV AX,DX                ;AX=3 DEC bits of OddSum
        DIV divisor10            ;AX/10
        MOV DX,AX                ;storing the rem and quotient
        MOV AL,00                ;we just need the rem so reset AH
        PUSH AX                  ;storing the 2nd DEC bit
        
        MOV DH,00                ;reset DH
        
        MOV AX,DX                ;AX=2 DEC bits of OddSum
        DIV divisor10            ;AX/10
        MOV DX,AX                ;storing the rem and quotient
        MOV AL,00                ;we just need the rem so reset AH
        PUSH AX                  ;storing the 3rd DEC bit
        
        MOV DH,00                ;reset DH
        
        MOV AX,DX                ;AX=1 DEC bit  of OddSum
        DIV divisor10            ;AX/10
        MOV DX,AX                ;storing the rem and quotient
        MOV AL,00                ;we just need the rem so reset AH
        PUSH AX                  ;storing the 4th DEC bit
        
        POP AX                   ;popping 4th DEC bit
        MOV DL,AH                ;DL=4th bit
        ADD DL,30H               ;getting proper Ascii value
        MOV AH,2                 ;printing char
        INT 21H                  ;interrupt
        
        POP AX                   ;popping 3rd DEC bit
        MOV DL,AH                ;DL=3rd bit
        ADD DL,30H               ;getting proper Ascii value
        MOV AH,2                 ;printing char
        INT 21H                  ;interrupt
        
        POP AX                   ;popping 2nd DEC bit
        MOV DL,AH                ;DL=2nd bit
        ADD DL,30H               ;getting proper Ascii value
        MOV AH,2                 ;printing char
        INT 21H                  ;interrupt
        
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
        
    MAIN ENDP
    END MAIN