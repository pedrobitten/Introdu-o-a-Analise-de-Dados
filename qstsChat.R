#qst1

#install.packages("dplyr")
library(dplyr)

nome <- NULL
idade <- NULL
curso <- NULL
alunos <- NULL

nome <- c("Ana", "Bruno", "Carlos", "Diana")
idade <- c(21, 22, 20, 23)
curso <- c("Medicina", "Engenharia", "Direito", "Arquitetura")
alunos <- data.frame(nome, idade, curso)

#qs2 

#a)

coluna_curso <- NULL
coluna_curso <- alunos["curso"]

#b)

segundo_aluno <- NULL
segundo_aluno <- alunos[2, c(1,3)]

#c)

idade_maior_21 <- NULL
idade_maior_21 <- filter(alunos, idade > 21)

#qst3

#a) b)

#alunos[3, 2] <- 21
#alunos[4, 3] <- "Design"

for (cont in 1:nrow(alunos))
{
  if (alunos[cont, 1] == "Carlos"){
    alunos[cont, 2] <- 21
  }
  
  else if (alunos[cont, 1] == "Diana"){
    alunos[cont, 3] <- "Design"
  }
}

#qst4

#a)

novo_aluno <- NULL

novo_aluno <- data.frame(nome = "Eduardo", idade = 24, curso = "Economia")

alunos_atualizado <- rbind(alunos, novo_aluno)

#b)

#for (cont in 1:nrow(alunos_atualizado))
#{
#  if (alunos_atualizado[cont, 1] == "Bruno"){
    #alunos_atualizado <- alunos_atualizado[- cont, ]
  #}
#}

#qst5

#a)

alunos_atualizado <- arrange(alunos_atualizado, idade)

#b)

filtrar_alunos_D <- filter(alunos_atualizado, substr(curso, 1, 1) == "D")

#qst6

#a)

notas <- NULL
nome <- NULL
nota_final <- NULL

nome <- c("Ana", "Carlos", "Diana", "Eduardo")
nota_final <- c(8.5, 7.0, 9.0, 6.5)
notas <- data.frame(nome, nota_final)

alunos_notas <- merge(alunos_atualizado, notas, by = "nome", all.x = TRUE)

#b)

filtrar_alunos_maior_8 <- NULL

filtrar_alunos_maior_8 <- filter(alunos_notas, nota_final > 8)

#qst7

#a)

media_nota_final <- 0.0

alunos_notas <- alunos_notas[- 2 , ]

media_nota_final <- sapply(alunos_notas["nota_final"], mean)
print(paste("Media das notas finais:", media_nota_final))

#b)

qtd_alunos_21_e_75 <- 0

for (cont in 1:nrow(alunos_notas))
{
  if (alunos_notas[cont, 2] > 21 & alunos_notas[cont, 4] > 7.5){
    qtd_alunos_21_e_75 <- qtd_alunos_21_e_75 + 1
  }
}

print(paste("Quantidade de alunos com idade maior que 21 e nota acima de 7.5:", qtd_alunos_21_e_75))

#desafio 1

aprovado <- NULL
alunos_notas_atualizado <- NULL

for (cont in 1: nrow(alunos_notas))
{
  if (alunos_notas[cont, 4] >= 7.0){
    aprovado <- c(aprovado, TRUE)
  }
  
  else{
    aprovado <- c(aprovado, FALSE)
  }
}

alunos_notas_atualizado <- cbind(alunos_notas, aprovado)

#desafio 2 

idades_unicas <- NULL

for (cont in 1: nrow(alunos_notas_atualizado))
{
  if (!(alunos_notas_atualizado[cont, 2] %in% idades_unicas)){
    idades_unicas <- c(idades_unicas, alunos_notas_atualizado[cont, 2])
  }
}

idades_unicas

#desafio 3

qtd_alunos_curso <- 0

qtd_alunos_curso <- mutate(alunos_notas_atualizado, count(curso))