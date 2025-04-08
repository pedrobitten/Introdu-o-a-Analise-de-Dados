#qst4

numero_de_funcionarios <- 0
numero_de_contratacoes <- 0
numero_de_demissoes <- 0
indice <- 0.0

numero_de_funcionarios <- 2300
numero_de_demissoes <- 100
numero_de_contratacoes <- 130

indice <- (numero_de_demissoes + numero_de_contratacoes) / (2 * numero_de_funcionarios)

print(paste("Indice de rotatividade da empresa:", indice))
