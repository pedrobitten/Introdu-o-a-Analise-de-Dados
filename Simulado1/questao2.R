calculaF <- function(x, y)
{
  resposta <- 0.0
  
  resposta <- 2 * (x^3) + (x^2) - 3 * y
  
  return (resposta)
}

calculaH <- function(x, y, z)
{
  resposta <- 0.0
  
  resposta <- ((x^2) * (y^4)) - (1.5 * (x^3) * (z^2)) + 5
}

processaFluxograma <- function(x, y, z)
{
  peso <- 0.0
  retorno <- 0.0
  
  peso <- 2
  
  if (x > 0){ # x > 0 verdadeiro
    if (y >= 0){ # y >= 0 verdadeiro
      retorno <- calculaH(x, y, z)
      print(retorno)
      return (retorno)
    }
    
    else { # y >= 0 falso
      if (z > 0){ # z > 0 falso
        peso <- peso + 3
        retorno <- calculaF(x, y) + peso * calculaH(x, y, z)
        print(retorno)
        return (retorno)
      }
      
      else { # z > 0 falso
        retorno <- peso * calculaF(x, y) + calculaH(x, y, z)
        print(retorno)
        return (retorno)
      }
    }
  }
  
  else { # x > 0 falso
    peso <- peso + 1
    
    if (z > 0){ # z > 0 falso
      peso <- peso + 3
      retorno <- calculaF(x, y) + peso * calculaH(x, y, z)
      print(retorno)
      return (retorno)
    }
    
    else { # z > 0 falso
      retorno <- peso * calculaF(x, y) + calculaH(x, y, z)
      print(retorno)
      return (retorno)
    }
    
  }
}

vetorX <- NULL
vetorY <- NULL
vetorZ <- NULL
soma_das_trincas <- NULL
cont <- 0

vetorX <- seq(2, by = -0.8, length = 7)
vetorY <- c(3, -5, 7, -9, 5, 1, -3)
vetorZ <- -2 : 4
soma_das_trincas <- rep(0, length(vetorY))
cont <- 1

while (cont <= length(vetorX))
{
  soma_das_trincas[cont] <- processaFluxograma(vetorX[cont], vetorY[cont], vetorZ[cont])
  cont <- cont + 1
}

print(soma_das_trincas)
print(paste("Soma dos valores de cada uma das trincas:", sum(soma_das_trincas)))