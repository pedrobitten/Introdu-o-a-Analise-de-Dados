calculaF <- function(x, y)
{
  resposta <- 0.0
  
  resposta <- 2 * (x^3) + (x^2) - 3 * y
  
  return (resposta)
}

calculaH <- function(x, y, z)
{
  resposta <- 0.0
  
  resposta <- ((x^2) * (y^4)) - 1.5 * (x^3) * (z^2) + 5
}

valorX_F <- 0.0
valorY_F <- 0.0
resposta_Fxy <- 0.0

valorX_F <- 3
valorY_F <- -2

resposta_Fxy <- calculaF(valorX_F, valorY_F)
print(paste("f(3, -2) = ", resposta_Fxy))

valorY_H <- 0.0
valorX_H <- 0.0
valorZ_H <- 0.0
resposta_Hxy <- 0.0

valorX_H <- 2
valorY_H <- -5
valorZ_H <- 3

resposta_Hxy <- calculaH(valorX_H, valorY_H, valorZ_H)
print(paste("h(2, -5, 3) = ", resposta_Hxy))


