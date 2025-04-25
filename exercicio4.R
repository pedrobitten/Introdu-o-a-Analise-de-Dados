
library(dplyr)

filial_1 <- NULL
filial_2 <- NULL
menor_gasto_pessoal_filial_1 <- 0.0
maior_gasto_pessoal_filial_1 <- 0.0
menor_gasto_pessoal_filial_2 <- 0.0
maior_gasto_pessoal_filial_2 <- 0.0
empresa <- NULL

mes <- c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun")
pessoal <- c(352234, 28516, 32890, 37634, 25219, 28300)
aluguel<- c(7500.30, 7500.30, 7890.60, 10200.60, 9210.00, 10700.20)

filial_1 <- data.frame(mes, pessoal, aluguel) 

pessoal <- c(12200, 12900, 10000, 12300, 13100, 11900)
aluguel <- c(3000.20, 3200.20, 3290.40, 4000.50, 3900.10, 4100.20)

filial_2 <- data.frame(mes, pessoal, aluguel)

filial <- rep("01", nrow(filial_1))

filial_1 <- cbind(filial_1, filial)

filial <- rep("02", nrow(filial_2))

filial_2 <- cbind(filial_2, filial)

empresa <- merge(filial_1, filial_2, all = TRUE)

empresa["aluguel"] <- 1.1 * empresa["aluguel"]

empresa <- mutate(empresa, desvio = ifelse(filial == "01", 40000 - (pessoal + aluguel), 15000 - (pessoal + aluguel)))

soma <- 0.0

soma <- sapply(empresa["desvio"], sum)
print(paste("Soma dos valores do desvio da empresa", soma))