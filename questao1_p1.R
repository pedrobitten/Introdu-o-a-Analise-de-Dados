#lucro mensal = receita - custo
#empresa obtem lucro = receita > custo

custoMensal <- function(custo_fixo, custo_variavel, qtd_valvulas)
{
  custo <- 0.0
  
  custo <- custo_fixo + (custo_variavel * qtd_valvulas)
  
  return (custo)
}

receitaMensal <- function(valor_mercado, qtd_valvulas)
{
  receita <- 0.0
  
  receita <- valor_mercado * qtd_valvulas
  
  return (receita)
}

qtd_valvulas_produzidas <- NULL
custo_mensal <- 0.0
receita_mensal <- 0.0
cont <- 0
vetor_lucro_mensal <- NULL
qtd_minima_de_valvulas <- 0

qtd_valvulas_produzidas <- seq(10, 200, 1)
custo_fixo_valvula <- 4500.00
custo_variavel_de_producao <- 41.00
valor_mercado_valvula <- 120.00
vetor_lucro_mensal <- rep(0, length(qtd_valvulas_produzidas))
cont <- 1

for (valvulas in qtd_valvulas_produzidas)
{
  custo_mensal <- custoMensal(custo_fixo_valvula, custo_variavel_de_producao, valvulas)
  receita_mensal <- receitaMensal(valor_mercado_valvula, valvulas)
  
  vetor_lucro_mensal[cont] <- receita_mensal - custo_mensal
  
  if (receita_mensal > custo_mensal){
    qtd_minima_de_valvulas <- qtd_minima_de_valvulas + valvulas
  }
  
  cont <- cont + 1
}

print(paste("Quantidade minima de valvulas para obter lucro:", qtd_minima_de_valvulas))

plot(qtd_valvulas_produzidas, vetor_lucro_mensal)