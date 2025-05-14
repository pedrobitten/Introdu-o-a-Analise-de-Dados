#setwd("C:\\Users\\c2111415\\Documents\\introducao a analise de dados\\Dados")
#install.packages("dplyr")

library(dplyr)

#a)

arq_celular <- NULL
grafico_barra <- NULL

arq_celular <- read.csv2("celular.csv", sep = ";", dec = ".")

grafico_barra <- table(arq_celular["modelo"])

barplot(grafico_barra, main = "Total de dias de aluguel para cada modelo ", xlab = "Modelo celular", ylab = "Total de dias de aluguel")

#b)

grafico_pizza <- NULL

grafico_pizza <- table(arq_celular["modelo"])

pie(grafico_pizza, main = "Total de dias de aluguel para cada modelo")

#c)

celular_lucro <- NULL

celular_lucro <- mutate(arq_celular, lucro = (aluguel - (imposto + seguro)))

#d)

celular_dia_modelo <- NULL
dia <- NULL
aparelhos_alugados <- NULL

celular_dia_modelo <- count(arq_celular, dia)

dia <- celular_dia_modelo[["dia"]]
aparelhos_alugados <- celular_dia_modelo[["n"]]

aparelhos_alugados <- aparelhos_alugados + rnorm(length(dia))

plot(dia, aparelhos_alugados, main = "Total de aparelhos alugados para cada dia do mês", xlab = "Dia do mês", ylab = "Total de aparelhos alugados")

#e)

