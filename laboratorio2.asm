# Pedro Ernesto Duarte Pilchowski - RA: 156.331
# Laboratorio 2 - AOC
# Professor Fabio Cappabianco

.data
	promptPrimJog: .asciiz "Nome do primeiro jogador: "
	promptSegJog: .asciiz "Nome do segundo jogador: "
	nomePrimJog: .space 50
	nomeSegJog: .space 50
	msgVitoria: .asciiz "Vencedor: "

.text
main:
# ----------------------------------------------
# Pergunta e le o nome dos dois jogadores
	li $v0, 4
	la $a0, promptPrimJog
	syscall
	
	li $v0, 8
	la $a0, nomePrimJog
	li $a1, 50
	syscall

	li $v0, 4
	la $a0, promptSegJog
	syscall
	
	li $v0, 8
	la $a0, nomeSegJog
	li $a1, 50
	syscall

	
# ----------------------------------------------
# Main

MainLoop:
	la $a1, nomePrimJog
	jal InsereNum
	jal VerificaVitoria
	
	la $a1, nomeSegJog
	jal InsereNum
	jal VerificaVitoria
	
	j MainLoop								# Enquanto nao houver vitoria, passa a rodada para o proximo jogador

# ----------------------------------------------
# Verifica se o numero inserido faz o jogador vencer
VerificaVitoria:
	bne $t3, 100, NaoVenceu
	
	li $v0, 4
	la $a0, msgVitoria
	syscall
	
	move $a0, $a1
	jal ImprimeNome
	j Termina
	
	NaoVenceu:
	jr $ra

# ----------------------------------------------

InsereNum:
	move $t6, $ra							# Salva o endereco de $ra
											# $t3 ira conter o numero anterior ao inserido
	LoopInsereNum:
	
	jal Imprime
	li $v0, 5								# Le o inteiro
	syscall
	
	bgt $v0, 100, LoopInsereNum				# Rejeita numeros maiores que 100
	
	sub $v0, $v0, $t3
	ble $v0, 0, LoopInsereNum				# Valida se esta entre 0 e 10
	bgt $v0, 10, LoopInsereNum
	
	move $ra, $t6
	add $t3, $t3, $v0
	jr $ra

# ----------------------------------------------
# Imprime o numero atual e o nome

Imprime:
	move $t7, $ra							# Salva o endereco de $jr
	
	li $v0, 11
	li $a0, 40 								# Imprime '('
	syscall
	
	li $v0, 1
	move $a0, $t3 							# Move o numero atual para $a0 para ser impresso
	syscall
			
	li $v0, 11
	li $a0, 41 								# Imprime ')'
	syscall
	
	li $a0, 32 								# Imprime um espaco
	syscall
	
	move $a0, $a1
	jal ImprimeNome							# Imprime o nome
	
	li $v0, 11
	li $a0, 58 								# Imprime ':'
	syscall
	
	li $a0, 32	 							# Imprime um espaco
	syscall

	move $ra, $t7
	jr $ra

# ----------------------------------------------

ImprimeNome:
	li $t0, 10								# Carrega o codigo de newline em $t0 para comparar
	move $a2, $a0
	li $t1, 0								# Inicia o contador
	li $v0, 11								# Codigo para imprimir caractere
Loop:
	lb $a0, 0($a2)							# Carrega o caractere atual em $a1
	beq $a0, $t0, Saida
	syscall
	
	addi $a2, $a2, 1						# Passa para a proxima posicao da string de antemao
	addi $t1, $t1, 1						# Incrementa o contador para futura comparacao
	
	beq $t1, 12, Saida						# Se o nome atingir o limite de caracteres, para de imprimir
	j Loop
	
Saida:
	jr $ra

# ----------------------------------------------

Termina:
	li $v0, 10
	syscall
