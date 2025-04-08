#qst3

numero_de_dias <- 0
rendimentos_obtidos <- 0.0
imposto <- 0.0

rendimentos_obtidos <- 1000
numero_de_dias <- 15

imposto <- rendimentos_obtidos * 0.03 * (30 - numero_de_dias)
print(paste("Valor do imposto a ser pago:", imposto))