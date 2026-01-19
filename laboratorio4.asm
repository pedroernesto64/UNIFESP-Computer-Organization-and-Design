# Pedro Ernesto Duarte Pilchowski - RA: 156.331
# Laboratorio 4 - AOC
# Professor Fabio Cappabianco

.data
	quina: .asciiz "quina de "
	quadra: .asciiz "quadra de "
	falhou: .asciiz "falhou"

.text
main:

jal Le_os_numeros

# Realiza cada um dos testes individualmente
# Se um dos testes for bem-sucedido, finaliza o programa

jal Quina
jal Quadra

li $v0, 4
la $a0, falhou
syscall
j Exit

######################################################################################

Quina:
	# Salva o endereco dos testes
	move $t0, $ra
	
	bne $s0, $s1, Retorna_aos_testes
	bne $s1, $s2, Retorna_aos_testes
	bne $s2, $s3, Retorna_aos_testes
	bne $s3, $s4, Retorna_aos_testes
	
	# Todos os numeros sao iguais. Imprime mensagem
	li $v0, 4
	la $a0, quina
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	j Exit

######################################################################################

Quadra:
	# Salva o endereco dos testes
	move $t0, $ra
	
	# $t1 eh o contador de "numeros que apontaram divergencia"
	# Se mais que um numero apontar divergencia, nao eh uma quadra
	# $t3 eh o numero a ser comparado com os outros
	move $t3, $s0
	jal ComparaQuadra
	
	move $t3, $s1
	jal ComparaQuadra
	beq $t1, 2, Retorna_aos_testes
	
	move $t3, $s2
	jal ComparaQuadra
	beq $t1, 2, Retorna_aos_testes
	
	move $t3, $s3
	jal ComparaQuadra
	beq $t1, 2, Retorna_aos_testes
	
	move $t3, $s4
	jal ComparaQuadra
	beq $t1, 2, Retorna_aos_testes
	
	# Imprime a quadra
	li $v0, 4
	la $a0, quadra
	syscall
	
	li $v0, 1
	# Imprime $s0 se ele não for o numero divergente
	beq $t4, $s0, ImprimeOutro
	move $a0, $s0
	syscall
	j Exit
	
	# Imprime $s1, pois aqui eh certeza que ele nao eh o divergente
	ImprimeOutro:
	move $a0, $s1
	syscall
	j Exit

ComparaQuadra:
	beq $t3 $s0 NaoAdd1
	addi $t2, $t2, 1
	NaoAdd1:
	
	beq $t3 $s1 NaoAdd2
	addi $t2, $t2, 1
	beq $t2, 2, ExitCompara
	NaoAdd2:
	
	beq $t3 $s2 NaoAdd3
	addi $t2, $t2, 1
	beq $t2, 2, ExitCompara
	NaoAdd3:

	beq $t3 $s3 NaoAdd4
	addi $t2, $t2, 1
	beq $t2, 2, ExitCompara
	NaoAdd4:
	
	beq $t3 $s4 NaoAdd5
	addi $t2, $t2, 1
	beq $t2, 2, ExitCompara
	NaoAdd5:
		
	ExitCompara:
	# Guarda em $t4 o numero divergente
	move $t4, $t3
	
	# Incrementa o contador de numeros divergentes
	addi $t1, $t1, 1
	
	# Volta para a comparacao
	jr $ra

######################################################################################

Sequencia:

######################################################################################

Trinca_e_par:

######################################################################################

Trinca:

######################################################################################

Dois_pares:

######################################################################################

Par:

######################################################################################

Le_os_numeros:
	# Le 9 caracteres (5 numeros e 4 espacos)
	# Primeiro numero
	li $v0, 12
	syscall
	move $s0, $v0
	subi $s0, $s0, 48
	
	# Espaco em branco
	li $v0, 12
	syscall
	
	# Segundo numero
	li $v0, 12
	syscall
	move $s1, $v0
	subi $s1, $s1, 48
	
	# Espaco em branco
	li $v0, 12
	syscall
	
	# Terceiro numero
	li $v0, 12
	syscall
	move $s2, $v0
	subi $s2, $s2, 48
	
	# Espaco em branco
	li $v0, 12
	syscall
	
	# Quarto numero
	li $v0, 12
	syscall
	move $s3, $v0
	subi $s3, $s3, 48
	
	# Espaco em branco
	li $v0, 12
	syscall
	
	# Quinto numero
	li $v0, 12
	syscall
	move $s4, $v0
	subi $s4, $s4, 48
	
	# Imprime quebra de linha
	li $v0, 11
	li $a0, 10
	syscall
	
	jr $ra

######################################################################################

Retorna_jal:
	jr $ra

######################################################################################

Retorna_aos_testes:
	jr $t0

######################################################################################

Exit:
	li $v0, 10
	syscall
