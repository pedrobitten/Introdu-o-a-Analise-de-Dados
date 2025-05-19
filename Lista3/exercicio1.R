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

#h)

aluguel_abril <- NULL
aluguel_maio <- NULL

celular[["mes"]] <- "marco"

aluguel_abril <- read.csv("celularabril.csv", sep = ',', dec = '.', header = FALSE)

names(aluguel_abril) <- c("dia", "modelo", "imposto", "seguro", "aluguel")

aluguel_abril[["mes"]] <- "abril"

aluguel_maio <- read.fwf("celularmaio.txt", widths = c(2, 1, 2, 2, 3), col.names = c("dia", "modelo", "imposto", "seguro", "aluguel"))

aluguel_maio[["mes"]] <- "maio"


aluguel_maio[["imposto"]] <- aluguel_maio[["imposto"]] / 10
aluguel_maio[["aluguel"]] <- aluguel_maio[["aluguel"]] / 10 

celular_atualizado <- merge(celular, aluguel_abril, all = TRUE)
celular_atualizado <- merge(celular_atualizado, aluguel_maio, all = TRUE)

#i)

write.csv2(celular_atualizado, "aluguel.csv", row.names = FALSE)

#j)

aluguel_celular <- read.csv2("aluguel.csv", sep = ";", header = TRUE)

#k) ?

alugados_em_abril_apenas <- count(aluguel_celular, modelo, mes = "abril")
alugados_em_marco_apenas <- count(aluguel_celular, modelo, mes = "marco")

#l)

aluguel_celular <- aluguel_celular %>%
  mutate(
    imposto = as.numeric(imposto),
    seguro  = as.numeric(seguro),
    aluguel = as.numeric(aluguel)  # só se necessário
  )


aluguel_celular <- mutate(aluguel_celular, lucro = aluguel - 
                            (ifelse(is.na(imposto), 0, imposto) + 
                               ifelse(is.na(seguro), 0, seguro)))

media_dos_alugueis <- mean(aluguel_celular[["lucro"]])

aluguel_em_maio <- distinct(aluguel_celular, mes = "maio", lucro)
qtd_acima_da_media <- 0

for (lucro in aluguel_em_maio[["lucro"]])
{
  if (lucro > media_dos_alugueis){
    qtd_acima_da_media <- qtd_acima_da_media + 1
  }
}
  
qtd_acima_da_media

