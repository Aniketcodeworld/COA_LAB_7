ORG 100h

_start:
; Prompt for the first digit
MOV DX, OFFSET msg_input1
MOV AH, 09h
INT 21h

; Get the first digit from the user
MOV AH, 01h
INT 21h
CMP AL, '0' ; Check if input is less than '0'

JL InvalidInput ; Jump to error if input is not valid
CMP AL, '9' ; Check if input is greater than '9'
JG InvalidInput ; Jump to error if input is not valid
SUB AL, '0' ; Convert ASCII to number
MOV BL, AL ; Store first digit in BL

; Prompt for the second digit
MOV DX, OFFSET msg_input2
MOV AH, 09h
INT 21h

; Get the second digit from the user
MOV AH, 01h
INT 21h
CMP AL, '0' ; Check if input is less than '0'
JL InvalidInput ; Jump to error if input is not valid
CMP AL, '9' ; Check if input is greater than '9'
JG InvalidInput ; Jump to error if input is not valid
SUB AL, '0' ; Convert ASCII to number
MOV BH, AL ; Store second digit in BH

; Print the result message and move to next line
MOV DX, OFFSET msg_result
MOV AH, 09h
INT 21h

; Subtract the two digits (BL - BH)
SUB BL, BH

; Check if the result is negative
JS NegativeResult

; Convert the result to ASCII and display
ADD BL, '0'
MOV DL, BL
MOV AH, 02h
INT 21h
JMP EndProgram

NegativeResult:
; If result is negative, print '-' first
MOV DL, '-'
MOV AH, 02h
INT 21h

; Convert the absolute value of result to ASCII and display
NEG BL
ADD BL, '0'
MOV DL, BL
MOV AH, 02h
INT 21h
JMP EndProgram

InvalidInput:
; Display error message
MOV DX, OFFSET msg_error
MOV AH, 09h
INT 21h
JMP EndProgram

EndProgram:
; Terminate the program
MOV AH, 4Ch
INT 21h

msg_input1 DB 'Enter first digit: $' ; Input message for the first digit
msg_input2 DB 0Dh, 0Ah, 'Enter second digit: $' ; Input message for the second digit
msg_result DB 0Dh, 0Ah, 'The result is: $' ; Output message (newline before result)
msg_error DB 0Dh, 0Ah, 'Error: Invalid input! $' ; Error message

END