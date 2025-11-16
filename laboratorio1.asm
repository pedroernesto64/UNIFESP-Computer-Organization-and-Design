# Pedro Ernesto Duarte Pilchowski - RA: 156.331
# Laboratorio 1 - AOC
# Professor Fabio Cappabianco
     
.data
string: .space 200
     
.text
main:
     
	li $v0, 8                    # Codigo de syscall para ler string
	la $a0, string                # Carrega o endereco de memoria da string
	la $a1, 200                    # Le toda a string (200 bytes)
	syscall   
    
	li $v0, 12                    # Le o caractere especial
	syscall
	move $t1, $v0                # Transfere o caractere lido para $t1
     
	la $a1, string                # Carrega o endereco de memoria da string em $a1
	li $t0, 0                    # Inicia o contador
	j Conta_string
     
Conta_string:
	beq $a0, 10, Terminar        # Termina o programa quando encontrar a quebra de linha na string
	lb $a0, ($a1)                # Carrega em $a0 o caractere contido no endereco de memoria de $a1
	beq $a0, $t1, Pula_contador    # Se o caractere de $a0 for igual ao caractere de $t1, nao o conta
	addi $t0, $t0, 1            # Incrementa o contador
	Pula_contador:
	addi $a1, $a1, 1            # Passa para o proximo caractere na memoria
	j Conta_string
        
Terminar:
	li $v0, 11
	li $a0, 10                    # Quebra de linha para mostrar resultado
	syscall
 
	addi $t0, $t0, -1
	move $a0, $t0
	li $v0, 1
	syscall
       
	li $v0, 10                  # Carrega o codigo para finalizar o programa
	syscall

