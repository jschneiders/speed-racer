#As configura��es do Bitmap Display precisam ser 8x16 unidades em pixels, 256x512 display, base adress $gp
.data
colorYellow:	.word 0x00FFFF00	#Faixas laterais e central
colorRed:	.word 0x00FF0000	#Jogador
colorGrey:	.word 0x00333333	#Fundo
colorBlue:	.word 0x000000FF	#Oponentes
colorGreen:	.word 0x00008800	#Bordas
placar:		.asciiz "SCORE:"
specs:		.asciiz "Para rodar o jogo, use o menu Tools para abrir o Keyboard and Display MMIO Simulator e o\nBitmap Display nas configura��es 8x16 de tamanho de pixel, 256x512 de tamanho de tela e endere�o base ($gp).\nConecte ambos ao MIPS, compile e rode o c�digo. Para jogar, d� um clique na tela de Keyboard do Receiver Data 0xFFFF0004.\nDIVIRTA-SE!\n"
space:		.asciiz "\n"
.text
lw $s0, colorYellow
lw $s1, colorRed
lw $s2, colorGrey
lw $s3, colorBlue
li $s5, 0xFFFF0000	#Guarda o endere�o utilizado pelo keyboard and MMIO simulator (0 para nenhuma tecla, 1 para tecla pressionada)
			#Na posi��o 0xFFFF0004 ele armazena o valor da tecla que foi pressionada
