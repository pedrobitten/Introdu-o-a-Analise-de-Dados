#a)

library(dplyr)

investimento <- NULL
Codigo <- NULL
ValorInvestido <- NULL
Taxa <- NULL

Codigo <- c("AEF01", "TRX25", "HNC22", "DFX08")
ValorInvestido <- c(28300.00, 24700.00, 22100.00, 31400.00)
Taxa <- c(8, 2, 23, 15)
investimento <- data.frame(Codigo, ValorInvestido, Taxa)

#b)

investimento_ordenado <- NULL

investimento_ordenado <- arrange(investimento, Taxa)

#c)

investimento_filtrado <- NULL
seleciona_investimento_filtrado <- NULL

investimento_filtrado <- filter(investimento, Taxa > 10)
seleciona_investimento_filtrado <- select(investimento_filtrado, Codigo, ValorInvestido)

#d)
investimento_retorno <- NULL

investimento_retorno <- mutate(investimento, Retorno = 0.95 * ValorInvestido * (1 + Taxa))

#e)

novo_investimento <- NULL
investimento_atualizado <- NULL

Codigo <- c("BCH03", "ABN01")
ValorInvestido <- c(26200.00, 17800.00)
Taxa <- c(12, 7)

novo_investimento <- data.frame(Codigo, ValorInvestido, Taxa)

investimento_atualizado <- merge(investimento, novo_investimento, all = TRUE)

#f)

Reinvestir <- NULL
ValorInvestido <- c(28300.00, 24700.00, 22100.00, 31400.00)
investimento_Reinvestir <- NULL

Reinvestir <- ifelse(ValorInvestido < 25000, "SIM", "NAO")

investimento_Reinvestir <- cbind(investimento, Reinvestir)

#g)

taxa_retorno <- 0.0
retorno_total <- 0.0
valor_total_investido <- 0.0
retorno <- NULL

retorno <- 0.95 * investimento["ValorInvestido"] * (1 + investimento["Taxa"])

for (cont in 1:nrow(investimento))
{
  valor_total_investido <- valor_total_investido + investimento[cont, 2]
  retorno_total <- retorno_total + retorno[cont, ]
}

taxa_retorno <- (retorno_total - valor_total_investido) / valor_total_investido
print(paste("Taxa de retorno:", taxa_retorno))

