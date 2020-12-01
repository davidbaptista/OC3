	.data
A:	.word 1,2,3,4,5
	.word 6,7,8,9,10
	.word 11,12,13,14,15
	.word 16
B:	.word 1,2,3,4
C:	.word 0,0,0,0

	.code
	daddi $1, $zero, 0	    ; i = 0
	daddi $2, $zero, A

	daddi $5, $zero, 4    ; value of N
	daddi $21, $0, 8    ; MIPS64 does not provide an instruction to multiply with constants

loop:  
	; iteracao 1

	lw $10, 0($2)		; $10 = A[i]
	daddi $3, $0, B     ; $3 = indice de B[0]
	daddi $2, $2, 8     ; $2 = next indice de A[i]

	dmul $6, $1, $21    ; (i / M)*sizeof(int64)

	lw $11, 0($3)		; $11 = B[0]
	daddi $1, $1, 1		; $1 = indice_de_C++
	dmul $12, $10, $11	; $12 = A[i] * B[0]

	daddi $4, $6, C  	; $4 = indice de C[i / M]

	lw $13, 0($4)		; $13 = 0
	dadd $13, $13, $12	; $13 += $12


	; iteracao 2
	lw $10, 0($2)		; $10 = A[i]
	dadd $3, $3, $21    ; $3 = indice de B[1]

	lw $11, 0($3)		; $11 = B[1]
	daddi $2, $2, 8    	; $2 = next indice de A[i]
	dmul $12, $10, $11  ; $12 = A[i] * B[1]

	dadd $13, $13, $12	; $13 += $12

	; iteracao 3
	lw $10, 0($2)		; accesso a A[i]
	dadd $3, $3, $21   	; indice de B[2]

	lw $11, 0($3)		; acesso a B[2]
	daddi $2, $2, 8     ; get next indice de A[i]

	dmul $12, $10, $11  ; $12 = A[i] * B[2]

	dadd $13, $13, $12  ; $13 += $12

	; iteracao 4
	lw $10, 0($2)		; accesso a A[i]
	dadd $3, $3, $21    ; indice de B[3]

	lw $11, 0($3)		; acesso a B[3]
	daddi $2, $2, 8     ; get next indice de A[i]

	dmul $12, $10, $11  ; $12 = A[i] * B[3]

	dadd $13, $13, $12  ; $13 += $12
	sw $13, 0($4)

	bne $1,$5, loop
	halt
