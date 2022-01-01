;Final Porject Task Name : TWICE
;Take an array of length 10. 
;Now populate the array by taking inputs from the user.
;The inputs should range from 0 to 5.
;The user should give exactly 5 odd and 5 even numbers.
;Now find the sum of every odd number to the power of every even number of the same order.
;Lastly, print the sum. 

;Sample Input:
;5 2 0 1 4 3 3 4 2 1

;Sample Output:
;Sum is 189

;Explanation:
;We will follow the order in which the input was provided

;1st even number = 2
;2nd even number = 0
;3rd even number = 4
;4th even number = 4
;5th even number  = 2

;1st odd number = 5
;2nd odd number = 1
;3rd odd number = 3
;4th odd number = 3
;5th odd number = 1

;So the sum will be: 
;5^2 + 1^0 + 3^4 + 3^4 + 1^2 = 25 + 1 + 81 + 81 + 1 = 189

.STACK 100H  
.DATA
    ; DEFINE YOUR VARIABLES HERE         
    
    inputPromptLine1  DB "Enter exactly 5 odd and 5 even number in any order .$"     
    inputPromptLine2  DB "Make sure numbers are between 0-5 .$"     
    inputPromptLine3  DB "Which means you can only enter 0/ 1/ 2/ 3/ 4/ 5 .$"   
    
    outputPrompt1_1 DB  "Sum of every odd number to the power of every even number $"    
    outputPrompt1_2 DB  "of the same order is being calculated.Please wait a bit. $"   
    outputPrompt2   DB  "Sum is $"    
    
    space DB " $"  
    NumArr DB 10 DUP(?)         
      
    outputPrompt DB  "Sum $"
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
    
        
    ;-----------------------------------------------------
    ;Java Algorithm we will follow
    ;-----------------------------------------------------
    ;int arr[]=new int[10];
    ;for(int i=0;i<arr.length;i++)
    ;    arr[i]=sc.nextInt(); 
    ;    if(arr[i]%2==0); 
    ;        push(arr[i]);
    ;int sum=0; 
    ;int num=0;
    ;int power=0;
    ;for(int i=arr.length-1;i>=0;i--)
    ;    num=1; 
    ;    if(arr[i]%2==1) 
    ;        power=pop();
    ;        for(int j=1;j<=power;j++)
    ;           num*=arr[i]
    ;        sum+= num;
    ;print(sum)   
    
    
    ;----------------------------------------------
    ;Printing Input Prompt Lines One by One
    ;----------------------------------------------
    
    LEA DX,inputPromptLine1;Input Prompt address loaded
    MOV AH,9               ;printing the prompt
    INT 21H                ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt
        
    LEA DX,inputPromptLine2;Input Prompt address loaded
    MOV AH,9               ;printing the prompt
    INT 21H                ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt   
    
    LEA DX,inputPromptLine3;Input Prompt address loaded
    MOV AH,9               ;printing the prompt
    INT 21H                ;interrupt   
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt 
    
    ;---------------------------------------------------
    ;Populate the array by taking inputs from the user.  
    ;If an even number is found,we keep it in stack
    ;in order to keep the even numbers separate
    ;---------------------------------------------------
               
    
    MOV CX,10             ;arr size=10
    LEA SI,NumArr         ;SI=idx=0
    
    InputArray:                                

    MOV AH, 1             ;taking input of number
    INT 21H               ;interrupt         
    MOV AH,00H            ;resettig AH    
    SUB AL,30H            ;getting original number 33 >> 3
    MOV [SI],AL           ;arr[idx]=num
          
          
    MOV BL,02H            ;divisor = 2
    DIV BL                ;num/div
                          
    MOV BH,00H            ;for being EVEN, remainder=00 
                          
                          ;after dividing the num by 2
                          ;AH=remainder
    CMP AH,BH             ;check if rem equals 00
    JE IfEvenPushToStack  ;if the num is even put it in stack
    EvenNumPushed:
     
    LEA DX,space          ;printing a space
    MOV AH,9              ;printing the space
    INT 21H               ;interrupt
    
    INC SI                ;idx++
   
    LOOP InputArray       ;if idx<10
    JMP  CalculateSum     ;else if idx>=10
                          ;loop break 
                          ;now go to calculate SUM
    
    
    
    IfEvenPushToStack:    ;if NumArr[idx] is EVEN
    PUSH [SI]             ;push  NumArr[idx] in stack 
    JMP EvenNumPushed     ;even number stored for further use
    

    ;-----------------------------------------------------
    ;Printing Wait and Output Statements
    ;-----------------------------------------------------
    
    CalculateSum:  
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt 
    
    LEA DX,outputPrompt1_1;output statement
    MOV AH,9              ;string output
    INT 21H               ;interrupt
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt 
    
    LEA DX,outputPrompt1_2;output statement
    MOV AH,9              ;string output
    INT 21H               ;interrupt       
    
    MOV AH, 2             ;set cursor position.
    MOV DL, 0DH           ;carriage return
    INT 21H               ;interrupt             
    MOV DL, 0AH           ;line feed
    INT 21H               ;interrupt 
    
    LEA DX,outputPrompt2  ;output statement
    MOV AH,9              ;string output
    INT 21H               ;interrupt      
    
    ;-----------------------------------------------------
    ;Here,Find the total sum of every odd number to  
    ;the power of every even number of the same order.     
    ;For this,we reverse iterate the 10 length array
    ;If found odd number,
    ;we pop the corresponding even number from stack
    ;We used Reverse iteration to maintain order
    ;Example: First we will get last odd number
    ;the we will pop a num which is last even number
    ;then we calculate odd^even
    ;then we add the result into total sum
    ;-----------------------------------------------------
    
    MOV CX,00H            ;CX=total sum
    
    MOV SI,9              ;SI=idx=NumArr.length-1=10-1=9
                          ;because we will reverse iterate      
    
    Arrays:               ;loop used for reverse iteration
    
    CMP SI,0              ;condition for loop break
                          ;compare idx value and zero
    
    JL  PrintDec          ;if idx<0 break loop & print sum
    
    
    MOV AX,00H            ;reset AX
    MOV AL,NumArr[SI]     ;AX=NumArr[idx]
     
    MOV BL,02H            ;divisor = 2
    DIV BL                ;num/div
                          
                          
    MOV BH,01H            ;for being ODD, remainder=01  
                          
                          ;after dividing the num by 2
                          ;AH=remainder
    CMP AH,BH             ;check if rem equals 01
    
    
    JE IfOddEditTotalSum  ;if NumArr[idx] is ODD
                          ;then we need to pop an even num from stack 
                          ;to do odd^even
    
    SumEditDone:          ;total sum value was updated/not updated
                          ;if an odd num was/wasn't found during 
                          ;reverse iteration
     
    
    DEC SI                ;idx-- as we doing reverse iteration
    
    
    JMP Arrays            ;if idx>=0 ,then 
                          ;continue loop of reverse iteration
    
    IfOddEditTotalSum:    
    
    MOV AX,00H            ;reset AX
    MOV BX,00H            ;reset BX
    MOV DX,00H            ;reset DX
    
                          ;the stack has just even numbers
                          ;we will pop one
                          
    MOV AX,01H            ;AX=currentSum=1
    MOV BL,NumArr[SI]     ;BL=NumArr[idx]=odd number   
    POP DX                ;DX=power=even number     
    MOV BH,01             ;BH=count=1                 
    
    OddToThePowerEvenLoop:
    CMP BH,DL                ;compare counter & power value
    JG CurrentSumCalculated  ;if (count> power) break
    
    MUL BL                   ;currentSum=currentSum*NumArr[[idx]
    INC BH                   ;count++
    
    
    JMP OddToThePowerEvenLoop;if (count<=power) continue
    
    
    
    CurrentSumCalculated:  ;current sum calculated,now
    ADD CX,AX              ;total sum+=current sum
                           
                           ;updating the total sum done
    JMP SumEditDone        ;we move on to next odd-even pair
                           ;if there is more             
        
    
    ;--------------------------------------
    ;Printing the sum bit by bit     
    ;We considered the sum is in 4 dec bits
    ;First we will split all 4 bits
    ;then we print them
    ;--------------------------------------
    
    PrintDec:
    
    MOV AX,00                ;reset AX
    MOV BX,00                ;reset BX
    MOV DX,00                ;reset DX 
    
    ;--------------
    ;splitting bits
    ;--------------
    
    PrintSum:                ;sum is stored in CX
           
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
    
    MAIN ENDP    5
    END MAIN             
