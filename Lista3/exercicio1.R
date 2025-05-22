setwd("D:\\Introdução a analise de dados\\Dados")

library(descr)
library(dplyr)
library(ggplot2)

celular <- NULL

file.head("celular.csv")

celular <- read.csv2("celular.csv", sep = ';', dec = '.')

#a)

grafico_barra <- NULL

grafico_barra <- table(celular$modelo)

#barplot(grafico_barra, main = "Total de dias de aluguel para os diferentes tipos de modelo", 
      xlab = "Modelo de celular", ylab = "Total de dias de aluguel")

#b)

grafico_pizza <- NULL

grafico_pizza <- table(celular$modelo)

#pie(grafico_pizza, main = "Total de dias de aluguel para os diferentes tipos de modelo")

#c)

soma_lucro <- 0.0

celular <- mutate(celular, Lucro = (aluguel - (imposto + seguro)))
celular$mes <- "marco"

soma_lucro <- sum(celular$Lucro, na.rm = TRUE)
print(paste("Lucro total da empresa", soma_lucro))

#d)

#ggplot(celular) +
geom_point(aes(x = dia, y = modelo, fill = as.factor(modelo))) +
labs(x = "Dia do mes", y = "Total de aparelhos alugados") +
ggtitle("Total de aparelhos alugados para cada dia do mes")

#e)

#ggplot(celular) + 
geom_point(aes(x = dia, y = Lucro)) +
labs(x = "Dia do mes", y = "Lucro obtido") +
ggtitle("Lucro obtido com o aluguel dos aparelhos para cada dia do mes")

#f)

qtd_alugueis_acima_media_lucro <- 0


qtd_alugueis_acima_media_lucro <- filter(celular, Lucro > mean(Lucro, na.rm = TRUE))
print(paste("Quantidade de alugueis onde o lucro ficou acima da media", sum(nrow(qtd_alugueis_acima_media_lucro))))

#g)

for (linha in 1:nrow(celular))
{
if (is.na(celular[linha, 4])){
  celular[linha, 4] <- 2
}
}

celular <- mutate(celular, Lucro = (aluguel - (imposto + seguro)))

#h)

aluguel_abril <- NULL
aluguel_maio <- NULL
maio_e_abril <- NULL
aluguel_total <- NULL

file.head("celularabril.csv")

aluguel_abril <- read.csv("celularabril.csv", sep = ',', dec = '.', header = FALSE)
aluguel_abril$mes <- "abril"

names(aluguel_abril) <- c("dia", "modelo", "imposto", "seguro", "aluguel", "mes")

file.head("celularmaio.txt")

aluguel_maio <- read.fwf("celularmaio.txt", widths = c(2, 1, 2, 2, 3), col.names = c("dia", "modelo", "imposto", "seguro", "aluguel"))
aluguel_maio$imposto <- aluguel_maio$imposto / 10
aluguel_maio$aluguel <- aluguel_maio$aluguel / 10
aluguel_maio$mes <- "maio"


maio_e_abril <- merge(aluguel_abril, aluguel_maio, all = TRUE)
aluguel_total <- merge(celular, maio_e_abril, all = TRUE)

for (linha in 1:nrow(aluguel_total))
{
if (is.na(aluguel_total[linha, 4])){
  aluguel_total[linha, 4] <- 2
}
}

aluguel_total <- mutate(aluguel_total, Lucro = (aluguel - (imposto + seguro)))

#i)

write.csv2(aluguel_total, "aluguel.csv", row.names = FALSE)

#j)

aluguel_novo <- NULL

aluguel_novo <- read.csv2("aluguel.csv", sep = ';', dec = ',')

#k) 

alugadosMarco <- aluguel_novo %>% filter(mes == "marco") %>% distinct(modelo)
alugadosAbril <- aluguel_novo %>% filter(mes == "abril") %>% distinct(modelo)

modelos <- anti_join(alugadosAbril, alugadosMarco)
print(modelos)

#l)

alugadosMaio <- NULL
qtd_alugueis_acima_media_lucro_maio <- 0

alugadosMaio <- filter(aluguel_novo, mes == "maio") 
qtd_alugueis_acima_media_lucro_maio <- filter(alugadosMaio, Lucro > mean(aluguel_novo$Lucro))
print(nrow(qtd_alugueis_acima_media_lucro_maio))

#m)


aluguel_novo_lucro_mes <- select(aluguel_novo, mes, Lucro)
aluguel_novo_lucro_mes <- group_by(aluguel_novo_lucro_mes, mes)
aluguel_novo_lucro_mes <- summarise(aluguel_novo_lucro_mes, Lucro = sum(Lucro))

ggplot(aluguel_novo_lucro_mes) +
  geom_bar(aes(x = mes, y = Lucro), stat = "identity") +
  labs(x = "Mes", y = "Lucro obtido") +
  ggtitle("Lucro obtido com os alugueis para os tres meses de aluguel")
