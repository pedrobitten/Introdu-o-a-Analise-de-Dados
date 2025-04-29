#a)

x <- NULL

x <- seq(100, 799, 2)

#b)

media_x <- 0.0

media_x <- mean(x)

print(paste("Media do vetor x:", media_x))

#c)

xSelecionado <- NULL

for (cont in x)
{
  if (cont %% 10 == 0){
    xSelecionado <- c(xSelecionado, cont)
  }
}

#d)

soma <- 0

for (cont in x)
{
  soma <- soma + cont
  
  if (soma <= 400){
    print(paste("Soma dos elementos menores ou iguais a 400:", soma))
  }
  
  else if (soma >= 500 & soma < 780){
    print(paste("Soma dos elementos maiores ou iguais a 500 e menores que 780:", soma))  
  }
}

#e)

y <- NULL

y <- c(y, x[1:5], x[7:14], x[16:length(x)])
