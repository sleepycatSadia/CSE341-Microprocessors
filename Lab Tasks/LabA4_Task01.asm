;Task 01
;Write a program which takes in two 16 bit numbers and
; finds the total sum of all the numbers that are divisible
; by 5 within that range. 


.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE   
    inputPromptA  DB "Enter A in 4 bits HEX Format (0000-00FF): $" 
    inputPromptB  DB "Enter B in 4 bits HEX Format (0000-00FF): $"   
    inputPromptX  DB "Enter two numbers A & B such that A<=B $"   
    
    outputPromptA DB "Total sum of all the numbers that are divisible $"  
    outputPromptB DB "by 5 within that range in Decimal is : $"   
       

    base DB 16   
    num DB 5     
    rem db 0 
    
    numA DW ?
    numB DW ?
    
    count DB 0
            
    min_idx dw 0
    temp dw 0    
    divisor16 DB 16  
    num10 DB 10       
    NumArr DW 2 DUP(?) 
    
    divisor10    DB 10 
    divisor10W   DW 10 
    
    bit4 DB ?
    bit3 DB ?
    bit2 DB ?
          
.CODE
    MAIN PROC
  
        MOV AX, @DATA
        MOV DS, AX
                                             
    ; YOUR CODE STARTS HERE     
    
    ;----------------------------------------------
    ;Printing Input Prompt Lines One by One
    ;----------------------------------------------
    
    LEA DX,inputPromptX    ;Input Prompt address loaded
    MOV AH,9               ;printing the prompt
    INT 21H                ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt
        
    LEA DX,inputPromptA    ;Input Prompt address loaded
    MOV AH,9               ;printing the prompt
    INT 21H                ;interrupt   

      
    MOV CX,2              ;arr size=5
    LEA SI,NumArr         ;SI=idx=0
                                      
    ;if the num is 4EF2
    ;1st bit 2
    ;2nd bit F
    ;3rd bit E
    ;4th bit 4
    
    InputArray:                                
     
    MOV DX,00             ;num will be stored in DX

    MOV AH, 1             ;taking input of 4th bit 
    INT 21H               ;interrupt 
    MOV AH,00             ;resetting AH
    SUB AL,30H            ;for ease of calculation
    PUSH AX               ;4th bit pushed in stack
    
    MOV AH, 1             ;taking input of 3rd bit 
    INT 21H               ;interrupt 
    MOV AH,00             ;resetting AH
    SUB AL,30H            ;for ease of calculation
    PUSH AX               ;3rd bit pushed in stack
                                                    
    MOV AH, 1             ;taking input of 2nd bit 
    INT 21H               ;interrupt 
    MOV AH,00             ;resetting AH
    SUB AL,30H            ;for ease of calculation
    PUSH AX               ;2nd bit pushed in stack
      
    MOV AH, 1             ;taking input of 1st bit 
    INT 21H               ;interrupt 
    MOV AH,00             ;resetting AH
    SUB AL,30H            ;for ease of calculation
    PUSH AX               ;1st bit pushed in stack
                                                    
                                                    
    POP AX                ;1st bit that was entered is popped 
                          ;AX=1st bit *16^0 =1st bit
    CMP AL,11H            ;to check if 1st bit is in range 0h-9h
    JGE CHANGE1           ;if 1st bit is originally in range A-F      
                          ;change the popped bit to HEX
                          ;example : popped 11>> A,popped 14>>D     
                          
                          ;AX=1st bit           =>AX=1st bit *16^0
                            
    DONE1:                ;back here when change is done
    ADD DX,AX             ;add the 1st bit in DX    
    
            
      

    POP AX                ;2nd bit that was entered is popped 
    CMP AL,11H            ;to check if 2nd bit is in range 0h-9h
    JGE CHANGE2           ;if 2nd bit is originally in range A-F
                          ;change the popped bit to HEX
                          ;example : popped 11>> A,popped 14>>D 
                          
                          ;AX=2nd bit           =>AX=2nd bit *16^0
    MUL base              ;AX=2nd bit *16       =>AX=2nd bit *16^1

    DONE2:                ;back here when change is done
    ADD DX,AX             ;add the 2nd bit in DX     
    
    
    
    
    
    
    POP AX                ;3rd bit that was entered is popped 
    CMP AX,11H            ;to check if 3rd bit is in range 0h-9h
    JGE CHANGE3           ;if 3rd bit is originally in range A-F
                          ;change the popped bit to HEX
                          ;example : popped 11>> A,popped 14>>D 
                          
                          ;AX=3rd bit           =>AX=3rd bit *16^0
    MUL base              ;AX=3rd bit *16       =>AX=3rd bit *16^1
    MUL base              ;AX=3rd bit *16*16    =>AX=3rd bit *16^2   
    
    DONE3:                ;back here when change is done
    ADD DX,AX             ;add the 3rd bit in DX 

    
    
    POP AX                ;4th bit that was entered is popped                       
    CMP AX,11H            ;to check if 2nd bit is in range 0h-9h
    JGE CHANGE4           ;if 4th bit is originally in range A-F
                          ;change the popped bit to HEX  
                          ;example : popped 11>> A,popped 14>>D 
                          
                          ;AX=4th bit           =>AX=4th bit *16^0
    MUL base              ;AX=4th bit *16       =>AX=4th bit *16^1
    MUL base              ;AX=4th bit *16*16    =>AX=4th bit *16^2
    MUL base              ;AX=4th bit *16*16*16 =>AX=4th bit *16^3      
    
    DONE4:                ;back here when change is done
    ADD DX,AX             ;add the 4th bit in DX 
    
    
    CMP count,00H
    JE MoveToA            ;input A
    JMP MoveToB           ;input B
    
    MoveToA:
    MOV numA,DX    
    MOV count,01H 
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt   

    LEA DX,inputPromptB    ;Input Prompt address loaded
    MOV AH,9               ;printing the prompt
    INT 21H                ;interrupt  
    
    JMP AddingDone
    
    
    MoveToB:
    MOV numB,DX  
    JMP AddingDone
    
    AddingDone:  
    INC SI                ;idx++
   
    LOOP InputArray       ;if idx<2
    JMP  DivBy5Sum        ;now go to calc divBy5sum
    
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
                                      
                                      
        
    CHANGE3:     
    CMP AX,11H
    JE MakeA3
    CMP AX,12H
    JE MakeB3
    CMP AX,13H
    JE MakeC3
    CMP AX,14H
    JE MakeD3
    CMP AX,15H
    JE MakeE3
    CMP AX,16H
    JE MakeF3

    MakeA3:
    MOV AX,2560           ;11H>>A00
    JMP DONE3 
    MakeB3:
    MOV AX,2816           ;12H>>B00
    JMP DONE3
    MakeC3:
    MOV AX,3072           ;13H>>C00
    JMP DONE3
    MakeD3:
    MOV AX,3328           ;14H>>D00
    JMP DONE3 
    MakeE3:
    MOV AX,3584           ;15H>>E00
    JMP DONE3            
    MakeF3:
    MOV AX,3840           ;16H>>F00
    JMP DONE3                          
    
    
    
    CHANGE4:     
    CMP AX,11H
    JE MakeA4
    CMP AX,12H
    JE MakeB4
    CMP AX,13H
    JE MakeC4
    CMP AX,14H
    JE MakeD4
    CMP AX,15H
    JE MakeE4
    CMP AX,16H
    JE MakeF4

    MakeA4:
    MOV AX,40960          ;11H>>A000
    JMP DONE4 
    MakeB4:
    MOV AX,45056          ;12H>>B000
    JMP DONE4
    MakeC4:
    MOV AX,49152          ;13H>>C000
    JMP DONE4
    MakeD4:
    MOV AX,53248          ;14H>>D000
    JMP DONE4 
    MakeE4:
    MOV AX,57344          ;15H>>E000
    JMP DONE4            
    MakeF4:
    MOV AX,61440          ;16H>>F000
    JMP DONE4
    DivBy5Sum:  
    
        ;----------------------------------------------
        ;python code
        ;----------------------------------------------
        ;a=num1
        ;b=num2
        ;sum=0
        ;while(a<=b):
        ;  if(a%5==0):
        ;    sum=sum+a
        ;  a=a+1 
        ;print(sum)
        ;----------------------------------------------
        
        ;MOV AX,005AH          ;AX=a=90D
        ;MOV BX,0064H          ;BX=b=100D
                               ;Sum if div by 5 =90+95+100=285         
        
        MOV AX,numA           ;AX=a=num1
        MOV BX,numB           ;BX=b=num2
        MOV DX,0000H          ;DX=sum=0
        
        
        LOOP: 
        CMP AX,BX             ;check if a<=b
        JG PRINTtheSUM            ;if a>b loop break we need to print the sum
        
        MOV CX,AX             ;temp=a
        DIV num               ;a/5
        CMP AH,rem            ;remainder == 0 check
        JE SUM                ;if equal we have to add the number in sum
        PART:                 
        ADD CX,1              ;temp=temp+1=>a=a+1
        MOV AX,CX             ;a=temp
        
        JMP LOOP              ;if a<=b continue Loop
        
                                     
        SUM:
        ADD DX,CX             ;DX=DX+CX=>sum=sum+temp>sum=sum+a
        JMP PART              ;back to loop

        PRINTtheSUM: 

    ;--------------------------------------
    ;Printing the sum bit by bit     
    ;We considered the sum is in 4 dec bits
    ;First we will split all 4 bits
    ;then we print them
    ;--------------------------------------    
    ;---------------------------------------------------    
    ;We will extract the 1st bit 
    ;by manullay dividing the sum by 10
    ;and then get the remainder 
    ;the remainder will be the 1st bit
    ;We used manual division becuase
    ;if the sum is big,then after dividing by 10,
    ;the quotient we will get will be more tha FF.   
    ;example : 2567/10 Q=256>FF(255d)  
    ;
    ;If the quotient is more than FF, then it
    ;can't be stored in AL(default loaction for quotient) 
    ;becuase AL=8 bit register so max value that can be
    ;stored here without causing any overflow is 255d /FF
    ;
    ;So while manualy dividing we will store the 
    ;quotient  in BX -will be used to extract next(2nd) bit
    ;remainder in AX -will be pushed in STACK     
    ;
    ;While doing repetitive subtraction
    ;the subtraction result will be in AX
    ;---------------------------------------------------
    MOV CX,DX                
    
  
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt
        
    LEA DX,outputPromptA   ;Input Prompt address loaded
    MOV AH,9               ;printing the prompt
    INT 21H                ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt
        
    LEA DX,outputPromptB   ;Input Prompt address loaded
    MOV AH,9               ;printing the prompt
    INT 21H   
    
    MOV DX,CX                ;DX=sum
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
    ;if bit4=0 we dont print it
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
    ;if bit3,bit4 both =0,we dont print bit3 
    ;else we print it   
    ;------------------------------------------ 
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
    ;if bit2=bit3=bit4=0 we dont print bit2
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
    
    EXIT:    
          
    ; YOUR CODE ENDS HERE
    
    MOV AX, 4C00H
    INT 21H
    
    MAIN ENDP
    END MAIN