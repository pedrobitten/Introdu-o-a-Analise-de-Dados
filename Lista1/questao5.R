#qst5

calculaImposto <- function(rendimentos_obtidos, numero_de_dias)
{
  imposto <- 0.0
  
  imposto <- rendimentos_obtidos * 0.03 * (30 - numero_de_dias)

  return (imposto) 
}

resposta <- 0.0

rendimento_da_empresa <- 1000
numero_dias <- 15

resposta <- calculaImposto(rendimento_da_empresa, numero_dias)
print(paste("Valor do imposto da empresa:", resposta))