# Pedro Ernesto Duarte Pilchowski - RA: 156.331
# Laboratorio 3 - AOC
# Professor Fabio Cappabianco

.data
	dezmil: .float 10000.0
	um: .float 1.0
.text
main:

# $f1 - i
# $f2 - j
# $f3 - n+1
# $f4 - k

# Le o primeiro numero
li $v0, 6
syscall
mov.s $f1, $f0

# Le o segundo numero
syscall
mov.s $f2, $f0

# Multiplica os numeros lidos por mil
l.s $f5, dezmil
mul.s $f1, $f1, $f5
mul.s $f2, $f2, $f5

# Le o divisor
li $v0, 5
syscall
addi $v0, $v0, 1 # Adiciona 1 para ficar (n+1)
mtc1 $v0, $f3
cvt.s.w $f3, $f3

l.s $f5, um
#-------------------
Loop:
	# Verifica se terminaram as interpolacoes
	c.lt.s $f3, $f4
	bc1t Termina
	
	#Pk = i*(n + 1 - k) + j*k
	#	---------------
	#	     n+1

	#Onde K é a iteracao que vai de 0 a n+1
	
	# Operacoes para obter o valor da interpolacao
	sub.s $f6, $f3, $f4
	mul.s $f6, $f1, $f6
	mul.s $f7, $f2, $f4
	add.s $f6, $f6, $f7
	div.s $f6, $f6, $f3

	# Converte o resultado obtido para int
	cvt.w.s $f6, $f6
	mfc1 $t0, $f6
	
	# Separa a parte decimal da inteira
	li $t1, 10000
	div $t0, $t1
	mflo $t0 # Parte inteira
	mfhi $t1 # Parte decimal
	
	# Regras de arredondamento
	li $t3, 10
	div $t1, $t3 # Destaca o ultimo digito para analise
	mfhi $t3
	ble $t3, 5, NaoArredonda
	addi $t1, $t1, 10 # Arredonda se o ultimo digito for >5
	NaoArredonda:
	div $t1, $t1, 10 # Elimina o terceiro digito
	
	# Imprime a parte inteira
	li $v0, 1
	move $a0, $t0
	syscall
	
	# Imprime ponto
	li $v0, 11
	li $a0, 46
	syscall
	
	# Imprime a parte decimal, com condicoes
	# Parte decimal igual a zero
	bgtz $t1, NaoImprimeDoisZeros
	li $v0, 1
	li $a0, 0
	syscall
	syscall
	syscall
	j ExitPrint
	NaoImprimeDoisZeros:
	
	# Parte decimal eh maior que zero mas menor que 10
	bge $t1, 10, NaoImprimeZeroAEsquerda
	li $v0, 1
	li $a0, 0
	syscall
	syscall
	move $a0, $t1
	syscall
	j ExitPrint
	NaoImprimeZeroAEsquerda:
	
	# Parte decimal eh maior ou igual a 10
	li $v0, 1
	move $a0, $t1
	syscall
	
	ExitPrint:
	
	# Imprime o espaco, mas nao se for o ultimo numero
	c.eq.s $f3, $f4
	bc1t UltimoNumero
	li $v0, 11
	li $a0, 32
	syscall
	UltimoNumero:
	
	#########################
	add.s $f4, $f4, $f5 # k++
	j Loop

# ----------------------------------------------------------

Termina:

	li $v0, 10
	syscall
