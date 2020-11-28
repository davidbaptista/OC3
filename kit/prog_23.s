      .data
A:	  .word 1,2,3,4,5
	    .word 6,7,8,9,10
	    .word 11,12,13,14,15
	    .word 16
B:	  .word 1,2,3,4
C:	  .word 0,0,0,0

	    .code
	    daddi $1, $zero, 0	    ; i = 0
      daddi $2, $zero, A

      daddi $5, $zero, 16    ; value of N
      daddi $21, $0, 8    ; MIPS64 does not provide an instruction to multiply with constants

loop:  
      andi $6, $1, 3      ; value of i % M
      dmul $6, $6, $21    ; (i % M)*sizeof(int64)
      lw $10, 0($2)
	  daddi $2, $2, 8     ; get next A[i]
      daddi $3, $6, B     ; B[i % M]

      dsra $6, $1, 2       ; i / M
      dmul $6, $6, $21    ; (i / M)*sizeof(int64)
      lw $11, 0($3)
      daddi $1,$1,1
      dmul $12, $10, $11
      daddi $4, $6, C  ; C[i / M]
	  
      
      lw $13, 0($4)
      dadd $12, $12, $13

      sw $12, 0($4)

      bne $1,$5, loop
      

      halt