li $v0, 4
la $a0, specs
syscall			#Mostra as configura��es no console
nop
menu:			#Inicializa o menu
li $v0, 4
la $a0, placar
syscall			#Mostra "SCORE" no console
nop
li $v0, 4
la $a0, space
syscall			#insere uma nova linha no console
nop
li $v0, 1
or $a0, $0, $t7
syscall			#Mostra a pontua��o do placar
nop
li $v0, 4
la $a0, space
syscall			#Insere uma nova linha no console
nop
lw $t2, colorGrey	#Inicializa os oponentes
lw $t3, colorGrey
lw $t5, colorGrey
lw $t9, colorGrey
ori $t7, $0, 0
ori $t8, $0, 0
add $t8, $t8, $gp
ori $t4, $0, 0
inibackground:		#Background inicial para receber o menu
sw $s2, ($t8)
addi $t8, $t8, 4
addi $t4, $t4, 4
beq $t4, 4096, intro	#Quando o fundo estiver preenchido salta para a intro
nop
j inibackground		#Loop de pintura do fundo
nop
intro:			#Pinta as letras na tela
#S
sw $s0, 280($gp)
sw $s0, 284($gp)
sw $s0, 288($gp)
sw $s0, 408($gp)
sw $s0, 536($gp)
sw $s0, 540($gp)
sw $s0, 544($gp)
sw $s0, 672($gp)
sw $s0, 800($gp)
sw $s0, 796($gp)
sw $s0, 792($gp)
#P
sw $s0, 296($gp)
sw $s0, 300($gp)
sw $s0, 304($gp)
sw $s0, 424($gp)
sw $s0, 432($gp)
sw $s0, 552($gp)
sw $s0, 556($gp)
sw $s0, 560($gp)
sw $s0, 680($gp)
sw $s0, 808($gp)
#E
sw $s0, 312($gp)
sw $s0, 316($gp)
sw $s0, 320($gp)
sw $s0, 440($gp)
sw $s0, 568($gp)
sw $s0, 572($gp)
sw $s0, 696($gp)
sw $s0, 824($gp)
sw $s0, 828($gp)
sw $s0, 832($gp)
#E
sw $s0, 328($gp)
sw $s0, 332($gp)
sw $s0, 336($gp)
sw $s0, 456($gp)
sw $s0, 584($gp)
sw $s0, 588($gp)
sw $s0, 712($gp)
sw $s0, 840($gp)
sw $s0, 844($gp)
sw $s0, 848($gp)
#D
sw $s0, 344($gp)
sw $s0, 348($gp)
sw $s0, 472($gp)
sw $s0, 480($gp)
sw $s0, 600($gp)
sw $s0, 608($gp)
sw $s0, 728($gp)
sw $s0, 736($gp)
sw $s0, 856($gp)
sw $s0, 860($gp)
#R
sw $s0, 1176($gp)
sw $s0, 1180($gp)
sw $s0, 1184($gp)
sw $s0, 1304($gp)
sw $s0, 1312($gp)
sw $s0, 1432($gp)
sw $s0, 1440($gp)
sw $s0, 1560($gp)
sw $s0, 1564($gp)
sw $s0, 1688($gp)
sw $s0, 1696($gp)
#A
sw $s0, 1192($gp)
sw $s0, 1196($gp)
sw $s0, 1200($gp)
sw $s0, 1320($gp)
sw $s0, 1328($gp)
sw $s0, 1448($gp)
sw $s0, 1452($gp)
sw $s0, 1456($gp)
sw $s0, 1576($gp)
sw $s0, 1584($gp)
sw $s0, 1704($gp)
sw $s0, 1712($gp)
#C
sw $s0, 1208($gp)
sw $s0, 1212($gp)
sw $s0, 1216($gp)
sw $s0, 1336($gp)
sw $s0, 1464($gp)
sw $s0, 1592($gp)
sw $s0, 1720($gp)
sw $s0, 1724($gp)
sw $s0, 1728($gp)
#E
sw $s0, 1224($gp)
sw $s0, 1228($gp)
sw $s0, 1232($gp)
sw $s0, 1352($gp)
sw $s0, 1480($gp)
sw $s0, 1484($gp)
sw $s0, 1608($gp)
sw $s0, 1736($gp)
sw $s0, 1740($gp)
sw $s0, 1744($gp)
#R
sw $s0, 1240($gp)
sw $s0, 1244($gp)
sw $s0, 1248($gp)
sw $s0, 1368($gp)
sw $s0, 1376($gp)
sw $s0, 1496($gp)
sw $s0, 1504($gp)
sw $s0, 1624($gp)
sw $s0, 1628($gp)
sw $s0, 1752($gp)
sw $s0, 1760($gp)
#A
sw $s1, 2188($gp)
sw $s1, 2192($gp)
sw $s1, 2196($gp)
sw $s1, 2316($gp)
sw $s1, 2324($gp)
sw $s1, 2444($gp)
sw $s1, 2448($gp)
sw $s1, 2452($gp)
sw $s1, 2572($gp)
sw $s1, 2580($gp)
sw $s1, 2700($gp)
sw $s1, 2708($gp)
#H�fen
sw $s1, 2460($gp)
#S
sw $s1, 2212($gp)
sw $s1, 2216($gp)
sw $s1, 2220($gp)
sw $s1, 2340($gp)
sw $s1, 2468($gp)
sw $s1, 2472($gp)
sw $s1, 2476($gp)
sw $s1, 2604($gp)
sw $s1, 2732($gp)
sw $s1, 2728($gp)
sw $s1, 2724($gp)
#T
sw $s1, 2228($gp)
sw $s1, 2232($gp)
sw $s1, 2236($gp)
sw $s1, 2360($gp)
sw $s1, 2488($gp)
sw $s1, 2616($gp)
sw $s1, 2744($gp)
#A
sw $s1, 2244($gp)
sw $s1, 2248($gp)
sw $s1, 2252($gp)
sw $s1, 2372($gp)
sw $s1, 2380($gp)
sw $s1, 2500($gp)
sw $s1, 2504($gp)
sw $s1, 2508($gp)
sw $s1, 2628($gp)
sw $s1, 2636($gp)
sw $s1, 2756($gp)
sw $s1, 2764($gp)
#R
sw $s1, 2260($gp)
sw $s1, 2264($gp)
sw $s1, 2268($gp)
sw $s1, 2388($gp)
sw $s1, 2396($gp)
sw $s1, 2516($gp)
sw $s1, 2524($gp)
sw $s1, 2644($gp)
sw $s1, 2648($gp)
sw $s1, 2772($gp)
sw $s1, 2780($gp)
#T
sw $s1, 2276($gp)
sw $s1, 2280($gp)
sw $s1, 2284($gp)
sw $s1, 2408($gp)
sw $s1, 2536($gp)
sw $s1, 2664($gp)
sw $s1, 2792($gp)
#D
sw $s1, 3084($gp)
sw $s1, 3088($gp)
sw $s1, 3212($gp)
sw $s1, 3220($gp)
sw $s1, 3340($gp)
sw $s1, 3348($gp)
sw $s1, 3468($gp)
sw $s1, 3476($gp)
sw $s1, 3596($gp)
sw $s1, 3600($gp)
#H�fen
sw $s1, 3356($gp)
#E
sw $s1, 3108($gp)
sw $s1, 3112($gp)
sw $s1, 3116($gp)
sw $s1, 3236($gp)
sw $s1, 3364($gp)
sw $s1, 3368($gp)
sw $s1, 3492($gp)
sw $s1, 3620($gp)
sw $s1, 3624($gp)
sw $s1, 3628($gp)
#X
sw $s1, 3124($gp)
sw $s1, 3132($gp)
sw $s1, 3252($gp)
sw $s1, 3260($gp)
sw $s1, 3384($gp)
sw $s1, 3508($gp)
sw $s1, 3516($gp)
sw $s1, 3636($gp)
sw $s1, 3644($gp)
#I
sw $s1, 3144($gp)
sw $s1, 3272($gp)
sw $s1, 3400($gp)
sw $s1, 3528($gp)
sw $s1, 3656($gp)
#T
sw $s1, 3156($gp)
sw $s1, 3160($gp)
sw $s1, 3164($gp)
sw $s1, 3288($gp)
sw $s1, 3416($gp)
sw $s1, 3544($gp)
sw $s1, 3672($gp)
choose:			#Loop de espera para escolha de uma op��o do menu
li $v0, 32
li $a0, 100
syscall			#Delay do loop
nop
lw $v0, 0($s5)
beq $v0, $0, choose	#Enquanto nenhuma tecla � pressionada fica no loop
nop
lw $v1, 4($s5)
beq $v1, 100, exit	#Se a tecla pressionada for D, sai do programa
nop
beq $v1, 97, begin	#Se a tecla pressionada for A, inicia a partida
nop
j choose		#Se a tecla pressionada n�o faz parte das escolhas, retorna para o loop
nop
begin:			#In�cio da partida
ori $t8, $0, 0
add $t8, $t8, $gp
ori $t4, $0, 0
background:		#Pinta o fundo
sw $s2, ($t8)
addi $t8, $t8, 4
addi $t4, $t4, 4
beq $t4, 4096, borders	#Quando o fundo estiver preenchido, salta para a pintura das laterais
nop
j background
nop
borders:		#Pinta as laterais
lw $s4, colorGreen
ori $t8, $0, 0
add $t8, $t8, $gp
ori $t4, $0, 0
leftborder:		#Pinta a lateral esquerda
sw $s4, ($t8)
addi $t8, $t8, 128
addi $t4, $t4, 128
bge $t4, 3971, rightborder0
nop
j leftborder
nop
rightborder0:		#Re-inicializa os registradores para pintar a lateral direita
ori $t8, $0, 0
add $t8, $t8, $gp
addi $t8, $t8, 124
ori $t4, $0, 0
addi $t4, $t4, 124
rightborder:		#Pinta a lateral direita
sw $s4, ($t8)
addi $t8, $t8, 128
addi $t4, $t4, 128
bge $t4, 4093, player	#Quando as laterais estiverem prontas, salta para a inicializa��o do jogador
nop
j rightborder
nop
player:			#Inicializa��o do jogador
li $t4, 3388		#Deslocamento para posicionar inicialmente o jogador
add $t4, $t4, $gp	#Posi��o inicial do jogador
sw $s1, ($t4)		#Pinta o pixel referente a posi��o inicial do jogador com a cor carregada em $s1
main:			#Loop principal do jogo
li $v0, 32
li $a0, 50
syscall			#Delay de resposta para o loop
nop
jal faixa1		#Chama a pintura da faixa central
nop
li $v0, 32
li $a0, 50
syscall			#Delay entre as pinturas de faixa para melhor sensa��o de movimento
nop
jal faixa2		#Alterna as cores da faixa
nop
jal spawn
nop
jal oponente1
nop
addi $t7, $t7, 1
lw $v0, 0($s5)
beq $v0, $0, main	#Se nenhuma tecla for pressionada, volta pra main
nop
lw $v1, 4($s5)
beq $v1, 100, direita	#Se a tecla D for pressionada salta para mover para direita
nop
beq $v1, 97, esquerda	#Se a tecla A for pressionada salta para mover para esquerda
nop
j main			#Loop pra main
nop
direita:		#Mover para a direita
sw $s2, ($t4)
addi $t4, $t4, 4
li $t6, 3452		#Limite lateral direito
add $t6, $t6, $gp	#Endere�o do limite direito
beq $t4, $t6, menu	#Se o jogador alcan�ar o limite lateral retorna pro menu
nop
sw $s1, ($t4)
j main			#Volta para o loop principal
nop
esquerda:		#Mover para a esquerda
sw $s2, ($t4)
subi $t4, $t4, 4
li $t6, 3328		#Limite lateral esquerdo
add $t6, $t6, $gp	#Endere�o do limite direito
beq $t4, $t6, menu	#Se o jogador alcan�ar o limite lateral retorna pro menu
nop
sw $s1, ($t4)
j main			#Volta para o loop principal
nop
#####################################
faixa1:			#Pinta a faixa central
sw $s0, 64($gp)
sw $s0, 192($gp)
sw $s2, 320($gp)
sw $s2, 448($gp)
sw $s0, 576($gp)
sw $s0, 704($gp)
sw $s2, 832($gp)
sw $s2, 960($gp)
sw $s0, 1088($gp)
sw $s0, 1216($gp)
sw $s2, 1344($gp)
sw $s2, 1472($gp)
sw $s0, 1600($gp)
sw $s0, 1728($gp)
sw $s2, 1856($gp)
sw $s2, 1984($gp)
sw $s0, 2112($gp)
sw $s0, 2240($gp)
sw $s2, 2368($gp)
sw $s2, 2496($gp)
sw $s0, 2624($gp)
sw $s0, 2752($gp)
sw $s2, 2880($gp)
sw $s2, 3008($gp)
sw $s0, 3136($gp)
sw $s0, 3264($gp)
sw $s2, 3392($gp)
sw $s2, 3520($gp)
sw $s0, 3648($gp)
sw $s0, 3776($gp)
sw $s2, 3904($gp)
sw $s2, 4032($gp)
sw $s1, ($t4)
jr $ra
nop
#####################################
faixa2:			#Pinta a faixa central ao inverso da outra
sw $s2, 64($gp)
sw $s2, 192($gp)
sw $s0, 320($gp)
sw $s0, 448($gp)
sw $s2, 576($gp)
sw $s2, 704($gp)
sw $s0, 832($gp)
sw $s0, 960($gp)
sw $s2, 1088($gp)
sw $s2, 1216($gp)
sw $s0, 1344($gp)
sw $s0, 1472($gp)
sw $s2, 1600($gp)
sw $s2, 1728($gp)
sw $s0, 1856($gp)
sw $s0, 1984($gp)
sw $s2, 2112($gp)
sw $s2, 2240($gp)
sw $s0, 2368($gp)
sw $s0, 2496($gp)
sw $s2, 2624($gp)
sw $s2, 2752($gp)
sw $s0, 2880($gp)
sw $s0, 3008($gp)
sw $s2, 3136($gp)
sw $s2, 3264($gp)
sw $s0, 3392($gp)
sw $s0, 3520($gp)
sw $s2, 3648($gp)
sw $s2, 3776($gp)
sw $s0, 3904($gp)
sw $s0, 4032($gp)
sw $s1, ($t4)
jr $ra
nop
#####################################
spawn:			#Gera os oponentes
or $t0, $0, $t4
sub $t0, $t0, $gp
subi $t0, $t0, 3328
add $t0, $t0, $gp
beq $t1, 0, spawn1	#Manda gerar o oponente 1 com o contador em 0
nop
beq $t1, 10, spawn2	#Manda gerar o oponente 2 com o contador em 
nop
beq $t1, 20, spawn3	#Manda gerar o oponente 3 com o contador em
nop
beq $t1, 35, spawn4	#Manda gerar o oponente 4 com o contador em
nop
beq $t1, 55, spawnreset	#Manda resetar o contador nessa contagem
nop
addi $t1, $t1, 1
jr $ra
nop
spawn1:
or $t2, $0, $t0
sw $s3, ($t0)
addi $t1, $t1, 1
jr $ra
nop
spawn2:
or $t3, $0, $t0
sw $s3, ($t0)
addi $t1, $t1, 1
jr $ra
nop
spawn3:
or $t5, $0, $t0
sw $s3, ($t0)
addi $t1, $t1, 1
jr $ra
nop
spawn4:
or $t9, $0, $t0
sw $s3, ($t0)
addi $t1, $t1, 1
jr $ra
nop
spawnreset:
ori $t1, $0, 0
jr $ra
nop
#####################################
oponente1:		#Calcula a posi��o limite dos oponentes
li $t0, 4096
add $t0, $t0, $gp
beq $t2, $s2, oponente2	#Se o oponente for da cor da pista ele n�o existe, ent�o passa para o pr�ximo
nop			#Se esse oponente n�o foi criado, salta para o pr�ximo
sw $s2, ($t2)
addi $t2, $t2, 128
beq $t4, $t2, menu	#Se atingir o jogador, volta para o menu inicial
nop
bge $t2, $t0, destroy1	#Se o oponente passar do limite � destru�do
nop
sw $s3, ($t2)
oponente2:
beq $t3, $s2, oponente3	#Se o oponente for da cor da pista ele n�o existe, ent�o passa para o pr�ximo
nop			#Se esse oponente n�o foi criado, salta para o pr�ximo
sw $s2, ($t3)
addi $t3, $t3, 128
beq $t4, $t3, menu	#Se atingir o jogador, volta para o menu inicial
nop
bge $t3, $t0, destroy2	#Se o oponente passar do limite � destru�do
nop
sw $s3, ($t3)
oponente3:
beq $t5, $s2, oponente4	#Se o oponente for da cor da pista ele n�o existe, ent�o passa para o pr�ximo
nop			#Se esse oponente n�o foi criado, salta para o pr�ximo
sw $s2, ($t5)
addi $t5, $t5, 128
beq $t4, $t5, menu	#Se atingir o jogador, volta para o menu inicial
nop
bge $t5, $t0, destroy3	#Se o oponente passar do limite � destru�do
nop
sw $s3, ($t5)
oponente4:
beq $t9, $s2, moveuOponentes
nop			#Se esse oponente n�o foi criado, volta para o loop principal
sw $s2, ($t9)
addi $t9, $t9, 128
beq $t4, $t9, menu	#Se atingir o jogador, volta para o menu inicial
nop
bge $t9, $t0, destroy4	#Se o oponente passar do limite � destru�do
nop
sw $s3, ($t9)
moveuOponentes:
jr $ra
nop
#####################################
destroy1:
sw $s2, ($t2)
j oponente2
nop
destroy2:
sw $s2, ($t3)
j oponente3
nop
destroy3:
sw $s2, ($t5)
j oponente4
nop
destroy4:
sw $s2, ($t9)
jr $ra
nop
#####################################
exit:			#Encerra o programa
li $v0, 10
syscall
nop
