#qst6

calculaIndiceRotatividade <- function(numero_de_demissoes, numero_de_contratacoes, numero_de_funcionarios)
{
  indice <- 0.0
  
  indice <- (numero_de_demissoes + numero_de_contratacoes) / (2 * numero_de_funcionarios)

  return (indice)  
}

resposta <- 0.0

numero_demissoes <- 100
numero_contratacoes <- 130
numero_funcionarios <- 2300

resposta <- calculaIndiceRotatividade(numero_demissoes, numero_contratacoes, numero_funcionarios)
print(paste("Indice de rotatividade da empresa:", resposta))